import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';

import '../../../../auth/auth_model/user_model.dart';
import '../../../chat_page/chat_view.dart';
import '../../../chat_page/chat_view_model.dart';
import '../../packages_order/packages_order_viewmodel.dart';
import 'conversations_view.dart';
import 'model.dart';

abstract class ConversationsViewModel extends State<ConversationsView> with StorageHelper {
  bool isLoading=false;
  static UserModel? userMdole;

  @override
  void initState() {
    super.initState();

    getUser().then((value) => setState(() {
      userMdole=value;
    }));
    getData();

  }

  List<ConversModel> conversationModel=[];


  Future<void> getData() async {
    setState(() {
      isLoading=true;
    });
    // DatabaseReference ref = FirebaseDatabase.instance.ref("chat_rooms");
    // final event = await ref.once(DatabaseEventType.value);
    // final data = event.snapshot.value as Map;
    // print("${data.keys}  000000000000000000000000000000000000");
    //
    // Reference to your Firebase database
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    // Query to get messages based on receiver ID and sender ID
    DatabaseReference messagesRef = databaseReference.child('chat_rooms');

    messagesRef.onValue.listen((event) {
      conversationModel.clear();  // Clear the existing conversation model to avoid duplicates

      DataSnapshot allChats = event.snapshot;
      allChats.children.forEach((allThreads) async {

        if(allThreads.children.first.child("senderId").value.toString()==HomeViewModel.profileModel!.office!.id.toString()
            || allThreads.children.first.child("receverId").value.toString()==HomeViewModel.profileModel!.office!.id.toString()
            ||allThreads.children.last.child("senderId").value.toString()==HomeViewModel.profileModel!.office!.id.toString()
            || allThreads.children.last.child("receverId").value.toString()==HomeViewModel.profileModel!.office!.id.toString()
        ){

          List<DataSnapshot> messages = allThreads.children.toList();
          messages.sort((a, b) => a.child("timestamp").value.toString().compareTo(b.child("timestamp").value.toString()));
          DataSnapshot lastMessage = messages.last;  // Now, this should be the last message in chronological order



          int unreadMessagesCount = 0;
          allThreads.children.forEach((message) {
            if (message.child('isReadOffice').value == 0) {
              unreadMessagesCount++;
            }
          });



          setState(() {
            conversationModel.add(ConversModel(
                orderId: int.parse(allThreads.key.toString()),
                date: lastMessage.child("timestamp").value.toString(),
                message: lastMessage.child("message").value.toString(),
                type: lastMessage.child("type").value.toString(),
                officeId:lastMessage.child("senderId").value.toString()==HomeViewModel.profileModel!.office!.id.toString()?
                int.parse(lastMessage.child("receverId").value.toString())
                    : int.parse(lastMessage.child("senderId").value.toString()),
                offerId: int.parse(lastMessage.child("offerId").value.toString()),
                isReadOffice: unreadMessagesCount,
                isReadUser: lastMessage.child("isReadUser").value !=null?
                   int.parse(lastMessage.child("isReadUser").value.toString()):null
            ));
          });

        }}
      );

      setState(() {
        isLoading = false;
      });
    });





    Future.delayed(const Duration(seconds: 1)).then((value) => {
      setState(() {
        isLoading=false;
      })
    });

  }


  void gotoChat(ConversModel?e ){
    setState(() {
      ChatViewModel.bookingId= e!.orderId.toString();
      ChatViewModel.userMdole=HomeViewModel.profileModel;
      ChatViewModel.userId= e.officeId.toString();
      ChatViewModel.offerId= int.parse(e.offerId.toString());
    });

    SamaOfficeApp.navKey
        .currentState!
        .push(
      MaterialPageRoute(
          builder:
              (context) =>
          const ChatView()),
    );

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference messagesRef = databaseReference.child('chat_rooms');
    messagesRef.get().then((allChats) {
      allChats.children.forEach((allThreads) {
        if (allThreads.key.toString() == e!.orderId.toString()) {
          allThreads.children.forEach((message) async {
            if(message.child('senderId').value.toString()!=HomeViewModel.profileModel!.office!.id.toString()){
               // print(message.child('senderId').value.toString());
              await   message.ref.child('isReadOffice').set(1);
            }
            // message.ref.child('isReadOffice').set(1);
          });
        }
      });
    });

    setState(() {
      e!.isReadOffice=0;
    });
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        getData();
      });
    });
  }

}