import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_view.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_view.dart';
import 'package:sama_officese/src/app/screen/home/services/sevices_view.dart';

import '../../core/values/colors.dart';
import 'create_package/create_package_view.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 5,),
            HomeViewModel.profileModel==null?
             Container(
               height: 50,width: 50,
               padding: const EdgeInsets.all(11),
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xff8a8c8e),
                   border: Border.all(width: 1.5,color: Colors.white)
               ),
               child:Center(child: SvgPicture.asset("assets/images/user.svg",)) ,)

            :  HomeViewModel.profileModel!.image!=""|| HomeViewModel.profileModel!.image!=null?
            Container(
              height: 50,width: 50,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xff8a8c8e),
                  border: Border.all(width: 1.5,color: Colors.white)
                  ,image: DecorationImage(image:
                  NetworkImage( HomeViewModel.profileModel!.image!))
              ),
              )
            : Container(
              height: 50,width: 50,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xff8a8c8e),
              border: Border.all(width: 1.5,color: Colors.white)
              ),
              child:Center(child: SvgPicture.asset("assets/images/user.svg",)) ,),
            const SizedBox(width: 10,),
            
            
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr("welcomeBack"),style: GoogleFonts.tajawal(color: Colors.white,
                    fontSize:10,fontWeight: FontWeight.w500),),
                const SizedBox(height: 10,),
                HomeViewModel.profileModel!=null?
                Text("${ HomeViewModel.profileModel!.firstName??""} ${ HomeViewModel.profileModel!.lastName??""}",
                  style: GoogleFonts.tajawal(color: Colors.white,
                    fontSize:Platform.isIOS?25: 20,fontWeight: FontWeight.w500),)
                :const SizedBox.shrink(),
              ],
            ),
          ],
        ),
        flexibleSpace:  Stack(
          children: [
            Container(height: 30,color: const Color(0xff231f20),),

            Image(
            image: const AssetImage('assets/images/signback.png'),
            fit: BoxFit.cover,width: size.width,
          ),
        ]),toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body:

      Stack(
        children: [ Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [ Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10,),

                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    InkWell( onTap: () {
                      SamaOfficeApp.navKey.currentState!.push(
                          MaterialPageRoute(builder: (context) => const ServiceView(),));

                    },
                      child: Container( height: 165,width: 170,
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
                                    child: Text(
                                      services.isNotEmpty?
                                      servicesPending.length.toString()
                                      :"0",
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
                                tr("ServiceRequests"),
                                style: const TextStyle(
                                    color:  Colors.black,
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                               Text(
                                 servicesPending.isNotEmpty?
                            "${servicesPending.length.toString()} ${tr("newRequests")}"
                                 :tr("ThereAreCurrentlyNoRequests"),
                                style:  TextStyle(
                                    color:  Colors.grey,
                                    fontSize:
                                    servicesPending.isNotEmpty?
                                    13 : 12, fontWeight: FontWeight.w400),
                              ),

                            ],
                          )
                        ]),),
                    ),

                    InkWell(onTap: () {
                      SamaOfficeApp.navKey.currentState!.push(
                          MaterialPageRoute(builder: (context) => const PackagesOrderView(),));
                    },
                      child: Container( height: 165,width: 170,
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
                                        child: Text( packages.isNotEmpty?
                                        packagePending.length.toString()
                                            :"0",style: GoogleFonts.tajawal( color: Colors.white,fontSize: 13,
                                            fontWeight: FontWeight.w400
                                        ),),
                                      )),

                                ],
                              ),


                              const SizedBox(height: 20,),
                               Column(crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                   Text(
                                    tr("PackageRequests"),
                                    style: const TextStyle(
                                        color:  Colors.black,
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    packagePending.isNotEmpty?
                                    "${packagePending.length.toString()} ${tr("newRequests")}"
                                        :tr("ThereAreCurrentlyNoRequests"),
                                    style:  TextStyle(
                                        color:  Colors.grey,
                                        fontSize:
                                        packagePending.isNotEmpty?
                                        13 : 12, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ]),),
                    ),

                  ],),
                  const SizedBox(height: 20,),



                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(onTap: () {
                        SamaOfficeApp.navKey.currentState!.push(
                            MaterialPageRoute(builder: (context) => const PackagesView(),));
                      },
                        child: Container( height: 165,width: 170,
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
                                        padding: const EdgeInsets.all(14),
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
                                              offerPageModel!.isNotEmpty?
                                            offerPageModel!.length.toString() :"0",
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
                                      tr("Packages"),
                                      style: const TextStyle(
                                          color:  Colors.black,
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    ),
                                     Text(
                                      offerPageModel!.isNotEmpty?
                                      " ${tr("Packages")} ${offerPageModel!.length}"
                                       :tr("ThereAreNoPackages")
                                       ,
                                      style: const TextStyle(
                                          color:  Colors.grey,
                                          fontSize: 13, fontWeight: FontWeight.w400),
                                    ),

                                  ],
                                )
                              ]),),
                      ),
                      InkWell(onTap: () {
                        SamaOfficeApp.navKey.currentState!.push(
                            MaterialPageRoute(builder: (context) => const CreatePackageView(),));
                      },
                        child: Container( height: 165,width: 170,
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
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                            color:const Color(0xff8a8c8e) ),
                                        child: SvgPicture.asset("assets/images/add.svg",)),


                                  const SizedBox(width: 27,)

                                  ],
                                ),


                                const SizedBox(height: 30,),
                                 Column(crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      tr("CreatePackage"),
                                      style: const TextStyle(
                                          color:  Colors.black,
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    ),


                                  ],
                                )
                              ]),),
                      ),

                    ],),






                ]),
              ),
            ),
          ]),
        ),

          isLoading==true?
          SizedBox(
              height: size.height/1,
              child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
              )))
              :const SizedBox.shrink()



      ]),


    );
  }
}
