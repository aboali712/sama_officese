// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../core/values/colors.dart';
// import 'notifications_viewmodel.dart';
//
// class NotificationsView extends StatefulWidget {
//   const NotificationsView({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationsView> createState() => _NotificationsViewState();
// }
//
// class _NotificationsViewState extends NotificationsViewModel {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         surfaceTintColor: Colors.transparent,
//         title: Row(
//           children: [
//             const SizedBox(width: 20,),
//
//             Text(tr("Notifications"),style: GoogleFonts.tajawal(color: Colors.white,
//                 fontSize:Platform.isIOS?25: 20,fontWeight: FontWeight.w500),),
//           ],
//         ),
//         flexibleSpace:  Stack(
//           children: [
//           Container(height: 30,color: const Color(0xff231f20),),
//
//         Image(
//             image: const AssetImage('assets/images/signback.png'),
//             fit: BoxFit.cover,width: size.width,
//           ),
//         ]),toolbarHeight: 120,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//           padding: const EdgeInsets.only(left: 10,right: 10),
//           child: Flex(
//             direction: Axis.horizontal,
//             children: [ Expanded(
//               child: SingleChildScrollView(
//                 child: Column(children: [
//                   const SizedBox(height: 10,),
//
//                   Column(children:
//                   notificationModel!=null?
//                   notificationModel!.map((e) =>   Card(elevation: 5,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     child: Container(width: size.width,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
//                       child: Row(crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             SvgPicture.asset("assets/images/lognoti.svg",),
//                             const SizedBox(width: 10,),
//
//                             Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(e.title!,style: GoogleFonts.tajawal(color: Colors.black,
//                                     fontSize:15,fontWeight: FontWeight.w500),),
//
//
//                                 SizedBox(width: 270,
//                                   child: Text(e.message!,style: GoogleFonts.tajawal(color: Colors.black,
//                                       fontSize:12,fontWeight: FontWeight.w400),),
//                                 ),
//
//
//                                 Row(crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SvgPicture.asset("assets/images/time.svg"),
//                                     const SizedBox(width: 5,),
//                                     Text(tr("25Feb,2023"),style: GoogleFonts.tajawal(color: const Color(0xff9196AE),
//                                         fontSize:12,fontWeight: FontWeight.w400),),
//                                   ],
//                                 ),
//
//                               ],)
//
//
//                           ]) ,
//                     ),
//                   )).toList():[],)
//
//
//
//
//
//                 ]),
//               ),
//             ),
//           ]),
//         ),
//
//           isLoading==true?
//           SizedBox(
//               height: size.height/1,
//               child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
//               )))
//               :const SizedBox.shrink()
//
//
//
//           ,
//       ]),
//
//
//     );
//   }
// }


import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/values/colors.dart';
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
      appBar: _buildAppBar(size), // Builds the custom AppBar
      body: Stack(
        children: [
          _buildNotificationList(size), // Builds the list of notifications
          if (isLoading)
            SizedBox(
              height: size.height,
              child: const Center(
                child: CircularProgressIndicator(color: samaOfficeColor),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the custom AppBar with a background image and title
  AppBar _buildAppBar(Size size) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            tr("Notifications"),
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: Platform.isIOS ? 25 : 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      flexibleSpace: Stack(
        children: [
          Container(height: 30, color: const Color(0xff231f20)),
          Image.asset(
            'assets/images/signback.png',
            fit: BoxFit.cover,
            width: size.width,
          ),
        ],
      ),
      toolbarHeight: 120,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }

  ///Builds the list of notifications
  Widget _buildNotificationList(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildNotificationCards(size), // Builds notification cards
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the notification cards
  Widget _buildNotificationCards(Size size) {
    if (notificationModel == null) return const SizedBox.shrink();

    return Column(
      children: notificationModel!.map((notification) {
        return InkWell(onTap: () {
          goto(notification);
        },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/lognoti.svg",),
                  const SizedBox(width: 10),
                  _buildNotificationDetails(notification), // Builds the details of each notification
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds the details of each notification
  Widget _buildNotificationDetails(notification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          notification.title!,
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 270,
          child: Text(
            notification.message!,
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/time.svg"),
            const SizedBox(width: 5),
            Text(
              tr("25Feb,2023"),
              style: GoogleFonts.tajawal(
                color: const Color(0xff9196AE),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
