import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/chat_page/show_chat_image.dart';

import 'package:siri_wave/siri_wave.dart';

import '../../core/network/network_service.dart';
import '../../core/values/colors.dart';
import '../../home_core.dart';
import '../home/home_viewmodel.dart';
import '../home/packages_order/packages_order_viewmodel.dart';
import 'chatBuble.dart';
import 'chat_view_model.dart';
import 'dart:ui' as ui;


class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ChatViewModel {
  late StreamSubscription<DatabaseEvent> messagesSubscriptions;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChatViewModel.bookingId;

    return
      WillPopScope(
        onWillPop: () async {
          if(ChatViewModel.pageNu==1){
            setState(() {
              HomeCorePage.index=0;
            });
            SamaOfficeApp.navKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => HomeCore(),));
            setState(() {
              ChatViewModel.pageNu=0;
            });
          }

          return true;
        },
          child: Scaffold(
            backgroundColor:Colors.white,
            appBar:  _buildAppBar(),
            body:  CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: Platform.isIOS ? size.height - 200 : size.height - 160,
                              child: Stack(
                                children: [
                                  // Check if the message list is empty
                                  isEmpty ? _buildOfferDetails() : _buildMessageList(),
                                  _buildMoreOptions()
                                ],
                              ),
                            ),
                            Center(
                              child: Obx(
                                    () => audioController.isSending.value
                                    ? const Text("Uploading Audio...", style: TextStyle(color: Colors.black))
                                    : isLoading
                                    ? const Text("Uploading Image...", style: TextStyle(color: Colors.black))
                                    : _buildInput(),
                              ),
                            ),
                          ],
                        ),
                        _buildLoadingIndicator(size),
                      ],
                    ),
                  ),
                ]),
          ),
        );
  }

  /// Builds the AppBar widget with a centered title and custom styling
  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white, // Icon color
      ),
      title: Text(
        "${tr("OrderNumber")} ${ChatViewModel.bookingId}",
        style: GoogleFonts.tajawal(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: samaColor,
      automaticallyImplyLeading: false, // Disable the automatic back arrow
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {

          if(ChatViewModel.pageNu==1){
            setState(() {
              HomeCorePage.index=0;
            });
            SamaOfficeApp.navKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => HomeCore(),));
            setState(() {
              ChatViewModel.pageNu=0;
            });
          }else{
            Navigator.pop(context);
          }

        },
      ),

    );

  }

  /// Builds the widget that displays additional options (photo, location, attachment)
  Widget _buildMoreOptions() {
    // Check if more options should be displayed
    if (moreStatus != 1) return const SizedBox.shrink();

    return Positioned(
      right: 15,
      bottom: 20,
      height: 150,
      width: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOptionButton(
            icon: Icons.photo,
            color: Colors.blue.shade300,
            onTap: () {
              getImage();
              setState(() {
                moreStatus = 0;
              });
            },
          ),
          _buildOptionButton(
            icon: Icons.location_on,
            color: Colors.red,
            onTap: () {
              showPlacePicker();
              setState(() {
                moreStatus = 0;
              });
            },
          ),
          _buildOptionButton(
            icon: Icons.attach_file,
            color: Colors.blue.shade300,
            onTap: () {
              // Handle file attachment
            },
          ),
        ],
      ),
    );
  }

  /// Helper method to create an option button with icon, color, and tap action
  Widget _buildOptionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(color: color, width: 0.4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 25,
          ),
        ),
      ),
    );
  }


  /// Builds the message list widget that displays chat messages in real-time
  Widget _buildMessageList() {
    String chatRoomId = ChatViewModel.bookingId;
    var database = FirebaseDatabase.instance;
    var msgQury = database.ref("chat_rooms/$chatRoomId");
    var snapshot = msgQury.orderByChild("timestamp");
    messagesSubscriptions = snapshot.onChildAdded.listen(
          (DatabaseEvent event) {
            if(firstTime==0){
              scrollDown();
              setState(() {
                firstTime=1;
              });
            }

            setState(() {
              listen=0;
            });

            if(listen==0){
              DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
              DatabaseReference messagesRef = databaseReference.child(NetworkService.baseUrl1.contains("test.")?'chat_rooms_test':'chat_rooms');
              messagesRef.get().then((allChats) {
                allChats.children.forEach((allThreads) {
                  if (allThreads.key!.contains(event.snapshot.ref.key.toString()) ) {
                    allThreads.children.forEach((message) async {

                     if(message.child('senderId').value.toString()!=HomeViewModel.profileModel!.office!.id.toString()){
                      // print(message.child('senderId').value.toString());
                        await   message.ref.child('isReadOffice').set(1);
                      }

                    });
                  }
                });
              });

            }

            setState(() {
              listen=1;
            });


      },

      // onError: (Object o) {
      //   final error = o as FirebaseException;
      //   // print('Error: ${error.code} ${error.message}');
      // },
    );


    return FirebaseAnimatedList(
      reverse: false,
      controller: scrollController,
      query: msgQury,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return Column(
          children: [
            index == 0 ? _buildOfferDetails() : const SizedBox.shrink(),
            SizedBox(height: index == 0 ? 20 : 0,),
            _buildMessageItem( index, snapshot),
          ],
        );
      },
    );


  }


  /// Builds a message item based on the message type (text, image, location, or audio)
  Widget _buildMessageItem(int index, DataSnapshot? document) {
    var data = document!;
    var alignment = (data.child("senderId").value.toString() ==
        HomeViewModel.profileModel!.office!.id.toString())
        ? Alignment.centerRight
        : Alignment.centerLeft;


    return (data.child("type").value.toString() == "text")
        ? Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
            (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.office!.id.toString())
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.office!.id.toString())
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              (data.child("senderId").value.toString() !=
                  HomeViewModel.profileModel!.office!.id.toString())
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ChatBubble(
                      message:
                      data.child("message").value.toString()),
                  const SizedBox(
                    width: 3,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://www.smashingmagazine.com/images/authors/guest-author.jpg",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  ChatBubble(
                      message:
                      data.child("message").value.toString()),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(builder: (context) {
                var parsed = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(data.child("timestamp").value.toString()));
                var dateFormat = DateFormat.yMd().add_jm();
                var formatted = dateFormat.format(parsed).toString();

                // String formDate= DateTime.fromMillisecondsSinceEpoch(
                //     int.parse(data.child("timestamp").value.toString()), isUtc: true).toString();

                return Text(
                  formatted,
                  style: GoogleFonts.tajawal(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade500),
                );
              }),
            ]),
      ),
    )
        : (data.child("type").value.toString() == "img")
        ? Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      alignment:   (data.child("senderId").value.toString() ==
          HomeViewModel.profileModel!.office!.id.toString())
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(border: Border.all(width: .5)),
        alignment: data.child("message").value.toString() != ""
            ? null
            : Alignment.center,
        child: data.child("message").value.toString() != ""
            ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowImage(
                        imageUrl: data
                            .child("message")
                            .value
                            .toString(),
                      )));
            },
            child: Image.network(
              data.child("message").value.toString(),
              fit: BoxFit.cover,
            ))
            : const CircularProgressIndicator(),
      ),
    )
        : data.child("type").value.toString() == "location"
        ? Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
            (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.office!.id.toString())
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment:
            (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.office!.id.toString())
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              (data.child("senderId").value.toString() !=
                  HomeViewModel.profileModel!.office!.id.toString())
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 150,
                    width: 220,
                    padding: const EdgeInsets.only(
                        top: 3,
                        left: 3,
                        right: 3,
                        bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Builder(builder: (context) {
                        String gg = data
                            .child("message")
                            .value
                            .toString();
                        List<String> list = gg.split(",");

                        double latitude =
                        double.parse(list[0]);
                        double longitude =
                        double.parse(list[1]);


                        return ClipRRect(
                          borderRadius:
                          const BorderRadius.all(
                              Radius.circular(10)),
                          child: GoogleMap(
                            onTap: (argument) {
                              MapsLauncher
                                  .launchCoordinates(
                                  double.parse(list[0]),
                                  double.parse(
                                      list[1]));
                            },
                            zoomGesturesEnabled: false,
                            myLocationEnabled: false,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            initialCameraPosition:
                            CameraPosition(
                              target: LatLng(
                                  latitude, longitude),
                              zoom: 13.5,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId(
                                    "source"),
                                position: LatLng(
                                    latitude, longitude),
                              ),
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      (data
                          .child("senderId")
                          .value
                          .toString() ==
                          HomeViewModel.profileModel!.office!.id.toString())
                          ? "https://www.smashingmagazine.com/images/authors/guest-author.jpg"
                          : "https://www.smashingmagazine.com/images/authors/guest-author.jpg",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      (data
                          .child("senderId")
                          .value
                          .toString() ==
                          HomeViewModel.profileModel!.office!.id.toString())
                          ? "https://www.smashingmagazine.com/images/authors/guest-author.jpg"
                          : "https://www.smashingmagazine.com/images/authors/guest-author.jpg",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 150,
                    width: 220,
                    padding: const EdgeInsets.only(
                        top: 3,
                        left: 3,
                        right: 3,
                        bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: const Color(0xffD9FDD3),
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Builder(builder: (context) {
                        String gg = data
                            .child("message")
                            .value
                            .toString();
                        List<String> list = gg.split(",");


                        double latitude =
                        double.parse(list[0]);
                        double longitude =
                        double.parse(list[1]);


                        return ClipRRect(
                          borderRadius:
                          const BorderRadius.all(
                              Radius.circular(10)),
                          child: GoogleMap(
                            onTap: (argument) {
                              MapsLauncher
                                  .launchCoordinates(
                                  double.parse(list[0]),
                                  double.parse(
                                      list[1]));
                            },
                            zoomGesturesEnabled: false,
                            myLocationEnabled: false,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            initialCameraPosition:
                            CameraPosition(
                              target: LatLng(
                                  latitude, longitude),
                              zoom: 13.5,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId(
                                    "source"),
                                position: LatLng(
                                    latitude, longitude),
                              ),
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(builder: (context) {
                var parsed = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(data
                        .child("timestamp")
                        .value
                        .toString()));
                var dateFormat = DateFormat.yMd().add_jm();
                var formatted =
                dateFormat.format(parsed).toString();


                return Text(
                  formatted,
                  style: GoogleFonts.tajawal(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade500),
                );
              }),
            ]),
      ),
    )
        : _audio1(
        message: data.child("message").value.toString(),
        isCurrentUser: data.child("senderId").value.toString(),
        index: int.parse(data.child("timestamp").value.toString()),
        timestamp: data.child("timestamp").value.toString(),
        duration: data.child("duration").value.toString(),
        time: data.child("timestamp").value.toString());
  }

  /// Builds a widget to display an audio message
  Widget _audio1({
    required String message,
    required String isCurrentUser,
    required int index,
    required String time,
    required String duration,
    required timestamp,
  }) {
    return isCurrentUser != HomeViewModel.profileModel!.office!.id.toString()
        ? Container(
      alignment: (isCurrentUser == HomeViewModel.profileModel!.office!.id.toString())
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 80,left: 5,top: 5,bottom: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCurrentUser == HomeViewModel.profileModel!.office!.id.toString()
            ?  samaColor.withOpacity(0.6)
            : samaColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                duration,
                style: TextStyle(
                    fontSize: 12,
                    color: isCurrentUser == HomeViewModel.profileModel!.office!.id.toString()
                        ? Colors.black
                        : samaColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(
                    () => SizedBox(
                  width: 140,
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCurrentUser == HomeViewModel.profileModel!.office!.id.toString()
                          ? Colors.white
                          : samaColor,
                    ),
                    value: (audioController.isRecordPlaying &&
                        audioController.currentId == index)
                        ? audioController.completedPercentage.value
                        : audioController.totalDuration.value
                        .toDouble(),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),

              GestureDetector(
                onTap: () {
                  audioController.onPressedPlayButton(index, message);
                  // changeProg(duration: duration);
                },
                onSecondaryTap: () {
                  audioPlayer.stop();
                  //   audioController.completedPercentage.value = 0.0;
                },
                child: Obx(
                      () => (audioController.isRecordPlaying &&
                      audioController.currentId == index)
                      ? Icon(
                    Icons.cancel,
                    color: isCurrentUser ==
                        HomeViewModel.profileModel!.office!.id.toString()
                        ? Colors.white
                        : samaColor,
                  )
                      : Icon(
                    Icons.play_arrow,
                    color: isCurrentUser ==
                        HomeViewModel.profileModel!.office!.id.toString()
                        ? Colors.white
                        : samaColor,
                  ),
                ),
              ),


            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              (isCurrentUser == HomeViewModel.profileModel!.office!.id.toString())
                  ? "https://www.smashingmagazine.com/images/authors/guest-author.jpg"
                  : "https://www.smashingmagazine.com/images/authors/guest-author.jpg",
              width: 25,
              height: 25,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    )
        : Container(
      alignment: (isCurrentUser == HomeViewModel.profileModel!.office!.id.toString())
          ? Alignment.centerRight
          : Alignment.centerLeft,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 80,right: 5,top: 5,bottom: 5),
      decoration: BoxDecoration(
        color: isCurrentUser == HomeViewModel.profileModel!.office!.id.toString()
            ? samaColor
            : samaColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              (isCurrentUser == HomeViewModel.profileModel!.office!.id.toString())
                  ? "https://www.smashingmagazine.com/images/authors/guest-author.jpg"
                 : "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
              width: 25,
              height: 25,
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {
              audioController.onPressedPlayButton(index, message);
              // changeProg(duration: duration);
            },
            onSecondaryTap: () {
              audioPlayer.stop();
              //   audioController.completedPercentage.value = 0.0;
            },
            child: Obx(
                  () => (audioController.isRecordPlaying &&
                  audioController.currentId == index)
                  ? Icon(
                Icons.cancel,
                color: isCurrentUser ==
                    HomeViewModel.profileModel!.office!.id.toString()
                    ? Colors.white
                    : samaColor,
              )
                  : Icon(
                Icons.play_arrow,
                color: isCurrentUser ==
                    HomeViewModel.profileModel!.office!.id.toString()
                    ? Colors.white
                    : samaColor,
              ),
            ),
          ),
          Obx(
                () => Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCurrentUser ==
                          HomeViewModel.profileModel!.office!.id.toString()
                          ? Colors.white
                          : samaColor,
                    ),
                    value: (audioController.isRecordPlaying &&
                        audioController.currentId == index)
                        ? audioController.completedPercentage.value
                        : audioController.totalDuration.value
                        .toDouble(),
                  ),
                ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            duration,
            style: TextStyle(
                fontSize: 12,
                color: isCurrentUser != HomeViewModel.profileModel!.office!.id.toString()
                    ? Colors.black
                    : Colors.white),
          ),
        ],
      ),
    );
  }


  /// Builds the input area widget, allowing users to type messages or record audio
  Widget _buildInput() {
    Size size = MediaQuery.of(context).size;
    return viewRecord==1?
    Container(
      height: 70,

      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Icon(
            Icons.mic,
            size: 35,
            color: Colors.blue.shade300,
          ),

          SiriWaveform.ios9(
            controller: IOS9SiriWaveformController(
              amplitude: 1,
              speed: 0.10,
            ),
            options: const IOS9SiriWaveformOptions(
              height: 100,
              width: 230,
            ),
          ),

          InkWell(
            onTap: () {
              stopRecord();
              setState(() {
                viewRecord=0;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: samaColor),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    )

        : Container(
      color: const Color(0xFFF9F9F9),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (moreStatus == 0) {
                setState(() {
                  moreStatus = 1;
                });
              } else {
                setState(() {
                  moreStatus = 0;
                });
              }
            },
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.red.shade400,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]),
              child: moreStatus == 0
                  ? const Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              )
                  : const Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 270,
            child: TextField(
              controller: ChatViewModel.messageControl,
              style: const TextStyle(height: 1.1,fontSize: 14),
              // textAlign: TextAlign.left,
              // keyboardType: TextInputType.text,
              maxLines: null,
              textAlign: TextAlign.right,
              textDirection: ui.TextDirection.rtl,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                // fillColor: Colors.red,
                  prefixIcon: GestureDetector(
                    child: const Icon(Icons.mic,
                        size: 30, color: samaColor),
                    onTap: () async {
                      audioController.start.value = DateTime.now();
                      startRecord();
                      setState(() {
                        viewRecord=1;
                        audioController.isRecording.value = true;
                      });

                    },
                    // onLongPressEnd: (details) {
                    //   stopRecord();
                    // },
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: audioController.isRecording.value
                      ? "Recording audio..."
                      : "Your message...",
                  hintStyle: GoogleFonts.tajawal(
                    color: Colors.grey,
                  )),
              onChanged: (value) {
                // do something
              },
            ),
          ),
          IconButton(
              style: IconButton.styleFrom(
                  backgroundColor: samaColor
              ),
              onPressed: () {
                sendMessage();
                checkIfQueryIsEmpty();
              },
              icon: const Icon(
                Icons.send,
                size: 25,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

/// Build offer details at the top of the chat screen
  Widget _buildOfferDetails() {
    return offerDetailsModel != null
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 50,),
        Container(
          width: MediaQuery.of(context).size.width - 105,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              Image.network(
                offerDetailsModel!.image.toString(),
                height: 130,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  offerDetailsModel!.name.toString(),
                                  style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                  height: 20,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.grey.shade200
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        offerDetailsModel!.office_rate.toString(),
                                        style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 13
                                        ),
                                      ),
                                      const SizedBox(width: 2,),
                                      const Icon(Icons.star, color: Color(0xffFFC635), size: 18,)
                                    ],
                                  )
                              )
                            ],
                          ),
                          Text(
                            "${offerDetailsModel!.numOfDays!} ${tr("Days")} ${offerDetailsModel!.num_of_nights!} ${tr("Nights")}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Color(0xffF0F0EF),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tr("Hello")} ${HomeViewModel.profileModel!.firstName.toString()} ;",
                            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            tr("ICongratulate"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Color(0xffF0F0EF),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("WeHaveOnlyDays"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            tr("StepnConfirmTheTripdateForUs"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tr("StepnSendUsThePassportPhotos"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            tr("AndWithThatWithoutAnyIssues"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            tr("ThisIsThe920031518"),
                            style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.blue),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      )
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 5,),
        Container(
          height: 45, width: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 1, color: const Color(0xff043C7C))
          ),
          child: SvgPicture.asset(
            "assets/images/logo1.svg", height: 18, width: 18,
          ),
        ),
        const SizedBox(width: 5,),
      ],
    ) : const SizedBox.shrink();
  }

/// Build the loading indicator when data is being fetched
  Widget _buildLoadingIndicator(Size size) {
    return isLoad == true
        ? SizedBox(
      height: size.height / 1.2,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xff043C7C),
        ),
      ),
    ) : const SizedBox.shrink();
  }
}
