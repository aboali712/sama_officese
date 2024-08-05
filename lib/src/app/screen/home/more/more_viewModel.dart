import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';

import '../../../auth/login/loginPage.dart';
import '../../../core/network/network_service.dart';
import 'model/SettingsResponse.dart';
import 'model/setting_model.dart';
import 'more_view.dart';

abstract class MoreViewModel extends State<MoreView> with StorageHelper{
  final Dio dio = NetworkService.instance.dio;
  static String typePage = "0";

  bool isLoading=false;

  static SettingsModel? settingsModel;
  int currentYear = DateTime.now().year;


  @override
  void initState() {

    getSettingsDataApi();
    super.initState();
  }

  Future<void> getSettingsDataApi() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("v1/settings");

    var rs = SettingsResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        settingsModel = rs.data;
      });
    }
  }


  Future<void> logoutApp() async {
    await saveToken("").then((value) async => {
      await saveToken(""),
      await Future.delayed(const Duration(seconds: 1)),
      SamaOfficeApp.navKey.currentState!
          .pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()))
    });
  }



}