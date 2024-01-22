import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notifications_viewmodel.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends NotificationsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            const SizedBox(width: 20,),

            Text(tr("الأشعارات"),style: GoogleFonts.tajawal(color: Colors.white,
                fontSize:Platform.isIOS?25: 20,fontWeight: FontWeight.w500),),
          ],
        ),
        flexibleSpace:  Stack(
          children: [
          Container(height: 30,color: const Color(0xff231f20),),

        Image(
            image: const AssetImage('assets/images/signback.png'),
            fit: BoxFit.cover,width: size.width,
          ),
        ]),toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Expanded(
          child: SingleChildScrollView( 
            child: Column(children: [
              const SizedBox(height: 10,),
            
              Column(children: [1,2,3,4,5,6,7].map((e) =>   Card(elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(height: 100,width: size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
            
                        SvgPicture.asset("assets/images/lognoti.svg",),
                        const SizedBox(width: 10,),
            
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr("أبدأ 2024 بعروضك المميزة"),style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:15,fontWeight: FontWeight.w500),),
            
            
                            Text(tr("أضف عروضك المميزة وأبهر عملائك"),style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:12,fontWeight: FontWeight.w400),),
            
            
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/time.svg"),
                                const SizedBox(width: 5,),
                                Text(tr("25Feb,2023"),style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
                                    fontSize:12,fontWeight: FontWeight.w400),),
                              ],
                            ),
            
                          ],)
            
            
                      ]) ,
                ),
              )).toList(),)
            
            
            
            
            
            ]),
          ),
        ),
      ),


    );
  }
}
