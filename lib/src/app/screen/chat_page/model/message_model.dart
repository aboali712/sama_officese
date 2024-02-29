// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class MessageModel {
//   String? message;
//   String? receverId;
//   String? senderEmail;
//   String? senderId;
//   late final Timestamp? timestamp;
//   String? type;
//   String? duration;
//
//   MessageModel(
//       {this.message,
//         this.receverId,
//         this.senderEmail,
//         this.senderId,
//         this.timestamp,
//         this.type,this.duration });
//
//   MessageModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     receverId = json['receverId'];
//     senderEmail = json['senderEmail'];
//     senderId = json['senderId'];
//     timestamp = json['timestamp'];
//     type = json['type'];
//     duration = json['duration'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['receverId'] = this.receverId;
//     data['senderEmail'] = this.senderEmail;
//     data['senderId'] = this.senderId;
//     data['timestamp'] = this.timestamp;
//     data['type'] = this.type;
//     data['duration'] = this.duration;
//     return data;
//   }
//
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? senderId;
  final String? senderEmail;
  final String? receverId;
  final String? message;
  final Timestamp timestamp;
  final  String? type;
  final  String? duration;

  MessageModel({
    this.senderId,
    this.senderEmail,
    this.receverId,
    this.message,
    required this.timestamp,
    this.type,
    this.duration,

});

  Map<String,dynamic> toMap(){
    return{
        'senderId':senderId,
        'senderEmail':senderEmail,
        'receverId':receverId,
        'type':type,
        'message':message,
        'timestamp':timestamp,
      "duration":  duration,
    };
  }




}