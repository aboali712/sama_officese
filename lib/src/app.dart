import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/core/network/network_service.dart';
import 'app/core/values/theme.dart';
import 'app/screen/start/splash/splash.dart';


final Dio dio = NetworkService.instance.dio;

class SamaOfficeApp extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();

  const SamaOfficeApp({Key? key}) : super(key: key);

  @override
  State<SamaOfficeApp> createState() => _SamaOfficeAppState();
}

class _SamaOfficeAppState extends State<SamaOfficeApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: SamaOfficeApp.navKey, // GlobalKey()
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context),


        home: const SplashView());
  }
}



