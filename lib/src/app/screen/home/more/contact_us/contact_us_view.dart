import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/more/more_viewModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/input_validators.dart';
import '../../../../core/values/colors.dart';
import 'contact_us_viewmodel.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends ContactUsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [

                InkWell( onTap: () {
                  Navigator.pop(context);
                }
                    ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                Text(
                  tr("ContactUs"),
                  style: const TextStyle(
                      color:  Colors.white,
                      fontSize: 21, fontWeight: FontWeight.w500),
                ),

              ],),
              SizedBox(height: Platform.isIOS? 20:0,),

            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [
              Container(height: 30,color: const Color(0xff231f20),),
              Image(
                image: const AssetImage('assets/images/create.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
          children: [
            SizedBox(height: size.height,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: [
                              const SizedBox(height: 10,),

                              Text(
                                textAlign: TextAlign.center,
                                tr("WeAreAlwaysHereToHelpYou"),style: GoogleFonts.tajawal(color: Colors.black,
                                  fontSize:25,fontWeight: FontWeight.w500),),
                              const SizedBox(height: 10,),


                              Text(tr("IfYouHaveAQuestion"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(color: Colors.grey,
                                  fontSize:17,fontWeight: FontWeight.w400),),
                              const SizedBox(height: 20,),

                              TextFormField(
                                controller: subControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText: tr("Subject"),
                                  hintStyle: GoogleFonts.tajawal(
                                      fontSize: 17,fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(196, 196, 196, 1)),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),

                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  border: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide( width: 1,color: Colors.grey
                                      )),
                                  errorBorder: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                                  focusedErrorBorder: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {

                                  } else {

                                  }
                                },
                                onSaved: (value) {

                                },

                                cursorColor: Colors.black,
                                keyboardType: TextInputType.name,
                              ),



                              const SizedBox(height: 20,),

                              TextFormField(
                                controller: questionControl,
                                maxLines: 5,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText: tr("yourInquiry"),
                                  hintStyle: GoogleFonts.tajawal(
                                      fontSize: 17,fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(196, 196, 196, 1)),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),

                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  border: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide( width: 1,color: Colors.grey
                                      )),
                                  errorBorder: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                                  focusedErrorBorder: const UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {

                                  } else {

                                  }
                                },
                                onSaved: (value) {

                                },

                                cursorColor: Colors.black,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 20,),

                              Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                                      fixedSize:  Size(size.width-20, 50),
                                      shape: RoundedRectangleBorder(

                                          side: const BorderSide(
                                              color: Color(0xffEA8024)),
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                      backgroundColor: const Color(0xffEA8024)),
                                  onPressed: () {
                                    contactApi();

                                  },
                                  child: Text(
                                    tr("Send"),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20,),

                              Text(tr("OrContactUsVia"),style: GoogleFonts.tajawal(color: Colors.grey,
                                  fontSize:16,fontWeight: FontWeight.w400),),

                              const SizedBox(height: 30,),

                              InkWell(onTap: () {
                                launchUrl(Uri.parse(
                                    "tel://${phone}"));

                              },
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  SvgPicture.asset("assets/images/call.svg",),
                                  const SizedBox(width: 15,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tr("Phone"),style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:16,fontWeight: FontWeight.w500),),
                                      const SizedBox(height: 5,),
                                      Text(phone,
                                        style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:16,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ],),
                              ),

                              const SizedBox(height: 20,),

                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/email.svg",),
                                  const SizedBox(width: 15,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tr("E-mail"),style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:16,fontWeight: FontWeight.w500),),
                                      const SizedBox(height: 5,),
                                      Text(MoreViewModel.settingsModel!.email!,
                                        style: GoogleFonts.tajawal(color: Colors.black,
                                            fontSize:16,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ],),




                            ]),
                      ),
                    ),
                  ),
                  ]),
            ),

            isLoading==true?
            SizedBox(
                height: size.height/1,
                child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
                )))
                :const SizedBox.shrink(),



            // Positioned(bottom: -5,left: -5,right: -5,
            //   child: Card( elevation: 20,color: Colors.white,shape: const RoundedRectangleBorder(
            //       borderRadius:  BorderRadius.only(topLeft: Radius.circular(25)
            //           ,topRight:Radius.circular(25) )),
            //     child: Container(height: 110,width: size.width,
            //       padding: const EdgeInsets.all(15),
            //       decoration: const BoxDecoration(color: Colors.white,
            //           borderRadius: BorderRadius.only(topLeft: Radius.circular(25)
            //               ,topRight:Radius.circular(25) )),
            //
            //       child: Center(
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //               primary: Colors.white,
            //               padding: const EdgeInsets.all(0),
            //               fixedSize:  Size(size.width-20, 50),
            //               shape: RoundedRectangleBorder(
            //
            //                   side: const BorderSide(
            //                       color: Color(0xffEA8024)),
            //                   borderRadius:
            //                   BorderRadius.circular(15)),
            //               backgroundColor: const Color(0xffEA8024)),
            //           onPressed: () {
            //
            //
            //           },
            //           child: Text(
            //             tr("CreatePackage"),
            //             style: const TextStyle(
            //                 fontSize: 16,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w500),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )




          ] ),


    );
  }
}
