import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sama_officese/src/app/screen/home/home_view.dart';
import 'package:sama_officese/src/app/screen/home/more/more_view.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/update_profile_view.dart';
import 'package:sama_officese/src/app/screen/notifications/notification_view.dart';
import 'package:upgrader/upgrader.dart';

import 'core/local/storagehelper.dart';
import 'core/utils/helper_manager.dart';
import 'core/values/colors.dart';
import 'core/values/theme.dart';
import 'core/widgets/bottom_menu.dart';



class HomeCore extends StatefulWidget {
  static var model;
  static String type = "0";

  static String count1="0";
  static String count2="0";


  static String charityID = "";
  static String typeCate = "0";
  static ValueNotifier<int> counter = ValueNotifier<int>(0);


  @override
  HomeCorePage createState() => HomeCorePage();
}

class HomeCorePage extends State<HomeCore> with StorageHelper {
  static int index = 0;
  static var bottomWidgetKey=GlobalKey<State<BottomNavigationBar>>();

  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: samaOfficeColor,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );
    Widget child = Container();
    switch (index) {

      case 0:
        child =  const HomePage();
        break;
      case 1:
        child =  const NotificationsView();
        break;
      case 2:
        child =   const UpDateProfileView();
        break;
      case 3:
        child =    const MoreView();
        break;
    }
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context),
        home:UpgradeAlert(
          upgrader: Upgrader(
              // showReleaseNotes: false,
              // dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
              // showLater: false,
              // showIgnore: false,
              messages: MyUpgraderMessages()),
          child: Scaffold(
            body: child,
            bottomNavigationBar: BottomMenu(
              bottomMenuIndex: index,
              onChanged: (newIndex) => setState(() => index = newIndex),
            ),
          ),
        ));
  }
}
