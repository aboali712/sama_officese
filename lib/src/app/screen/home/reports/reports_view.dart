import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/reports/reports_viewmodel.dart';

import '../../../../app.dart';
import '../../../core/values/colors.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends ReportsViewModel {
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

            Text(tr("Reports"),style: GoogleFonts.tajawal(color: Colors.white,
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
      body: Stack(
          children: [

            reportModel!=null?
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(
                  direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(height: 10,),

                        const SizedBox(height: 10,),

                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container( height: 165,width: size.width/2.2,
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(20) ,
                                color: const Color(0xffCAD7E5),

                              ),child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                  children: [

                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 53,width: 58,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff00417e) ),
                                            child: SvgPicture.asset("assets/images/plan.svg",)),


                                        Container(
                                            height: 27,width: 27,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff5AC41A) ),
                                            child: Center(
                                              child: Text(reportModel!.offersCount.toString(),
                                                style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                                    fontWeight: FontWeight.w400
                                                ),),
                                            )),

                                      ],
                                    ),


                                    const SizedBox(height: 20,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          tr("NumberOfOffers"),
                                          style: const TextStyle(
                                              color:  Colors.black,
                                              fontSize: 15, fontWeight: FontWeight.w500),
                                        ),


                                      ],
                                    )
                                  ]),),

                            Container( height: 165,width: size.width/2.2,
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(20) ,
                                color: const Color(0xffCAEBED),

                              ),child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                  children: [

                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 53,width: 58,
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff00a8a5) ),
                                            child: SvgPicture.asset("assets/images/planee.svg",)),


                                        Container(
                                            height: 27,width: 27,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff8A8C8E) ),
                                            child: Center(
                                              child: Text( reportModel!.pendingReservationsCount.toString(),
                                                style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                                  fontWeight: FontWeight.w400
                                              ),),
                                            )),

                                      ],
                                    ),


                                    const SizedBox(height: 20,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          tr("pendingReservations"),
                                          style: const TextStyle(
                                              color:  Colors.black,
                                              fontSize: 15, fontWeight: FontWeight.w500),
                                        ),

                                      ],
                                    )
                                  ]),),

                          ],),
                        const SizedBox(height: 20,),



                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container( height: 165,width: size.width/2.2,
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(20) ,
                                color: const Color(0xffF8E3D3),

                              ),child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                  children: [

                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 53,width: 58,
                                            padding: const EdgeInsets.all(13),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xffea8024) ),
                                            child: SvgPicture.asset("assets/images/plancc.svg",)),


                                        Container(
                                            height: 27,width: 27,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff5AC41A) ),
                                            child: Center(
                                              child: Text(
                                              reportModel!.completedReservationsCount.toString(),
                                                style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                                    fontWeight: FontWeight.w400
                                                ),),
                                            )),

                                      ],
                                    ),


                                    const SizedBox(height: 20,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          tr("completedReservations"),
                                          style: const TextStyle(
                                              color:  Colors.black,
                                              fontSize: 15, fontWeight: FontWeight.w500),
                                        ),


                                      ],
                                    )
                                  ]),),
                            Container( height: 165,width: size.width/2.2,
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(20) ,
                                color: const Color(0xffE5E6E8),

                              ),child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                  children: [

                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 53,width: 58,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color: Colors.grey ),
                              child: SvgPicture.asset("assets/images/plan.svg",color: Colors.grey.shade400,),),


                                        Container(
                                            height: 27,width: 27,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                                color:const Color(0xff5AC41A) ),
                                            child: Center(
                                              child: Text(
                                                reportModel!.totalReservations.toString(),
                                                style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                                    fontWeight: FontWeight.w400
                                                ),),
                                            )),
                                      ],
                                    ),


                                    const SizedBox(height: 30,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          tr("TotalReservations"),
                                          style: const TextStyle(
                                              color:  Colors.black,
                                              fontSize: 15, fontWeight: FontWeight.w500),
                                        ),


                                      ],
                                    )
                                  ]),),

                          ],),
                        const SizedBox(height: 20,),


                        Container( height: 165,width: size.width/2.2,
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(20) ,
                            color: const Color(0xffCAEBED),

                          ),child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                              children: [

                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 53,width: 58,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                            color:const Color(0xff00a8a5) ),
                                        child: SvgPicture.asset("assets/images/planee.svg",)),


                                    Container(
                                        height: 27,width: 27,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                            color:const Color(0xff8A8C8E) ),
                                        child: Center(
                                          child: Text( reportModel!.totalSales.toString(),
                                            style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                                fontWeight: FontWeight.w400
                                            ),),
                                        )),

                                  ],
                                ),


                                const SizedBox(height: 20,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      tr("TotalSales"),
                                      style: const TextStyle(
                                          color:  Colors.black,
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    ),

                                  ],
                                )
                              ]),),



                      ]),
                    ),
                  ),
                  ]),
            )
            :const SizedBox.shrink(),

            isLoading==true?
            SizedBox(
                height: size.height/1,
                child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
                )))
                :const SizedBox.shrink()



            ,
          ]),


    );
  }
}
