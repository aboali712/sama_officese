import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';


import '../../../../app.dart';

class PackagesOrderView extends StatefulWidget {
  const PackagesOrderView({Key? key}) : super(key: key);

  @override
  State<PackagesOrderView> createState() => _PackagesOrderViewState();
}

class _PackagesOrderViewState extends PackagesOrderViewModel {
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
                 Text(
                  tr("PackageRequests"),
                  style: const TextStyle(
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
                          packageStat=0;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:packageStat==0? Colors.white :Colors.transparent,
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 18,width: 18,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                      color:const Color(0xff5AC41A) ),
                                  child: Center(
                                    child: Text(packagePending.length.toString(),
                                      style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  )),
                              const SizedBox(width: 5,),

                              Text(tr("New"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(color:packageStat==0?  Colors.black: Colors.white54,
                                    fontWeight: FontWeight.w500,fontSize: 14

                                ),),
                            ],
                          ),),
                      ),

                      InkWell(onTap: () {
                        setState(() {
                          packageStat=1;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: packageStat==1?Colors.white :Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              packageStat==1?
                              Container(
                                  height: 18,width: 18,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                      color:const Color(0xff5AC41A) ),
                                  child: Center(
                                    child: Text(packageInReview.length.toString(),
                                      style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
                                          fontWeight: FontWeight.w400
                                      ),),
                                  )):const SizedBox.shrink(),
                              const SizedBox(width: 5,),

                              Text(tr("Underway"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(color:packageStat==1? Colors.black: Colors.white54,
                                    fontWeight: FontWeight.w500,fontSize: 14

                                ),),
                            ],
                          ),),
                      ),

                      InkWell(onTap: () {
                        setState(() {
                          packageStat=2;
                        });
                      },
                        child: Container(height: 43,width: 110,
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: packageStat==2? Colors.white :Colors.transparent ,
                          ),
                          child: Row(
                            children: [
                              packageStat==2?
                              Container(
                                  height: 18,width: 18,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
                                      color:const Color(0xff5AC41A) ),
                                  child: Center(
                                    child: Text(packageCompleted.length.toString(),
                                      style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
                                          fontWeight: FontWeight.w400
                                      ),),
                                  )) :const SizedBox.shrink(),
                              const SizedBox(width: 5,),

                              Text(tr("Complete"),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(color:packageStat==2? Colors.black: Colors.white54,
                                    fontWeight: FontWeight.w500,fontSize: 14

                                ),),
                            ],
                          ),),
                      ),

                    ]),),

            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [
               Container(height: 30,color: const Color(0xff00A8A5),),
              Image(
                image: const AssetImage('assets/images/backpackage.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 138,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Flex(direction: Axis.horizontal,
          children: [ Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 10,),

                packageStat==0?
               Column(children: [
                 packagePending.isNotEmpty?
                 Column(children: packagePending.map((e) =>
                     Card(elevation: 5,
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
                                   Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
                                       fontSize:15,fontWeight: FontWeight.w400),),

                                   Container(height: 25,
                                     padding: const EdgeInsets.all(5),
                                     decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                                         color:const Color(0xffCCEEED) ),
                                     child: Row(mainAxisAlignment: MainAxisAlignment.center,

                                         children: [
                                           SvgPicture.asset("assets/images/packplan.svg",),
                                           const SizedBox(width: 3,),
                                           Text(
                                             e.offer!.type=="weekend"?
                                             tr("weekend")
                                                 :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
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
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                       color: const Color(0xff8a8c8e),
                                       border: Border.all(width: 1.5,color: Colors.white,),
                                       image:  DecorationImage(
                                           image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
                                   ),
                                 ),

                                 const SizedBox(width: 10,),

                                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [

                                     Text("${e.user!.firstName} ${e.user!.lastName}",
                                       style: GoogleFonts.tajawal(color: Colors.black,
                                         fontSize:15,fontWeight: FontWeight.w500),),
                                     SizedBox(width: 250,
                                       child: Text(
                                         HomeViewModel.lang=="ar"?
                                         e.offer!.name!
                                             :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
                                           fontSize:13,fontWeight: FontWeight.w400),),
                                     ),

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
                                       Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
                                         style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
                                             fontSize:12,fontWeight: FontWeight.w400),),
                                     ],
                                   ),


                                   InkWell(onTap: () {
                                     setState(() {
                                       PackagesOrderDetailsViewModel.bookingsServiceModel=e;
                                     });
                                     SamaOfficeApp.navKey.currentState!.push
                                       (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
                                   },
                                     child: Row(children: [
                                       Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
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
                     )).toList(),)
                     :Container(
                   margin: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height / 5),
                   child: Column(
                     children: [
                       SvgPicture.asset("assets/images/empty_orders.svg"),
                       const SizedBox(
                         height: 20,
                       ),
                       Text(
                         tr("no_orders"),
                         style: const TextStyle(
                             fontSize: 17, fontWeight: FontWeight.bold),
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Text(textAlign: TextAlign.center,
                         tr("NoOrdersDesc"),
                         style: const TextStyle(
                             fontSize: 15, fontWeight: FontWeight.w500),
                       ),
                     ],
                   ),
                 ),
               ],)
              :  packageStat==1?
                Column(children: [
                  packageInReview.isNotEmpty?
                  Column(children: packageInReview.map((e) =>
                      Card(elevation: 5,
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
                                    Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
                                        fontSize:15,fontWeight: FontWeight.w400),),

                                    Container(height: 25,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                                          color:const Color(0xffCCEEED) ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            SvgPicture.asset("assets/images/packplan.svg",),
                                            const SizedBox(width: 3,),
                                            Text(
                                              e.offer!.type=="weekend"?
                                              tr("weekend")
                                                  :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff8a8c8e),
                                        border: Border.all(width: 1.5,color: Colors.white,),
                                        image:  DecorationImage(
                                            image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
                                    ),
                                  ),

                                  const SizedBox(width: 10,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${e.user!.firstName} ${e.user!.lastName}",
                                        style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                      Text(
                                        HomeViewModel.lang=="ar"?
                                        e.offer!.name!
                                            :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
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
                                        Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
                                          style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
                                              fontSize:12,fontWeight: FontWeight.w400),),
                                      ],
                                    ),


                                    InkWell(onTap: () {
                                      setState(() {
                                        PackagesOrderDetailsViewModel.bookingsServiceModel=e;
                                      });
                                      SamaOfficeApp.navKey.currentState!.push
                                        (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
                                    },
                                      child: Row(children: [
                                        Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
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
                      )).toList(),)
                      :Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5),
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/images/empty_orders.svg"),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          tr("no_orders"),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(textAlign: TextAlign.center,
                          tr("NoOrdersDesc"),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],)
                    :   Column(children: [
                  packageCompleted.isNotEmpty?
                  Column(children: packageCompleted.map((e) =>
                      Card(elevation: 5,
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
                                    Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
                                        fontSize:15,fontWeight: FontWeight.w400),),

                                    Container(height: 25,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                                          color:const Color(0xffCCEEED) ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            SvgPicture.asset("assets/images/packplan.svg",),
                                            const SizedBox(width: 3,),
                                            Text(
                                              e.offer!.type=="weekend"?
                                              tr("weekend")
                                                  :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff8a8c8e),
                                        border: Border.all(width: 1.5,color: Colors.white,),
                                        image:  DecorationImage(
                                            image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
                                    ),
                                  ),

                                  const SizedBox(width: 10,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${e.user!.firstName} ${e.user!.lastName}",
                                        style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                      Text(
                                        HomeViewModel.lang=="ar"?
                                        e.offer!.name!
                                            :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
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
                                        Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
                                          style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
                                              fontSize:12,fontWeight: FontWeight.w400),),
                                      ],
                                    ),


                                    InkWell(onTap: () {
                                      setState(() {
                                        PackagesOrderDetailsViewModel.bookingsServiceModel=e;
                                      });
                                      SamaOfficeApp.navKey.currentState!.push
                                        (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
                                    },
                                      child: Row(children: [
                                        Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
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
                      )).toList(),)
                      :Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5),
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/images/empty_orders.svg"),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          tr("no_orders"),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(textAlign: TextAlign.center,
                          tr("NoOrdersDesc"),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],)
                ,

                const SizedBox(height: 30,),


              ]),
            ),
          ),
        ]),
      ),


    );
  }
}
