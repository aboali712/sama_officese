import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/steps/step_one.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/steps/step_three.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/steps/step_two.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/update_profile_viewmodel.dart';

import '../../../core/values/colors.dart';

class UpDateProfileView extends StatefulWidget {
  const UpDateProfileView({Key? key}) : super(key: key);

  @override
  State<UpDateProfileView> createState() => _UpDateProfileViewState();
}

class _UpDateProfileViewState extends UpDateProfileViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 20,),
            Text(tr("accountSettings"),style: GoogleFonts.tajawal(color: Colors.white,
                fontSize:Platform.isIOS?25: 20,fontWeight: FontWeight.w500),),
          ],
        ),
        flexibleSpace:  Stack(
            children: [
              Container(height: 30,color: const Color(0xff62b3ff),),
              Image(
                image: const AssetImage('assets/images/signback.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 140,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body:  Stack(
          children: [

            Padding(
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
                            child: Text(tr("AboutResponsible"),
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
                            child: Text(tr("AboutOffice"),
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
                            child: Text(tr("payingOff"),
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
                      StepOneProfile(this)
                          : step==1?
                      StepTwoProfile(this)
                          : step==2?
                      StepThreeProfile(this)
                          :const SizedBox.shrink(),

                      const SizedBox(height: 20,),


                    ],),
                  ),
                )






              ]),
            ),

            Positioned(bottom: 0,left: 0,right: 0,
              child: Container(height: 80,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),


            Positioned(bottom: 40,left: 20,right: 20,
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                    fixedSize: const Size(75, 50),
                    shape: RoundedRectangleBorder(

                        side: const BorderSide(
                            color: Color(0xffea8024)),
                        borderRadius:
                        BorderRadius.circular(15)),
                    backgroundColor: const Color(0xffea8024)),
                onPressed: () {

                  updateProfile();

                },
                child: Text(
                  step==2?
                  tr("Register")
                      : tr('Next'),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),






            isLoading==true?
            SizedBox(
                height: size.height/1,
                child: const Center(child: CircularProgressIndicator(color: samaColor,
                )))
                :const SizedBox.shrink()

          ]),);
  }
}
