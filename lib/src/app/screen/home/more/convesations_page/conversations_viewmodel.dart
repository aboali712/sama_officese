import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';

import '../../../../auth/auth_model/user_model.dart';
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

    messagesRef.get().then((allChats) => {

      allChats.children.forEach((allThreads) async {

        if(allThreads.children.first.child("senderId").value.toString()==HomeViewModel.profileModel!.id.toString()
            || allThreads.children.first.child("receverId").value.toString()==HomeViewModel.profileModel!.id.toString()||
        allThreads.children.last.child("senderId").value.toString()==HomeViewModel.profileModel!.id.toString()
            || allThreads.children.last.child("receverId").value.toString()==HomeViewModel.profileModel!.id.toString()){
          setState(() {
            conversationModel.add(ConversModel(
                orderId: int.parse(allThreads.key.toString()),
                date: allThreads.children.toList()[0].child("timestamp").value.toString(),
                message: allThreads.children.toList()[0].child("message").value.toString(),
                type: allThreads.children.toList()[0].child("type").value.toString(),
                officeId: int.parse(allThreads.children.toList()[0].child("receverId").value.toString(),)
            ));
          });
          print("${ allThreads.children.toList()[0].child("message").value.toString()} 2222222222222222");
          print("${ allThreads.children.toList()[0].child("timestamp").value.toString()} 2222222222222222");
          print("${ allThreads.children.length} 2222222222222222");




      }}
      )});


    setState(() {
      isLoading=false;
    });
    //
    // final dbRef = FirebaseDatabase.instance
    //     .ref()
    //     .child("chat_rooms");
    // dbRef.onValue.listen((event) {
    //   event.snapshot.children.forEach((child) {
    //     // print(child.key);
    //     child.children.forEach((child2) {
    //       // print(child2.key);
    //       child2.children.forEach((element) {
    //
    //         print("${element.child("senderId").value} 3333333333333333333333333333");
    //
    //         // var kk=element.;
    //         print( child2.children.where((element) => element.child("")==));
    //
    //
    //
    //       });
    //
    //
    //     });
    //   });
    // });



  }
}