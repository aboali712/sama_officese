// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue, Timestamp;
// import 'package:dio/dio.dart';
//
//
// import 'package:firebase_database/firebase_database.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:html_editor_enhanced/utils/utils.dart';
// import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
//
// import '../../../../app.dart';
// import '../../home/packages_order/packages_order_viewmodel.dart';
// import '../chat_view_model.dart';
//
//
//
//
//
//
// class ChatServices extends ChangeNotifier {
//
//   final databaseReference  = FirebaseFirestore.instance;
//   Future<void> sendMessage( String message,String type,{String? duration = ""}) async {
//
//     final Timestamp timestamp = Timestamp.now();
//
//     String chatRoomId =PackagesOrderViewModel.bookingId;
//
//     print(timestamp.toDate().toString());
//
//     DatabaseReference ref = FirebaseDatabase.instance.ref("chat_rooms").child(chatRoomId)
//
//           .child(DateTime.now().millisecondsSinceEpoch.toString());
//
//
//
//
//     await ref.set(
//         {
//       'senderId':HomeViewModel.profileModel!.office!.id,
//       'senderEmail': HomeViewModel.profileModel!.email,
//       'receverId':PackagesOrderViewModel.userId,
//       'type':type,
//       'message':message,
//       'timestamp':DateTime.now().millisecondsSinceEpoch,
//           "duration": duration,
//           "offerId":ChatViewModel.offerId,
//           "isReadUser":0
//
//
//         }
//     );
//     ChatViewModel.messageControl.clear();
//
//
//
//     Map<String,String> headers = {'Content-Type':'application/json'};
//     Map mp={};
//     mp["type"]="user";
//     mp["userId"]=PackagesOrderViewModel.userId;
//     mp["officeId"]=PackagesOrderViewModel.userMdole!.office!.id.toString();
//     mp["bookingId"]=PackagesOrderViewModel.bookingId;
//     mp["offerId"]=ChatViewModel.offerId.toString();
//
//
//     final response = await dio.post( "v1/sendMessage",options: Options(headers: headers), data:(mp), );
//
//
//
//     //
//     // await _firestore
//     //     .collection('chat_rooms')
//     //     .doc(chatRoomId)
//     //     .collection('messages')
//     //     .add(messageModel.toMap());
//   }
//
//
//   Future<DataSnapshot>  getMessage(String userId,String otherUserId)  async {
//     List<String> ids = [userId, otherUserId];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//
//     final ref = FirebaseDatabase.instance.ref();
//     final snapshot = await ref.child('chat_rooms').child(chatRoomId)
//         .orderByChild("timestamp").get();
//     if (snapshot.exists) {
//       // print(snapshot.value);
//     } else {
//       print('No data available.');
//     }
//     return snapshot;
//
//     // return _firestore
//     //     .collection('chat_rooms')
//     //     .doc(chatRoomId)
//     //     .collection('messages')
//     //     .orderBy('timestamp',descending: true).snapshots();
//
//
//
//   }
//
// }
//
//


// Import necessary packages for Firestore and Firebase Realtime Database
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue, Timestamp; // Specific imports from Firestore
import 'package:dio/dio.dart'; // HTTP client for API requests
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database

// Import necessary packages for Flutter UI and utilities
import 'package:flutter/cupertino.dart';
import 'package:html_editor_enhanced/utils/utils.dart'; // HTML editor utilities

// Import project-specific view models
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import '../../../../app.dart';
import '../../home/packages_order/packages_order_viewmodel.dart';
import '../chat_view_model.dart'; // Importing chat view model

// ChatServices class handles chat-related functionalities
class ChatServices extends ChangeNotifier {

  final databaseReference = FirebaseFirestore.instance; // Reference to Firestore instance

  // Function to send a message in the chat
  Future<void> sendMessage(String message, String type, {String? duration = ""}) async {

    final Timestamp timestamp = Timestamp.now(); // Get the current timestamp

    // Get the chat room ID from the PackagesOrderViewModel
    String chatRoomId = ChatViewModel.bookingId;

    print(timestamp.toDate().toString()); // Debug print of the timestamp

    // Reference to the specific chat room in Firebase Realtime Database
    DatabaseReference ref = FirebaseDatabase.instance.ref("chat_rooms").child(chatRoomId)
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    // Set the chat message details in the database
    await ref.set({
      'senderId': HomeViewModel.profileModel!.office!.id, // ID of the sender
      'senderEmail': HomeViewModel.profileModel!.email, // Email of the sender
      'receverId': ChatViewModel.userId, // ID of the receiver
      'type': type, // Type of the message (text, image, audio, etc.)
      'message': message, // Message content
      'timestamp': DateTime.now().millisecondsSinceEpoch, // Message timestamp
      "duration": duration, // Duration if the message is an audio message
      "offerId": ChatViewModel.offerId, // Associated offer ID
      "isReadUser": 0 // Flag to check if the message is read by the user
    });

    ChatViewModel.messageControl.clear(); // Clear the message input field

    // Headers and data for the API request
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map mp = {
      "type": "user",
      "userId": ChatViewModel.userId,
      "officeId": ChatViewModel.userMdole!.office!.id.toString(),
      "bookingId": ChatViewModel.bookingId,
      "offerId": ChatViewModel.offerId.toString()
    };

    // Make an API request to notify the user about the new message
    final response = await dio.post(
      "v1/sendMessage",
      options: Options(headers: headers),
      data: mp,
    );

  }

  // Function to retrieve chat messages between two users
  Future<DataSnapshot> getMessage(String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort(); // Sort IDs to maintain consistent chat room ID
    String chatRoomId = ids.join("_");

    // Reference to the specific chat room in Firebase Realtime Database
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('chat_rooms').child(chatRoomId)
        .orderByChild("timestamp").get(); // Retrieve messages ordered by timestamp

    if (snapshot.exists) {
      // Messages exist in the chat room
      // print(snapshot.value);
    } else {
      print('No data available.'); // No messages available in the chat room
    }
    return snapshot; // Return the snapshot of messages


  }
}
