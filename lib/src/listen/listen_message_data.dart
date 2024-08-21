import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../app/core/network/network_service.dart';

class MessageListenerService with ChangeNotifier {
  static final MessageListenerService _instance = MessageListenerService._internal();
  factory MessageListenerService() => _instance;

  MessageListenerService._internal();

  int _unreadThreadsCount = 0;
  bool _isLoading = true;

  int get unreadThreadsCount => _unreadThreadsCount;
  bool get isLoading => _isLoading;

  Future<void> initializeListener() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference messagesRef = databaseReference.child(NetworkService.baseUrl1.contains("test.")?'chat_rooms_test':'chat_rooms');

    messagesRef.onValue.listen((event) {
      int unreadThreadsCount = 0;

      event.snapshot.children.forEach((allThreads) {
        bool hasUnreadMessage = false;

        allThreads.children.forEach((message) {
          if (message.child('isReadOffice').value == 0) {
            // hasUnreadMessage = true;
            unreadThreadsCount++;
          }
        });

        // if (hasUnreadMessage) {
        //   unreadThreadsCount++;
        // }
      });


      _unreadThreadsCount = unreadThreadsCount;
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      print('Failed to listen to data: $error');
    });
  }
}
