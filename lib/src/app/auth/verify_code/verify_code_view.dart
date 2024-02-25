import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:sama_officese/src/app/auth/verify_code/verify_code_view_model.dart';

import '../../core/values/colors.dart';

class VrifyCode extends StatefulWidget {
  const VrifyCode({Key? key}) : super(key: key);

  @override
  State<VrifyCode> createState() => _VrifyCodeState();
}

class _VrifyCodeState extends VerifyCodeViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: samaOfficeColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.dark) /* set Status bar icon color in iOS. */
    );

    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell( onTap: () {
                Navigator.pop(context);
              }
                  ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
              Text(tr("MobileNumberVerification"),style: GoogleFonts.tajawal(color: Colors.white,
                  fontSize:Platform.isIOS?23: 18,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [
              Container(height: 30,color: const Color(0xff231f20),),
              Image(
                image: const AssetImage('assets/images/signback.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 140,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
       body :Stack(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(
                top: size.height - (size.height / 1), left: 10, right: 10),
            height: size.height - (size.height / 2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: SvgPicture.asset(
                          'assets/images/logocolor.svg',
                          width: size.width * .45,

                        ),
                      ),
                      const SizedBox(height: 50,),

                      Center(
                        child: SizedBox(
                          width: size.width/1.5,
                          child: PinCodeTextField(
                            controller: pinCodeControl,
                            length: 4,
                            obscureText: false,
                            // animationType: AnimationType.fade,
                            pinTheme: PinTheme(

                              activeColor: Colors.green,
                              inactiveColor:const Color(0xFFf5f9f9),
                              borderWidth: 1,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 50,
                              fieldWidth: 50,

                              activeFillColor: const Color(0xFFf5f9f9),
                              inactiveFillColor: const Color(0xFFf5f9f9),
                              selectedFillColor: const Color(0xFFf5f9f9),
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            backgroundColor:Colors.white,
                            enableActiveFill: true,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");

                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          TextButton(
                            onPressed: () {
                              if(isTimeOff) {
                                setState(() {
                                  isTimeOff=false;
                                  endTime = DateTime
                                      .now()
                                      .millisecondsSinceEpoch + 1000 * 30;
                                  controller = CountdownTimerController(
                                      endTime: endTime, onEnd: onEnd);
                                });
                              }
                              resend();


                            },
                            child: Text(tr("RSend"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: isTimeOff ?  samaColor : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                          CountdownTimer(
                            controller: controller,
                            onEnd: onEnd,
                            endTime: endTime,
                            endWidget: const Text("00:00"),
                            widgetBuilder: (context, CurrentRemainingTime? time) {
                              if (time == null) {
                                return Text(
                                  '00:00',
                                  style: GoogleFonts.tajawal(color: Colors.grey),
                                );
                              }
                              return Text(
                                '  ${time.sec} : 00 ',
                                style: GoogleFonts.tajawal(color: Colors.black),
                              );
                            },
                          ),

                        ],
                      ),
                      const SizedBox(height: 30,),




                      TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: Size(size.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: Color(0xffea8024))),
                              backgroundColor: const Color(0xffea8024)),
                          onPressed: () {
                             goToHomePage();

                          },
                          child: Text(
                            tr("CheckNow"),
                            style: GoogleFonts.tajawal(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),

               ] ),
              ),
              )]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
                child:isLoading==true? const CircularProgressIndicator(): const SizedBox.shrink()
            ),
          )
        ],
      ),

    );
  }
}
