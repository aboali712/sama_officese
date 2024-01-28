


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app.dart';

import '../../../auth/login/loginPage.dart';
import '../../../core/local/storagehelper.dart';
import '../../../core/values/auth_manager.dart';
import '../../../home_core.dart';
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

  @override
  void initState() {
    super.initState();
    controlToApp();
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
