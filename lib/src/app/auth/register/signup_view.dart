import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_officese/src/app/auth/register/signup_viewmodel.dart';
import 'package:sama_officese/src/app/auth/register/steps/step_one.dart';
import 'package:sama_officese/src/app/auth/register/steps/step_two.dart';

import '../../core/values/colors.dart';

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
        flexibleSpace:  Image(
          image: const AssetImage('assets/images/signback.png'),
          fit: BoxFit.cover,width: size.width,
        ),toolbarHeight: 140,
        backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(children: [

        Container(height: 50,width: size.width-10,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              border:Border.all(width: .7,color: Colors.grey.shade300) ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

              InkWell(onTap: () {
                setState(() {
                  step=0;
                });
              },
                child: Container(height: 45,width: 120,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: step==0? samaColor :Colors.white ,
                     ),
                  child: Text("عن المسؤل",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:step==0? Colors.white: Colors.grey,
                        fontWeight: FontWeight.w500,fontSize: 14

                  ),),),
              ),

                  InkWell(onTap: () {
                    setState(() {
                      step=1;
                    });
                  },
                    child: Container(height: 45,width: 120,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        color: step==1? samaColor :Colors.white ,
                      ),
                      child: Text("عن المكتب",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(color:step==1? Colors.white: Colors.grey,
                            fontWeight: FontWeight.w500,fontSize: 14

                        ),),),
                  ),

                  InkWell(onTap: () {
                    setState(() {
                      step=2;
                    });
                  },
                    child: Container(height: 45,width: 120,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        color: step==2? samaColor :Colors.white ,
                      ),
                      child: Text("الدفع",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(color:step==2? Colors.white: Colors.grey,
                            fontWeight: FontWeight.w500,fontSize: 14

                        ),),),
                  ),

            ]),),


          const SizedBox(height: 10,),

       Expanded(
         child: SingleChildScrollView(
           child: Column(children: [
             step==0?
             StepOne(this)
                 : step==1?
             StepTwo(this)
                 :const SizedBox.shrink(),

             const SizedBox(height: 20,),


           ],),
         ),
       )






        ]),
      ),);
  }


}
