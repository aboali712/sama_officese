// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
// import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';
// import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
// import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';
//
//
// import '../../../../app.dart';
// import '../../../core/values/colors.dart';
//
// class PackagesOrderView extends StatefulWidget {
//   const PackagesOrderView({Key? key}) : super(key: key);
//
//   @override
//   State<PackagesOrderView> createState() => _PackagesOrderViewState();
// }
//
// class _PackagesOrderViewState extends PackagesOrderViewModel {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xffFCFCFF),
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.only(left: 10,right: 10),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Row(children: [
//
//                 InkWell( onTap: () {
//                   Navigator.pop(context);
//                 }
//                     ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
//                  Text(
//                   tr("PackageRequests"),
//                   style: GoogleFonts.tajawal(
//                       color:  Colors.white,
//                       fontSize: 21, fontWeight: FontWeight.w500),
//                 ),
//
//               ],),
//               const SizedBox(height: 10,),
//
//
//               Container(height: 45,width: size.width,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//                     border:Border.all(width: .7,color: Colors.grey.shade400) ),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       InkWell(onTap: () {
//                         setState(() {
//                           packageStat=0;
//                         });
//                       },
//                         child: Container(height: 43,width: 110,
//                           padding: const EdgeInsets.all(13),
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//                             color:packageStat==0? Colors.white :Colors.transparent,
//                           ),
//                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                   height: 18,width: 18,
//                                   padding: const EdgeInsets.all(3),
//                                   decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
//                                       color:const Color(0xff5AC41A) ),
//                                   child: Center(
//                                     child: Text(packagePending.length.toString(),
//                                       style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
//                                         fontWeight: FontWeight.w400
//                                     ),),
//                                   )),
//                               const SizedBox(width: 5,),
//
//                               Text(tr("New"),
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.tajawal(color:packageStat==0?  Colors.black: Colors.white54,
//                                     fontWeight: FontWeight.w500,fontSize: 14
//
//                                 ),),
//                             ],
//                           ),),
//                       ),
//
//                       InkWell(onTap: () {
//                         setState(() {
//                           packageStat=1;
//                         });
//                       },
//                         child: Container(height: 43,width: 110,
//                           padding: const EdgeInsets.all(9),
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//                             color: packageStat==1?Colors.white :Colors.transparent,
//                           ),
//                           child: Row(
//                             children: [
//                               packageStat==1?
//                               Container(
//                                   height: 18,width: 18,
//                                   padding: const EdgeInsets.all(3),
//                                   decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
//                                       color:const Color(0xff5AC41A) ),
//                                   child: Center(
//                                     child: Text(packageInReview.length.toString(),
//                                       style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
//                                           fontWeight: FontWeight.w400
//                                       ),),
//                                   )):const SizedBox.shrink(),
//                               const SizedBox(width: 5,),
//
//                               Text(tr("Underway"),
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.tajawal(color:packageStat==1? Colors.black: Colors.white54,
//                                     fontWeight: FontWeight.w500,fontSize: 14
//
//                                 ),),
//                             ],
//                           ),),
//                       ),
//
//                       InkWell(onTap: () {
//                         setState(() {
//                           packageStat=2;
//                         });
//                       },
//                         child: Container(height: 43,width: 110,
//                           padding: const EdgeInsets.all(11),
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//                             color: packageStat==2? Colors.white :Colors.transparent ,
//                           ),
//                           child: Row(
//                             children: [
//                               packageStat==2?
//                               Container(
//                                   height: 18,width: 18,
//                                   padding: const EdgeInsets.all(3),
//                                   decoration: BoxDecoration(borderRadius:  BorderRadius.circular(14),
//                                       color:const Color(0xff5AC41A) ),
//                                   child: Center(
//                                     child: Text(packageCompleted.length.toString(),
//                                       style: GoogleFonts.tajawal( color: Colors.white,fontSize: 12,
//                                           fontWeight: FontWeight.w400
//                                       ),),
//                                   )) :const SizedBox.shrink(),
//                               const SizedBox(width: 5,),
//
//                               Text(tr("Complete"),
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.tajawal(color:packageStat==2? Colors.black: Colors.white54,
//                                     fontWeight: FontWeight.w500,fontSize: 14
//
//                                 ),),
//                             ],
//                           ),),
//                       ),
//
//                     ]),),
//
//             ],
//           ),
//         ),
//         flexibleSpace:  Stack(
//             children: [
//                Container(height: 30,color: const Color(0xff00A8A5),),
//               Image(
//                 image: const AssetImage('assets/images/backpackage.png'),
//                 fit: BoxFit.cover,width: size.width,
//               ),
//             ] ),toolbarHeight: 138,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//       ),
//       body: Stack(
//         children:[
//           Padding(
//           padding: const EdgeInsets.only(left: 10,right: 10),
//           child: Flex(direction: Axis.horizontal,
//             children: [
//
//               Expanded(
//               child: RefreshIndicator(
//                 edgeOffset: 50,color: samaColor,
//                 onRefresh: () async {
//                   setState(() {
//                     set=1;
//                   });
//                   await getReservationsApi();
//                   },
//                 child: ListView(
//                   children:[ Column(children: [
//                     const SizedBox(height: 10,),
//
//                     packageStat==0?
//                    Column(children: [
//                      packagePending.isNotEmpty?
//                      Column(children: packagePending.map((e) =>
//                          Card(elevation: 5,
//                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                            child: Container(width: size.width,
//
//                              decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
//                              child: Column(
//                                children: [
//
//                                  Padding(
//                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
//                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      crossAxisAlignment: CrossAxisAlignment.end,
//                                      children: [
//                                        Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
//                                            fontSize:15,fontWeight: FontWeight.w400),),
//
//                                        Container(height: 25,
//                                          padding: const EdgeInsets.all(5),
//                                          decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
//                                              color:const Color(0xffCCEEED) ),
//                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
//
//                                              children: [
//                                                SvgPicture.asset("assets/images/packplan.svg",),
//                                                const SizedBox(width: 3,),
//                                                Text(
//                                                  e.offer!.type=="weekend"?
//                                                  tr("weekend")
//                                                      :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
//                                                    fontSize:12,fontWeight: FontWeight.w500),),
//                                              ]),
//                                        )
//
//                                      ],),
//                                  ),
//
//                                  Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//
//                                  Padding(
//                                    padding: const EdgeInsets.all(10.0),
//                                    child: Row(children: [
//                                      Container(
//                                        height: 45,width: 50,
//                                        padding: const EdgeInsets.all(11),
//                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                                            color: const Color(0xff8a8c8e),
//                                            border: Border.all(width: 1.5,color: Colors.white,),
//                                            image:  DecorationImage(
//                                                image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
//                                        ),
//                                      ),
//
//                                      const SizedBox(width: 10,),
//
//                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//
//                                          Text("${e.user!.firstName} ${e.user!.lastName}",
//                                            style: GoogleFonts.tajawal(color: Colors.black,
//                                              fontSize:15,fontWeight: FontWeight.w500),),
//                                          SizedBox(width: 250,
//                                            child: Text(
//                                              HomeViewModel.lang=="ar"?
//                                              e.offer!.name!
//                                                  :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
//                                                fontSize:13,fontWeight: FontWeight.w400),),
//                                          ),
//
//                                        ],)
//
//
//
//                                    ],),
//                                  ),
//
//                                  Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//                                  Padding(
//                                    padding: const EdgeInsets.all(10.0),
//                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      children: [
//                                        Row(crossAxisAlignment: CrossAxisAlignment.center,
//                                          children: [
//                                            SvgPicture.asset("assets/images/time.svg"),
//                                            const SizedBox(width: 5,),
//                                            Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
//                                              style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
//                                                  fontSize:12,fontWeight: FontWeight.w400),),
//                                          ],
//                                        ),
//
//
//                                        InkWell(onTap: () {
//                                          setState(() {
//                                            PackagesOrderDetailsViewModel.bookingsServiceModel=e;
//                                          });
//                                          SamaOfficeApp.navKey.currentState!.push
//                                            (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
//                                        },
//                                          child: Row(children: [
//                                            Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
//                                                fontSize:13,fontWeight: FontWeight.w400),),
//                                            const SizedBox(width: 5,),
//
//                                            const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)
//
//                                          ],),
//                                        )
//
//
//
//                                      ],
//                                    ),
//                                  ),
//
//
//                                ],
//                              ) ,
//                            ),
//                          )).toList(),)
//                          :Container(
//                        margin: EdgeInsets.only(
//                            top: MediaQuery.of(context).size.height / 5),
//                        child: Column(
//                          children: [
//                            SvgPicture.asset("assets/images/empty_orders.svg"),
//                            const SizedBox(
//                              height: 20,
//                            ),
//                            Text(
//                              tr("no_orders"),
//                              style: const TextStyle(
//                                  fontSize: 17, fontWeight: FontWeight.bold),
//                            ),
//                            const SizedBox(
//                              height: 10,
//                            ),
//                            Text(textAlign: TextAlign.center,
//                              tr("NoOrdersDesc"),
//                              style: const TextStyle(
//                                  fontSize: 15, fontWeight: FontWeight.w500),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],)
//                   :  packageStat==1?
//                     Column(children: [
//                       packageInReview.isNotEmpty?
//                       Column(children: packageInReview.map((e) =>
//                           Card(elevation: 5,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             child: Container(width: size.width,
//
//                               decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
//                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
//                                             fontSize:15,fontWeight: FontWeight.w400),),
//
//                                         Container(height: 25,
//                                           padding: const EdgeInsets.all(5),
//                                           decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
//                                               color:const Color(0xffCCEEED) ),
//                                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//
//                                               children: [
//                                                 SvgPicture.asset("assets/images/packplan.svg",),
//                                                 const SizedBox(width: 3,),
//                                                 Text(
//                                                   e.offer!.type=="weekend"?
//                                                   tr("weekend")
//                                                       :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
//                                                     fontSize:12,fontWeight: FontWeight.w500),),
//                                               ]),
//                                         )
//
//                                       ],),
//                                   ),
//
//                                   Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(children: [
//                                       Container(
//                                         height: 45,width: 50,
//                                         padding: const EdgeInsets.all(11),
//                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                                             color: const Color(0xff8a8c8e),
//                                             border: Border.all(width: 1.5,color: Colors.white,),
//                                             image:  DecorationImage(
//                                                 image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
//                                         ),
//                                       ),
//
//                                       const SizedBox(width: 10,),
//
//                                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//
//                                           Text("${e.user!.firstName} ${e.user!.lastName}",
//                                             style: GoogleFonts.tajawal(color: Colors.black,
//                                               fontSize:15,fontWeight: FontWeight.w500),),
//                                           SizedBox(width: 250,
//                                             child: Text(
//                                               HomeViewModel.lang=="ar"?
//                                               e.offer!.name!
//                                                   :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
//                                                 fontSize:13,fontWeight: FontWeight.w400),),
//                                           ),
//
//                                         ],)
//
//
//
//                                     ],),
//                                   ),
//
//                                   Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset("assets/images/time.svg"),
//                                             const SizedBox(width: 5,),
//                                             Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
//                                               style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
//                                                   fontSize:12,fontWeight: FontWeight.w400),),
//                                           ],
//                                         ),
//
//
//                                         InkWell(onTap: () {
//                                           setState(() {
//                                             PackagesOrderDetailsViewModel.bookingsServiceModel=e;
//                                           });
//                                           SamaOfficeApp.navKey.currentState!.push
//                                             (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
//                                         },
//                                           child: Row(children: [
//                                             Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
//                                                 fontSize:13,fontWeight: FontWeight.w400),),
//                                             const SizedBox(width: 5,),
//
//                                             const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)
//
//                                           ],),
//                                         )
//
//
//
//                                       ],
//                                     ),
//                                   ),
//
//
//                                 ],
//                               ) ,
//                             ),
//                           )).toList(),)
//                           :Container(
//                         margin: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height / 5),
//                         child: Column(
//                           children: [
//                             SvgPicture.asset("assets/images/empty_orders.svg"),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               tr("no_orders"),
//                               style: const TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(textAlign: TextAlign.center,
//                               tr("NoOrdersDesc"),
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],)
//                                    :   Column(children: [
//                       packageCompleted.isNotEmpty?
//                       Column(children: packageCompleted.map((e) =>
//                           Card(elevation: 5,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             child: Container(width: size.width,
//
//                               decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
//                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text("#${e.id}",style: GoogleFonts.tajawal(color: Colors.black,
//                                             fontSize:15,fontWeight: FontWeight.w400),),
//
//                                         Container(height: 25,
//                                           padding: const EdgeInsets.all(5),
//                                           decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
//                                               color:const Color(0xffCCEEED) ),
//                                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//
//                                               children: [
//                                                 SvgPicture.asset("assets/images/packplan.svg",),
//                                                 const SizedBox(width: 3,),
//                                                 Text(
//                                                   e.offer!.type=="weekend"?
//                                                   tr("weekend")
//                                                       :tr("aTrip"),style: GoogleFonts.tajawal(color: Colors.black,
//                                                     fontSize:12,fontWeight: FontWeight.w500),),
//                                               ]),
//                                         )
//
//                                       ],),
//                                   ),
//
//                                   Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(children: [
//                                       Container(
//                                         height: 45,width: 50,
//                                         padding: const EdgeInsets.all(11),
//                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                                             color: const Color(0xff8a8c8e),
//                                             border: Border.all(width: 1.5,color: Colors.white,),
//                                             image:  DecorationImage(
//                                                 image: NetworkImage(e.user!.image!), fit: BoxFit.cover)
//                                         ),
//                                       ),
//
//                                       const SizedBox(width: 10,),
//
//                                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//
//                                           Text("${e.user!.firstName} ${e.user!.lastName}",
//                                             style: GoogleFonts.tajawal(color: Colors.black,
//                                               fontSize:15,fontWeight: FontWeight.w500),),
//                                           SizedBox(width: 250,
//                                             child: Text(
//                                               HomeViewModel.lang=="ar"?
//                                               e.offer!.name!
//                                                   :e.offer!.nameEn!,style: GoogleFonts.tajawal(color: Colors.black,
//                                                 fontSize:13,fontWeight: FontWeight.w400),),
//                                           ),
//
//                                         ],)
//
//
//
//                                     ],),
//                                   ),
//
//                                   Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),
//
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset("assets/images/time.svg"),
//                                             const SizedBox(width: 5,),
//                                             Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(e.createdAt!)),
//                                               style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
//                                                   fontSize:12,fontWeight: FontWeight.w400),),
//                                           ],
//                                         ),
//
//
//                                         InkWell(onTap: () {
//                                           setState(() {
//                                             PackagesOrderDetailsViewModel.bookingsServiceModel=e;
//                                           });
//                                           SamaOfficeApp.navKey.currentState!.push
//                                             (MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));
//                                         },
//                                           child: Row(children: [
//                                             Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.blue,
//                                                 fontSize:13,fontWeight: FontWeight.w400),),
//                                             const SizedBox(width: 5,),
//
//                                             const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)
//
//                                           ],),
//                                         )
//
//
//
//                                       ],
//                                     ),
//                                   ),
//
//
//                                 ],
//                               ) ,
//                             ),
//                           )).toList(),)
//                           :Container(
//                         margin: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height / 5),
//                         child: Column(
//                           children: [
//                             SvgPicture.asset("assets/images/empty_orders.svg"),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               tr("no_orders"),
//                               style: const TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(textAlign: TextAlign.center,
//                               tr("NoOrdersDesc"),
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],) ,
//
//                     const SizedBox(height: 30,),
//
//
//                   ]),
//                 ]),
//               ),
//             ),
//           ]),
//         ),
//
//
//           isLoading==true?
//           SizedBox(
//               height: size.height/1.80,
//               child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
//               )))
//               :const SizedBox.shrink()
//
//
//
//
//
//         ]),
//
//
//     );
//   }
// }


// Import necessary packages for Flutter UI and localization
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Import project-specific view models and utilities
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';

import '../../../../app.dart';
import '../../../core/values/colors.dart';

// Main widget for displaying the package orders view
class PackagesOrderView extends StatefulWidget {
  const PackagesOrderView({Key? key}) : super(key: key);

  @override
  State<PackagesOrderView> createState() => _PackagesOrderViewState();
}

// State class for handling the logic and UI of the PackagesOrderView
class _PackagesOrderViewState extends PackagesOrderViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get the size of the screen

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  Text(
                    tr("PackageRequests"),
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Tabs for switching between package statuses
              Container(
                height: 45,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.7, color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tab for new packages
                    _buildTab(
                      title: tr("New"),
                      count: packagePending.length,
                      isActive: packageStat == 0,
                      onTap: () {
                        setState(() {
                          packageStat = 0;
                        });
                      },
                    ),
                    // Tab for packages underway
                    _buildTab(
                      title: tr("Underway"),
                      count: packageInReview.length,
                      isActive: packageStat == 1,
                      onTap: () {
                        setState(() {
                          packageStat = 1;
                        });
                      },
                    ),
                    // Tab for completed packages
                    _buildTab(
                      title: tr("Complete"),
                      count: packageCompleted.length,
                      isActive: packageStat == 2,
                      onTap: () {
                        setState(() {
                          packageStat = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Flexible background with an image
        flexibleSpace: Stack(
          children: [
            Container(height: 30, color: const Color(0xff00A8A5)),
            Image(
              image: const AssetImage('assets/images/backpackage.png'),
              fit: BoxFit.cover,
              width: size.width,
            ),
          ],
        ),
        toolbarHeight: 138,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    edgeOffset: 50,
                    color: samaColor,
                    onRefresh: () async {
                      setState(() {
                        set = 1;
                      });
                      await getReservationsApi();
                    },
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),

                        // Display the appropriate list based on the selected tab
                        if (packageStat == 0)
                          _buildPackageList(packagePending, size)
                        else if (packageStat == 1)
                          _buildPackageList(packageInReview, size)
                        else
                          _buildPackageList(packageCompleted, size),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading indicator
          if (isLoading)
            SizedBox(
              height: size.height / 1.80,
              child: const Center(
                child: CircularProgressIndicator(
                  color: samaOfficeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget to build each tab
  Widget _buildTab({
    required String title,
    required int count,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43,
        width: 110,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive ? Colors.white : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive)
              Container(
                height: 18,
                width: 18,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff5AC41A),
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
             SizedBox(width:isActive?2: 5),
            Text(
              title,
              style: GoogleFonts.tajawal(
                color: isActive ? Colors.black : Colors.white54,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the list of packages based on their status
  Widget _buildPackageList(List<dynamic> packages, Size size) {
    if (packages.isNotEmpty) {
      return Column(
        children: packages.map((e) => _buildPackageCard(e, size)).toList(),
      );
    } else {
      return _buildEmptyState();
    }
  }

  // Widget to build each package card
  Widget _buildPackageCard(dynamic e, Size size) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Package ID and type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "#${e.id}",
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 25,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffCCEEED),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/packplan.svg"),
                        const SizedBox(width: 3),
                        Text(
                          e.offer!.type == "weekend"
                              ? tr("weekend")
                              : tr("aTrip"),
                          style: GoogleFonts.tajawal(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 5, thickness: 1, color: Colors.grey.shade300),

            // User details and package name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // User profile image
                  Container(
                    height: 45,
                    width: 50,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff8a8c8e),
                      border: Border.all(width: 1.5, color: Colors.white),
                      image: DecorationImage(
                        image: NetworkImage(e.user!.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // User name and package name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${e.user!.firstName} ${e.user!.lastName}",
                        style: GoogleFonts.tajawal(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          HomeViewModel.lang == "ar"
                              ? e.offer!.name!
                              : e.offer!.nameEn!,
                          style: GoogleFonts.tajawal(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(height: 5, thickness: 1, color: Colors.grey.shade300),

            // Date and details button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Package date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/time.svg"),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat("MMM d, yyyy", "en")
                            .format(DateTime.parse(e.createdAt!)),
                        style: GoogleFonts.tajawal(
                          color: const Color(0xff9196AE),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  // Details button
                  InkWell(
                    onTap: () {
                      setState(() {
                        PackagesOrderDetailsViewModel.reservationId = e.id.toString();
                      });
                      SamaOfficeApp.navKey.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => const PackagesOrderDetailsView(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          tr("Details"),
                          style: GoogleFonts.tajawal(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display when the package list is empty
  Widget _buildEmptyState() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/empty_orders.svg"),
          const SizedBox(height: 20),
          Text(
            tr("no_orders"),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tr("NoOrdersDesc"),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
