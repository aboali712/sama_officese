
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/input_validators.dart';
import '../../core/values/colors.dart';
import 'change_password_view_model.dart';



class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ChangePasswordViewModel {
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
              Text(tr("ResetYourPassword"),style: GoogleFonts.tajawal(color: Colors.white,
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
                        const SizedBox(height: 30,),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
                          obscureText: obscureTxt,
                          decoration: InputDecoration(
                            hintText: tr("EnterPassword"),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTxt = !obscureTxt;
                                });
                              },
                              child: Icon(
                                obscureTxt
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: obscureTxt ? disabledColor : grayColor,
                              ),
                            ),
                            errorStyle: const TextStyle(color: accentColor),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17.0, horizontal: 10.0),
                            // prefixIcon: const Icon(
                            //   Icons.lock_outline,
                            //   size: 20,
                            // ),
                            filled: true,
                            //hintText: "Password".tr(),
                            fillColor: const Color(0xFFf5f9f9),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: klightGray),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                              BorderSide(width: .7, color: klightGray),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                width: .7,
                                color: klightGray,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            hintStyle: const TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(196, 196, 196, 1)),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                !InputValidators().passwordValidator(
                                    password: value, context: context)) {
                              setState(() {
                                isValidationPassword = true;
                                password = value;
                              });
                            } else {
                              setState(() {
                                isValidationPassword = false;
                                password = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            password = value ?? "";
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return tr("EnterPassword");
                            } else if (InputValidators().passwordValidator(
                                password: value, context: context)) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
                          obscureText: obscureTxt,
                          decoration: InputDecoration(
                            hintText: tr("PleaseRe-enterYourPassword"),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTxt = !obscureTxt;
                                });
                              },
                              child: Icon(
                                obscureTxt
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: obscureTxt ? disabledColor : grayColor,
                              ),
                            ),
                            errorStyle: const TextStyle(color: accentColor),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17.0, horizontal: 10.0),
                            // prefixIcon: const Icon(
                            //   Icons.lock_outline,
                            //   size: 20,
                            // ),
                            filled: true,
                            //hintText: "Password".tr(),
                            fillColor: const Color(0xFFf5f9f9),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: klightGray),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                              BorderSide(width: .7, color: klightGray),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                width: .7,
                                color: klightGray,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            hintStyle: const TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(196, 196, 196, 1)),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                !InputValidators().passwordValidator(
                                    password: value, context: context)) {
                              setState(() {
                                isValidationReEnterPassword = true;
                                reEnterPassword = value;
                              });
                            } else {
                              setState(() {
                                isValidationReEnterPassword = false;
                                reEnterPassword = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            reEnterPassword = value ?? "";
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return tr("PleaseRe-enterYourPassword");
                            } else if (InputValidators().passwordValidator(
                                password: value, context: context)) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 50,
                        ),






                        TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: Size(size.width, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                        color:  Color(0xffea8024))),
                                backgroundColor: const Color(0xffea8024)),
                            onPressed: () {
                              changePassword();
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
                child:isloading==true? const CircularProgressIndicator(): const SizedBox.shrink()
            ),
          )


        ],
      ),



    );
  }
}
