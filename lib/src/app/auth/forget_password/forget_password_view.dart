
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';

import '../../core/utils/input_validators.dart';
import '../../core/values/colors.dart';
import '../../core/widgets/phone_number_widget.dart';
import '../login/loginPage.dart';
import '../verify_code/verify_code_view.dart';
import 'forget_password_view_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ForgetPasswordViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: samaOfficeColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.light,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.light) /* set Status bar icon color in iOS. */
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell( onTap: () {
                Navigator.pop(context);
              }
                  ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
              Text(tr("ForgotYourPassword"),style: GoogleFonts.tajawal(color: Colors.white,
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
            height: size.height - (size.height / 3),
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

                        Text(
                          tr("Phone"),
                          style:  GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PhoneNumberSignUpWidget(
                          isPhone: isPhone,
                          focusNode: focusPhone,
                          hintText: tr("EnterMobile"),
                          onChanged: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !InputValidators().phoneNumberValidator(
                                    phoneNumber: "20$value", context: context)) {
                              setState(() {
                                // phoneValidation = true;
                                isPhone = false;
                                phoneNumber = value!;
                              });
                            } else {
                              setState(() {
                                // phoneValidation = false;
                                isPhone = true;
                                phoneNumber = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            phoneNumber = value!;
                          },
                        ),
                        const SizedBox(height: 70,),


                        TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: Size(size.width, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                        color: Color(0xffea8024))),
                                backgroundColor:const Color(0xffea8024)),
                            onPressed: () {
                               checkForgetPassword();

                            },
                            child: Text(
                              tr("SubmitVerificationCode"),
                              style: GoogleFonts.tajawal(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            )),

                        const SizedBox(height: 50,),
                        Center(
                          child: Text(
                            tr("YouAlreadyHavAnAccount"),
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {

                                SamaOfficeApp.navKey.currentState!.push(
                                    MaterialPageRoute(builder: (context) => const LoginPage()));
                              },
                              child: Text(
                                tr("Login"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),



                      ] ),
                ),
              )]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
                child:isloading==true? const CircularProgressIndicator(): const SizedBox.shrink()
            ),
          )
        ],
      ),


    );
  }
}
