import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue, Timestamp;
import 'package:dio/dio.dart';


import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';

import '../../../../app.dart';
import '../../home/packages_order/packages_order_viewmodel.dart';






class ChatServices extends ChangeNotifier {



  final databaseReference  = FirebaseFirestore.instance;
  Future<void> sendMessage( String message,String type,{String? duration = ""}) async {

    final Timestamp timestamp = Timestamp.now();




    String chatRoomId =PackagesOrderViewModel.bookingId;

    print(timestamp.toDate().toString());

    DatabaseReference ref = FirebaseDatabase.instance.ref("chat_rooms").child(chatRoomId)
        .child('messages')
          .child(DateTime.now().millisecondsSinceEpoch.toString());




    await ref.set(
        {
      'senderId':PackagesOrderViewModel.userMdole!.id,
          'senderEmail': PackagesOrderViewModel.userMdole!.email,
      'receverId':PackagesOrderViewModel.userId,
      'type':type,
      'message':message,
      'timestamp':DateTime.now().millisecondsSinceEpoch,
          "duration": duration
        }
    );

    Map<String,String> headers = {'Content-Type':'application/json'};
    Map mp={};
    mp["type"]="user";
    mp["id"]=PackagesOrderViewModel.userId;

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
        .child("messages").orderByChild("timestamp").get();
    if (snapshot.exists) {
      print(snapshot.value);
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


