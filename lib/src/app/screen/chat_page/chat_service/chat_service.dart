import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue, Timestamp;
import 'package:dio/dio.dart';


import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';

import '../../../../app.dart';
import '../../home/packages_order/packages_order_viewmodel.dart';
import '../chat_view_model.dart';






class ChatServices extends ChangeNotifier {



  final databaseReference  = FirebaseFirestore.instance;
  Future<void> sendMessage( String message,String type,{String? duration = ""}) async {

    final Timestamp timestamp = Timestamp.now();

    String chatRoomId =PackagesOrderViewModel.bookingId;

    print(timestamp.toDate().toString());

    DatabaseReference ref = FirebaseDatabase.instance.ref("chat_rooms").child(chatRoomId)

          .child(DateTime.now().millisecondsSinceEpoch.toString());




    await ref.set(
        {
      'senderId':HomeViewModel.profileModel!.id,
          'senderEmail': HomeViewModel.profileModel!.email,
      'receverId':PackagesOrderViewModel.userId,
      'type':type,
      'message':message,
      'timestamp':DateTime.now().millisecondsSinceEpoch,
          "duration": duration
        }
    );
    ChatViewModel.messageControl.clear();



    Map<String,String> headers = {'Content-Type':'application/json'};
    Map mp={};
    mp["type"]="user";
    mp["userId"]=PackagesOrderViewModel.userId;
    mp["officeId"]=PackagesOrderViewModel.userMdole!.office!.id.toString();
    mp["bookingId"]=PackagesOrderViewModel.bookingId;


    final response = await dio.post( "v1/sendMessage",options: Options(headers: headers), data:(mp), );



    //
    // await _firestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomId)
    //     .collection('messages')
    //     .add(messageModel.toMap());
  }


  Future<DataSnapshot>  getMessage(String userId,String otherUserId)  async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('chat_rooms').child(chatRoomId)
        .orderByChild("timestamp").get();
    if (snapshot.exists) {
      // print(snapshot.value);
    } else {
      print('No data available.');
    }
    return snapshot;

    // return _firestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomId)
    //     .collection('messages')
    //     .orderBy('timestamp',descending: true).snapshots();



  }

}


