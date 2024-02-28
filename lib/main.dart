




import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/core/values/auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? tokenDevice;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  // await Upgrader.clearSavedSettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  getTokenDevice();

  runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'),
        saveLocale: true,
        child: MultiProvider(
          providers: [
            Provider<AuthenticationManager>(
              create: (context) => AuthenticationManager(context: context),
            ),
          ],
          child: const SamaOfficeApp(),
        ),
      )
  );
}
getTokenDevice() async {
  tokenDevice = await FirebaseMessaging.instance.getToken();
  print("${tokenDevice} 66666666666666666666666666666666666666");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(CacheManagerKey.tokenDevice.toString(), tokenDevice!);
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();




