import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/auth/register/signup_viewmodel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends SignUpViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 20,),
            Text("تسجيل حساب",style: GoogleFonts.tajawal(color: Colors.white,
                fontSize:Platform.isIOS?25: 20,fontWeight: FontWeight.w500),),
          ],
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/signback.png'),
          fit: BoxFit.cover,
        ),toolbarHeight: 140,
        backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
      ),
      body:  Column(children: [
      SizedBox(
        height: 40,
      ),





          ]),);
  }
}
