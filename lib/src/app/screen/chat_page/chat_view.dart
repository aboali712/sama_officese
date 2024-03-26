import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:sama_officese/src/app/screen/chat_page/show_chat_image.dart';

import 'package:siri_wave/siri_wave.dart';

import '../../core/values/colors.dart';
import '../home/home_viewmodel.dart';
import '../home/packages_order/packages_order_viewmodel.dart';
import 'chatBuble.dart';
import 'chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ChatViewModel {
  late StreamSubscription<DatabaseEvent> messagesSubscriptions;

  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          backgroundColor:Colors.white,
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            title:   Text(
              "${tr("OrderNumber")} ${PackagesOrderViewModel.bookingId}"..toString(),
              style: GoogleFonts.tajawal(
                  fontSize: 15,
                  color:Colors.white,
                  fontWeight:
                  FontWeight.w500),
            ),
            backgroundColor: samaColor,
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Platform.isIOS?
                  MediaQuery.of(context).size.height-200
                      :MediaQuery.of(context).size.height-150,

                  child: Stack(children: [
                    _buildMessageList(),
                    moreStatus == 1
                        ? Positioned(
                        right: 15,
                        bottom: 20,
                        height: 150,
                        width: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                getImage();
                                setState(() {
                                  moreStatus = 0;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue.shade300, width: .4),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(1, 1))
                                      ]),
                                  child: Center(
                                    child: Icon(
                                      Icons.photo,
                                      color: Colors.blue.shade300,
                                      size: 25,
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                // getCurrentLocation().then((value) async {
                                //   if(currentPosition!.longitude.toString().isNotEmpty){
                                //
                                //     // var mess='https://www.google.com/maps/search/?api=1&query=${currentPosition!.latitude},${currentPosition!.longitude}';
                                //
                                //     double lat = currentPosition!.latitude;
                                //     double long = currentPosition!.longitude;
                                //    String mess="$lat, $long";
                                //
                                //     await   chatServices.sendMessage(ChatViewModel.user.toString(),mess,"location",duration: audioController.total);
                                //
                                //   }
                                // });

                                showPlacePicker();

                                setState(() {
                                  moreStatus = 0;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue.shade300, width: .4),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(1, 1))
                                      ]),
                                  child: const Center(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue.shade300, width: .4),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(1, 1))
                                      ]),
                                  child: Center(
                                    child: Icon(
                                      Icons.attach_file,
                                      color: Colors.blue.shade300,
                                      size: 25,
                                    ),
                                  )),
                            ),
                          ],
                        ))
                        : const SizedBox.shrink(),
                  ]),
                ),
                Center(
                  child: Obx(
                        () => audioController.isSending.value
                        ?  Text(
                      "Uploading Audio...",
                      style: TextStyle(color: Colors.black),
                    )
                        : isLoading
                        ?  Text(
                      "Uploading Image...",
                      style: TextStyle(color: Colors.black),
                    )
                        : _buildInput(),
                  ),
                )
              ],
            ),
          ),
        );
  }

  Widget _buildMessageList() {
    String chatRoomId = PackagesOrderViewModel.bookingId;

    var database = FirebaseDatabase.instance;
    var msgQury = database.ref("chat_rooms/$chatRoomId");

    var snapshot = msgQury.orderByChild("timestamp");

    messagesSubscriptions = snapshot.onChildAdded.listen(
          (DatabaseEvent event) {
        // print('Child added: ${event.snapshot.value}');
            scrollDown();
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
        return Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: false,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                itemBuilder: (context, index) => _buildMessageItem(
                    index, snapshot),
                itemCount: 1,
                reverse: true,
              ),
            ),
          ),
        ]);
      },
    );

    // return
    //
    //   StreamBuilder<QuerySnapshot>(
    //     stream: chatServices.getMessage(ChatViewModel.user!,_firebaseAuth.currentUser!.uid),
    //
    //     builder: (context , snapshot){
    //       if(snapshot.hasError){
    //         return Text("Erorr${snapshot.error}");
    //       }
    //       if(snapshot.connectionState==ConnectionState.waiting){
    //         return const Text("Loading...");
    //       }
    //       return ListView.builder(
    //         padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
    //         itemBuilder: (context, index) =>
    //             _buildMessageItem(index, snapshot.data?.docs[index]),
    //         itemCount: snapshot.data?.docs.length,
    //         reverse: true,
    //     );
    //
    //
    //
    //     });
  }

  Widget _buildMessageItem(int index, DataSnapshot? document) {
    var data = document!;
    var alignment = (data.child("senderId").value.toString() ==
        HomeViewModel.profileModel!.id.toString())
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
                HomeViewModel.profileModel!.id.toString())
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.id.toString())
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              (data.child("senderId").value.toString() !=
                  HomeViewModel.profileModel!.id.toString())
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
          HomeViewModel.profileModel!.id.toString())
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
                HomeViewModel.profileModel!.id.toString())
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment:
            (data.child("senderId").value.toString() !=
                HomeViewModel.profileModel!.id.toString())
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              (data.child("senderId").value.toString() !=
                  HomeViewModel.profileModel!.id.toString())
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
                          HomeViewModel.profileModel!.id.toString())
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
                          HomeViewModel.profileModel!.id.toString())
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
        index: index,
        timestamp: data.child("timestamp").value.toString(),
        duration: data.child("duration").value.toString(),
        time: data.child("timestamp").value.toString());
  }

  Widget _audio1({
    required String message,
    required String isCurrentUser,
    required int index,
    required String time,
    required String duration,
    required timestamp,
  }) {
    return isCurrentUser != HomeViewModel.profileModel!.id.toString()
        ? Container(
      alignment: (isCurrentUser == HomeViewModel.profileModel!.id.toString())
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 80,left: 5,top: 5,bottom: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCurrentUser == HomeViewModel.profileModel!.id.toString()
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
                    color: isCurrentUser == HomeViewModel.profileModel!.id.toString()
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
                      isCurrentUser == HomeViewModel.profileModel!.id.toString()
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
                        HomeViewModel.profileModel!.id.toString()
                        ? Colors.white
                        : samaColor,
                  )
                      : Icon(
                    Icons.play_arrow,
                    color: isCurrentUser ==
                        HomeViewModel.profileModel!.id.toString()
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
              (isCurrentUser == HomeViewModel.profileModel!.id.toString())
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
      alignment: (isCurrentUser == HomeViewModel.profileModel!.id.toString())
          ? Alignment.centerRight
          : Alignment.centerLeft,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 80,right: 5,top: 5,bottom: 5),
      decoration: BoxDecoration(
        color: isCurrentUser == HomeViewModel.profileModel!.id.toString()
            ? samaColor
            : samaColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              (isCurrentUser == HomeViewModel.profileModel!.id.toString())
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
                    HomeViewModel.profileModel!.id.toString()
                    ? Colors.white
                    : samaColor,
              )
                  : Icon(
                Icons.play_arrow,
                color: isCurrentUser ==
                    HomeViewModel.profileModel!.id.toString()
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
                          HomeViewModel.profileModel!.id.toString()
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
                color: isCurrentUser != HomeViewModel.profileModel!.id.toString()
                    ? Colors.black
                    : Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    Size size = MediaQuery.of(context).size;
    return viewRecord==1?
    Container(
      height: 70,

      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),

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
              style: const TextStyle(height: .6),
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
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
}
