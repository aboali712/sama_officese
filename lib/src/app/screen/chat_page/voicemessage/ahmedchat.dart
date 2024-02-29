// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record_mp3/record_mp3.dart';
// import 'package:test_chat/app/auth/model/user_model.dart';
// import 'package:test_chat/app/chat_page/voicemessage/audiocontrol.dart';
//
// import '../../core/utils/colors_app.dart';
// import 'chatcontrol.dart';
//
// class VoiceChat extends StatefulWidget {
//   final UserModel data;
//   const VoiceChat({
//     Key? key,
//     required this.data,
//   }) : super(key: key);
//
//   @override
//   _VoiceChatState createState() => _VoiceChatState();
// }
//
// class _VoiceChatState extends State<VoiceChat> {
//   TextEditingController messageController = TextEditingController();
//
//   late ChatProvider chatProvider;
//   bool temp = false;
//   bool audio = false;
//   int _limit = 20;
//   int _limitIncrement = 20;
//   List<QueryDocumentSnapshot> listMessage = [];
//
//   Stream<QuerySnapshot>? chatMessageStream;
//   final ScrollController _scrollController = ScrollController();
//   String groupChatId = "";
//   bool isShowSticker = false;
//   final FocusNode focusNode = FocusNode();
//   String currentUserId = "";
//
//   AudioController audioController = Get.put(AudioController());
//   AudioPlayer audioPlayer = AudioPlayer();
//   String audioURL = "";
//   Future<bool> checkPermission() async {
//     if (!await Permission.microphone.isGranted) {
//       PermissionStatus status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   void startRecord() async {
//     bool hasPermission = await checkPermission();
//     if (hasPermission) {
//
//       recordFilePath = await getFilePath();
//       RecordMp3.instance.start(recordFilePath, (type) {
//         setState(() {});
//       });
//     } else {}
//     setState(() {});
//   }
//
//   void stopRecord() async {
//     bool stop = RecordMp3.instance.stop();
//     audioController.end.value = DateTime.now();
//     audioController.calcDuration();
//     var ap = AudioPlayer();
//     // await ap.play(AssetSource("Notification.mp3"));
//     ap.onPlayerComplete.listen((a) {});
//     if (stop) {
//       audioController.isRecording.value = false;
//       audioController.isSending.value = true;
//       await uploadAudio();
//     }
//   }
//
//   int i = 0;
//
//   Future<String> getFilePath() async {
//     Directory storageDirectory = await getApplicationDocumentsDirectory();
//     String sdPath =
//         "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
//     var d = Directory(sdPath);
//     if (!d.existsSync()) {
//       d.createSync(recursive: true);
//     }
//     return "$sdPath/test_${i++}.mp3";
//   }
//
//   uploadAudio() async {
//     UploadTask uploadTask = chatProvider.uploadAudio(File(recordFilePath),
//         "audio/${DateTime.now().millisecondsSinceEpoch.toString()}");
//     try {
//       TaskSnapshot snapshot = await uploadTask;
//       audioURL = await snapshot.ref.getDownloadURL();
//       String strVal = audioURL.toString();
//       setState(() {
//         audioController.isSending.value = false;
//         onSendMessage(strVal, TypeMessage.audio,
//             duration: audioController.total);
//       });
//     } on FirebaseException catch (e) {
//       setState(() {
//         audioController.isSending.value = false;
//       });
//       Fluttertoast.showToast(msg: e.message ?? e.toString());
//     }
//   }
//
//   late String recordFilePath;
//
//   void readLocal() async {
//     List<String> ids = [currentUserId, widget.data.id!];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//     var a = await FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId)
//         .collection('messages').get();
//     setState(() {
//       final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//       currentUserId = _firebaseAuth.currentUser!.uid;
//
//
//     });
//     String peerId = widget.data.id !;
//
//     if (currentUserId.compareTo(peerId) > 0) {
//       groupChatId = '$currentUserId-$peerId';
//     } else {
//       groupChatId = '$peerId-$currentUserId';
//     }
//     chatProvider.updateDataFirestore(
//       'chat',
//       currentUserId,
//       {'chattingWith': peerId},
//     );
//   }
//
//   void onSendMessage(String content, int type, {String? duration = ""}) {
//     if (content.trim().isNotEmpty) {
//       messageController.clear();
//       chatProvider.sendMessage(
//           content, type, groupChatId, currentUserId, widget.data.id.toString(),
//           duration: duration!);
//       _scrollController.animateTo(0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     } else {
//       Fluttertoast.showToast(
//           msg: 'Nothing to send', backgroundColor: Colors.grey);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     chatProvider = Get.put(ChatProvider(
//         firebaseFirestore: FirebaseFirestore.instance,
//         firebaseStorage: FirebaseStorage.instance));
//     focusNode.addListener(onFocusChange);
//     _scrollController.addListener(_scrollListener);
//     readLocal();
//   }
//
//   _scrollListener() {
//     if (_scrollController.offset >=
//         _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange &&
//         _limit <= listMessage.length) {
//       setState(() {
//         _limit += _limitIncrement;
//       });
//     }
//   }
//
//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(widget.data.name!,
//               style: GoogleFonts.tajawal(color: Colors.white)),
//           backgroundColor: mainColor,
//           automaticallyImplyLeading: true,
//         ),
//       body: Stack(
//         children: <Widget>[
//           Column(
//             children: [
//
//
//               buildListMessage(),
//               Obx(
//                     () => audioController.isSending.value
//                     ? Text(
//                   "Uploading Audio...",
//                   style: TextStyle(color: Colors.black),
//                 )
//                     : isLoading
//                     ? Text(
//                   "Uploading Image...",
//                   style: TextStyle(color: Colors.black),
//                 )
//                     : buildInput(),
//               )
//             ],
//           ),
//            buildLoading()
//         ],
//       ),
//     );
//   }
//
//   Widget buildLoading() {
//     return Positioned(
//       child: audioController.isSending.value
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : SizedBox.shrink(),
//     );
//   }
//
//   _incomingMSG(String a) {
//     return Align(
//       alignment: (Alignment.topLeft),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: mainColor.withOpacity(0.18)),
//         padding: const EdgeInsets.fromLTRB(18, 9, 18, 9),
//         child: Text(
//           a,
//           style: TextStyle(fontSize: 12, color: Color(0xff8A8A8A)),
//         ),
//       ),
//     );
//   }
//
//   File? imageFile;
//   bool isLoading = false;
//   String imageUrl = "";
//   Future getImage() async {
//     ImagePicker imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       imageFile = File(pickedFile.path);
//       if (imageFile != null) {
//         setState(() {
//           isLoading = true;
//         });
//         uploadFile();
//       }
//     }
//   }
//
//   Future uploadFile() async {
//     UploadTask uploadTask = chatProvider.uploadFile(imageFile!,
//         "image/${DateTime.now().millisecondsSinceEpoch.toString()}");
//     try {
//       TaskSnapshot snapshot = await uploadTask;
//       imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         isLoading = false;
//         onSendMessage(imageUrl, TypeMessage.image);
//       });
//     } on FirebaseException catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: e.message ?? e.toString());
//     }
//   }
//
//   Widget buildInput() {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
//         decoration: BoxDecoration(
//             color: mainColor.withOpacity(0.25),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         //height: 50,
//         child: TextField(
//           onSubmitted: (value) {
//             onSendMessage(messageController.text, TypeMessage.text);
//           },
//           controller: messageController,
//           focusNode: focusNode,
//           decoration: InputDecoration(
//               prefixIcon: Container(
//                 width: 80,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     GestureDetector(
//                       child: Icon(Icons.photo, color: mainColor),
//                       onTap: () {
//                         getImage();
//                       },
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     GestureDetector(
//                       child: Icon(Icons.mic,size: 25, color: mainColor),
//                       onLongPress: ()  async {
//                         audioController.start.value = DateTime.now();
//                         startRecord();
//                         audioController.isRecording.value = true;
//
//
//                         // print("object");
//                         // var audioPlayer = AudioPlayer();
//                         // await audioPlayer.play(AssetSource("Notification.mp3"));
//                         //
//                         // audioPlayer.onPlayerComplete.listen((a) {
//                         //   audioController.start.value = DateTime.now();
//                         //   startRecord();
//                         //   audioController.isRecording.value = true;
//                         // });
//
//                       },
//                       onLongPressEnd: (details) {
//                         stopRecord();
//                       },
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//               ),
//               suffixIcon: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 child: GestureDetector(
//                   child: Icon(Icons.send, color: mainColor),
//                   onTap: () =>
//                       onSendMessage(messageController.text, TypeMessage.text),
//                 ),
//               ),
//               hintText: audioController.isRecording.value
//                   ? "Recording audio..."
//                   : "Your message...",
//               contentPadding:
//               EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               hintStyle: TextStyle(color: Color(0xff8A8A8A), fontSize: 15),
//               border: InputBorder.none),
//         ),
//       ),
//     );
//   }
//
//   _outgoingMSG(String a) {
//     return Align(
//       alignment: Alignment.topRight,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: mainColor,
//         ),
//         padding: const EdgeInsets.fromLTRB(18, 9, 18, 9),
//         child: Text(
//           a,
//           style: TextStyle(fontSize: 12, color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   Widget buildListMessage() {
//     return Flexible(
//       child: groupChatId.isNotEmpty
//           ? StreamBuilder<QuerySnapshot>(
//         stream: chatProvider.getChatStream(groupChatId, _limit),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             listMessage = snapshot.data!.docs;
//             if (listMessage.isNotEmpty) {
//               return ListView.builder(
//                 padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
//                 itemBuilder: (context, index) =>
//                     buildItem(index, snapshot.data?.docs[index]),
//                 itemCount: snapshot.data?.docs.length,
//                 reverse: true,
//                 controller: _scrollController,
//               );
//             } else {
//               return Center(
//                   child: Text(
//                     "No message here yet...",
//                     style: TextStyle(color: Colors.black),
//                   ));
//             }
//           }
//           else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       )
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   Widget _audio({
//     required String message,
//     required bool isCurrentUser,
//     required int index,
//     required String time,
//     required String duration,
//   }) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.5,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: isCurrentUser ? mainColor : mainColor.withOpacity(0.18),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               audioController.onPressedPlayButton(index, message);
//               // changeProg(duration: duration);
//             },
//             onSecondaryTap: () {
//               audioPlayer.stop();
//               //   audioController.completedPercentage.value = 0.0;
//             },
//             child: Obx(
//                   () => (audioController.isRecordPlaying &&
//                   audioController.currentId == index)
//                   ? Icon(
//                 Icons.cancel,
//                 color: isCurrentUser ? Colors.white : mainColor,
//               )
//                   : Icon(
//                 Icons.play_arrow,
//                 color: isCurrentUser ? Colors.white : mainColor,
//               ),
//             ),
//           ),
//           Obx(
//                 () => Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   alignment: Alignment.center,
//                   children: [
//                     // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
//                     LinearProgressIndicator(
//                       minHeight: 5,
//                       backgroundColor: Colors.grey,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         isCurrentUser ? Colors.white : mainColor,
//                       ),
//                       value: (audioController.isRecordPlaying &&
//                           audioController.currentId == index)
//                           ? audioController.completedPercentage.value
//                           : audioController.totalDuration.value.toDouble(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             duration,
//             style: TextStyle(
//                 fontSize: 12, color: isCurrentUser ? Colors.white : mainColor),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildItem(int index, DocumentSnapshot? document) {
//     if (document != null) {
//       MessageChat messageChat = MessageChat.fromDocument(document);
//       if (messageChat.idFrom == currentUserId) {
//         // Right (my message)
//         return Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // Text
//               if (messageChat.type == TypeMessage.text)
//                 _outgoingMSG(messageChat.content),
//               // Image
//               if (messageChat.type == TypeMessage.image)
//                 // Container(height: 100,width: 100,decoration:
//                 // BoxDecoration(border: Border.all(color: Colors.black,width: .5)),),
//
//
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
//                   height:  MediaQuery.of(context).size.height/2,
//                   width:MediaQuery.of(context).size.width-20 ,
//                   alignment :(messageChat.idFrom != widget.data.id)?
//                   Alignment.centerRight
//                       :Alignment.centerLeft,
//                   child:  Container(
//                     height: MediaQuery.of(context).size.height/2.5,
//                     width:MediaQuery.of(context).size.width/2 ,
//                     decoration: BoxDecoration(border: Border.all(width: .5)),
//                     alignment:messageChat.content!=""?null: Alignment.center,
//                     child:
//                     messageChat.content!=""?
//
//                     Image.network(messageChat.content,fit:BoxFit.cover ,)
//                         : const CircularProgressIndicator()
//                     ,
//                   ),
//                 ),
//
//
//
//
//
//
//               if (messageChat.type == TypeMessage.audio)
//                 _audio(
//                     message: messageChat.content,
//                     isCurrentUser: messageChat.idFrom == currentUserId,
//                     index: index,
//                     time: messageChat.timestamp.toString(),
//                     duration: messageChat.duration.toString())
//             ],
//           ),
//         );
//       } else {
//         // Left (peer message)
//         return Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: <Widget>[
//                   isLastMessageLeft(index)
//                       ? Material(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(18),
//                     ),
//                     clipBehavior: Clip.hardEdge,
//                     child: Container(color: mainColor),
//                   )
//                       : Container(),
//                   if (messageChat.type == TypeMessage.text)
//                     _incomingMSG(messageChat.content),
//                   if (messageChat.type == TypeMessage.image)
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
//                       height:  MediaQuery.of(context).size.height/2,
//                       width:MediaQuery.of(context).size.width /2,
//                       alignment :(messageChat.idFrom != widget.data.id)?
//                       Alignment.centerRight
//                           :Alignment.centerLeft,
//                       child:  Container(
//                         height: MediaQuery.of(context).size.height/2.5,
//                         width:MediaQuery.of(context).size.width/2 ,
//                         decoration: BoxDecoration(border: Border.all(width: .5)),
//                         alignment:messageChat.content!=""?null: Alignment.center,
//                         child:
//                         messageChat.content!=""?
//
//                         Image.network(messageChat.content,fit:BoxFit.cover ,)
//                             : const CircularProgressIndicator()
//                         ,
//                       ),
//                     ),
//
//
//
//                   if (messageChat.type == TypeMessage.audio)
//                     _audio(
//                         message: messageChat.content,
//                         isCurrentUser: messageChat.idFrom == currentUserId,
//                         index: index,
//                         time: messageChat.timestamp.toString(),
//                         duration: messageChat.duration.toString())
//                 ],
//               ),
//
//               // Time
//               isLastMessageLeft(index)
//                   ? Container(
//                 margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
//                 child: Text(
//                   DateFormat('dd MMM kk:mm').format(
//                       DateTime.fromMillisecondsSinceEpoch(
//                           int.parse(messageChat.timestamp))),
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 12,
//                       fontStyle: FontStyle.italic),
//                 ),
//               )
//                   : SizedBox.shrink()
//             ],
//           ),
//         );
//       }
//     } else {
//       return SizedBox.shrink();
//     }
//   }
//
//   bool isLastMessageLeft(int index) {
//     if ((index > 0 && listMessage[index - 1].get("idFrom") == currentUserId) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   bool isLastMessageRight(int index) {
//     if ((index > 0 && listMessage[index - 1].get("idFrom") != currentUserId) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }