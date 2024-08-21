import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';

import '../main.dart';
import 'app/core/network/network_service.dart';
import 'app/core/values/auth_manager.dart';
import 'app/core/values/theme.dart';
import 'app/screen/chat_page/chat_view.dart';
import 'app/screen/chat_page/chat_view_model.dart';
import 'app/screen/home/home_viewmodel.dart';
import 'app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';
import 'app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'app/screen/start/splash/splash.dart';
import 'listen/listen_message_data.dart';


final Dio dio = NetworkService.instance.dio;

class SamaOfficeApp extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();

  const SamaOfficeApp({Key? key}) : super(key: key);

  @override
  State<SamaOfficeApp> createState() => _SamaOfficeAppState();
}

class _SamaOfficeAppState extends State<SamaOfficeApp> with StorageHelper{
  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();
  @override
  void initState() {
    super.initState();
    readAuthManager.getProfileDate();
    // getUser().then((value) => value != null ? setState((){HomeViewModel.userModel = value;}): null); // Get user dat
    var initialzationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification!;
    //   AndroidNotification android = message.notification!.android!;
    //   if (notification != null && android != null) {
    //     showDialog(
    //       // context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         },
    //         context: context);
    //   }
    // });
    NotificationPermissions.requestNotificationPermissions(
        iosSettings: const NotificationSettingsIos(
            sound: true, badge: true, alert: true));

    // Handling notification when the app is in the background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationNavigation(message.data);
      print("${message.data.toString()} 6888888888888888888888888888888888888888888888888888");
    });



    // Handling notification when the app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Future.delayed(Duration(seconds:2), () async {
          await  _handleNotificationNavigation(message.data);
          print("${message.data.toString()} 6888888888888888888888888888888888888888888888888888");
        });
      }
    });

    getTokenDevice();

  }
  Future<void> _handleNotificationNavigation(Map<String, dynamic> data) async {
    String reservationId = data['reservation_id'] ?? '';
    Map<String, dynamic> firebaseData = data['firebase'] != null
        ? json.decode(data['firebase'])
        : {};

     String offerId = firebaseData['offerId']?.toString() ?? '';
     String userId = firebaseData['userId']?.toString() ?? '';

    // Navigate based on the route in data
    if (data['notification_type'] == 'message') {
      setState(() {
        ChatViewModel.bookingId =reservationId.toString();
        ChatViewModel.offerId=int.parse(offerId.toString());
        ChatViewModel.userMdole=HomeViewModel.profileModel;
        ChatViewModel.userId= userId.toString();
        ChatViewModel.pageNu=1;
      });
       SamaOfficeApp.navKey.currentState?.pushNamed('/message');
      SamaOfficeApp.navKey.currentState?.pushNamedAndRemoveUntil(
        '/message',
            (Route<dynamic> route) => false,
      );
      DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
      DatabaseReference messagesRef = databaseReference.child(NetworkService.baseUrl1.contains("test.")?'chat_rooms_test':'chat_rooms');
      messagesRef.get().then((allChats) {
        allChats.children.forEach((allThreads) {
          if (allThreads.key.toString() == reservationId.toString()) {
            allThreads.children.forEach((message) async {
              if(message.child('senderId').value.toString()!=HomeViewModel.profileModel!.id.toString()){
                await   message.ref.child('isReadUser').set(1);
              }

            });
          }
        });
      });

    }
    else if (data['notification_type'] == 'reservation') {
      setState(() {
        PackagesOrderDetailsViewModel.reservationId =reservationId.toString();
      });
      // NewSamaApp.navKey.currentState?.pushNamed('/reservation_status');
      SamaOfficeApp.navKey.currentState?.pushNamedAndRemoveUntil(
        '/reservation',
            (Route<dynamic> route) => false,
      );
      setState(() {
        PackagesOrderDetailsViewModel.pageNu=1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MessageListenerService(),
      child: MaterialApp(
          routes: {
            '/message': (context) => const ChatView(),
            '/reservation': (context) => const PackagesOrderDetailsView(),
          },
          navigatorKey: SamaOfficeApp.navKey, // GlobalKey()
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.of(context),


          home:  const SplashView()),
    );
  }
}



