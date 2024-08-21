


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/login/loginPage.dart';
import '../../../core/local/storagehelper.dart';
import '../../../core/network/network_service.dart';
import '../../../core/values/auth_manager.dart';
import '../../../core/widgets/show_dialog_update.dart';
import '../../../home_core.dart';
import '../../home/more/model/SettingsResponse.dart';
import '../../home/more/model/setting_model.dart';
import '../lang/choose_lang.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> with StorageHelper {
  Future<void> controlToApp() async {
    await readAuthManager.fetchUserIsFirst();
    await Future.delayed(const Duration(seconds: 1));


    if (readAuthManager.isFirst == false) {
      if(readAuthManager.isLogin){
        SamaOfficeApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) =>  HomeCore()),);
        // checkForUpdate();
      }else {
        SamaOfficeApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),);
      }
    } else {

      SamaOfficeApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const ChooseLang()),
      );

    }

  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();
  String token="";
  final Dio dio = NetworkService.instance.dio;
  SettingsModel? settingsModel;

  @override
  void initState() {
    super.initState();
    _fetchVersion().then((onValue){getAppVersion();}).then((onVal){controlToApp();});

  }

  Future<void> _fetchVersion() async {
    final response = await dio.get("v1/settings");
    final rs = SettingsResponse(response.data);

    setState(() {
      if (rs.status == 200) {
        settingsModel = rs.data;
      }
    });
  }
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> checkForUpdate() async {
    String currentVersion = await getAppVersion();
    String? latestVersion="";


    if (Platform.isAndroid) {
      latestVersion = settingsModel!.office_android_version.toString();
    } else if (Platform.isIOS) {
      latestVersion = settingsModel!.office_ios_version.toString();
    }

    if (latestVersion != "" && latestVersion.compareTo(currentVersion) > 0) {
      // Navigate to the store to update the app
      if (Platform.isAndroid) {
        showMyDialogUpDate(context,() async {
          const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.sama.offices';
          if (await canLaunch(playStoreUrl)) {
            await launch(playStoreUrl);
          }
        },);

      } else if (Platform.isIOS) {
        showMyDialogUpDate(context,() async {
          const appStoreUrl = 'https://apps.apple.com/us/app/yourapp/id6448801706';
          if (await canLaunch(appStoreUrl)) {
            await launch(appStoreUrl);
          }
        },);

      }
    }else{
      SamaOfficeApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) =>   HomeCore()),);
    }
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
       backgroundColor: Colors.black,
      body:        Stack(
        children: [
          Image.asset("assets/images/backGround.png",height: size.height,width: size.width,fit: BoxFit.cover,) ,
          Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200,),

              SvgPicture.asset("assets/images/logo.svg",height: 60,),
              const SizedBox(height: 320,),
               Text(textAlign: TextAlign.center,
                tr("FollowUpAndManageServiceRequests"),
                style: GoogleFonts.tajawal(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),
              ),

              const SizedBox(height: 120,),
              Text(textAlign: TextAlign.center,
                tr("TouristOfficeCopy"),
                style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.white),
              ),

            ],
          ),
        ),
      ]),
    );
  }
}
