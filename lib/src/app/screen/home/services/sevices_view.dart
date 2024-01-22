import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/services/services_details/service_details_view.dart';
import 'package:sama_officese/src/app/screen/home/services/sevices_viewmodel.dart';

import '../../../core/values/colors.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({Key? key}) : super(key: key);

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends ServicesViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
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
                const Text(
                  "طلبات الخدمات",
                  style: TextStyle(
                      color:  Colors.white,
                      fontSize: 21, fontWeight: FontWeight.w500),
                ),

              ],),
              const SizedBox(height: 10,),


              Container(height: 45,width: size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    border:Border.all(width: .7,color: Colors.grey.shade400) ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(onTap: () {
                        setState(() {
                          serviceStat=0;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:serviceStat==0? Colors.white :Colors.transparent,
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 18,width: 18,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                      color:const Color(0xff5AC41A) ),
                                  child: Center(
                                    child: Text("3",style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  )),
                              const SizedBox(width: 5,),

                              Text(tr("جديدة"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(color:serviceStat==0?  Colors.black: Colors.grey,
                                    fontWeight: FontWeight.w500,fontSize: 14

                                ),),
                            ],
                          ),),
                      ),

                      InkWell(onTap: () {
                        setState(() {
                          serviceStat=1;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: serviceStat==1?Colors.white :Colors.transparent,
                          ),
                          child: Text(tr("قيد التنفيذ"),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(color:serviceStat==1? Colors.black: Colors.grey,
                                fontWeight: FontWeight.w500,fontSize: 14

                            ),),),
                      ),

                      InkWell(onTap: () {
                        setState(() {
                          serviceStat=2;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: serviceStat==2? Colors.white :Colors.transparent ,
                          ),
                          child: Text(tr("مكتملة"),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(color:serviceStat==2? Colors.black: Colors.grey,
                                fontWeight: FontWeight.w500,fontSize: 14

                            ),),),
                      ),

                    ]),),

            ],
          ),
        ),
        flexibleSpace:  Stack(
          children: [
            Container(height: 30,color: const Color(0xff00417E),),
            Image(
            image: const AssetImage('assets/images/backserv.png'),
            fit: BoxFit.cover,width: size.width,
          ),
       ] ),toolbarHeight: 138,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Expanded(
          child: SingleChildScrollView( 
            child: Column(children: [
              const SizedBox(height: 10,),
            
             Column(children: [0,1,2,3,4,5,6,7].map((e) =>  Card(elevation: 5,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
               child: Container(width: size.width,
            
                 decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                 child: Column(
                   children: [
            
                     Padding(
                       padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(tr("#45432"),style: GoogleFonts.tajawal(color: Colors.black,
                               fontSize:15,fontWeight: FontWeight.w400),),
            
                           Container(height: 25,width: 80,
                             padding: const EdgeInsets.all(5),
                             decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                                 color:const Color(0xffCCD9E5) ),
                             child: Row(mainAxisAlignment: MainAxisAlignment.center,
            
                                 children: [
                                   SvgPicture.asset("assets/images/passport.svg",),
                                   const SizedBox(width: 3,),
                                   Text(tr("تأشيرة"),style: GoogleFonts.tajawal(color: Colors.black,
                                       fontSize:12,fontWeight: FontWeight.w500),),
                                 ]),
                           )
            
                         ],),
                     ),
            
                     Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
            
            
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Row(children: [
                         Container(
                           height: 45,width: 50,
                           padding: const EdgeInsets.all(11),
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff8a8c8e),
                               border: Border.all(width: 1.5,color: Colors.white,),
                               image: const DecorationImage(
                                 image: AssetImage("assets/images/Rectangle.png"), )
                           ),
                         ),
            
                         const SizedBox(width: 10,),
            
                         Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
            
                             Text("حمد هاشم",style: GoogleFonts.tajawal(color: Colors.black,
                                 fontSize:15,fontWeight: FontWeight.w500),),
                             Text("تأشيرة دولة الأمارات",style: GoogleFonts.tajawal(color: Colors.black,
                                 fontSize:13,fontWeight: FontWeight.w400),),
            
                           ],)
            
            
            
                       ],),
                     ),
            
                     Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
            
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SvgPicture.asset("assets/images/time.svg"),
                               const SizedBox(width: 5,),
                               Text(tr("25Feb,2023"),style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
                                   fontSize:12,fontWeight: FontWeight.w400),),
                             ],
                           ),
            
            
                           InkWell(onTap: () {
                        SamaOfficeApp.navKey.currentState!.push
                          (MaterialPageRoute(builder: (context) => const ServiceDetails(),));
                           },
                             child: Row(children: [
                               Text(tr("تفاصيل"),style: GoogleFonts.tajawal(color: Colors.blue,
                                   fontSize:13,fontWeight: FontWeight.w400),),
                               const SizedBox(width: 5,),

                               const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)

                             ],),
                           )
            
            
            
                         ],
                       ),
                     ),
            
            
                   ],
                 ) ,
               ),
             )).toList(),),

              const SizedBox(height: 30,),

            
            ]),
          ),
        ),
      ),


    );
  }
}
