import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';

import '../../../../core/values/colors.dart';
import '../../../chat_page/chat_view.dart';
import '../../packages_order/packages_order_viewmodel.dart';
import 'conversations_viewmodel.dart';

class ConversationsView extends StatefulWidget {
  const ConversationsView({super.key});

  @override
  State<ConversationsView> createState() => _ConversationsViewState();
}

class _ConversationsViewState extends ConversationsViewModel{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: samaColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.light,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.light) /* set Status bar icon color in iOS. */
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        isLoading
            ? const Center(child: CircularProgressIndicator(),)
            :const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Platform.isIOS
                  ? const SizedBox(
                height: 45,
              )
                  : const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: () {
                    Navigator.pop(context);

                  },
                    child: Row(
                      children: [
                        SizedBox(width: 10,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(width: 10,),
                        SvgPicture.asset(
                          "assets/images/logo22.svg",height: 20,width: 20,

                        ),


                      ],
                    ),
                  ),
                  Text(tr("Conversations"),
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              Expanded(
                child: SingleChildScrollView(

                  child:
                  conversationModel.isNotEmpty?
                  Column(children:

                  conversationModel.map((e) => Builder(
                      builder: (context) {
                        var parsed = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(e.date.toString()));
                        var dateFormat = DateFormat.yMd().add_jm();
                        var formatted = dateFormat.format(parsed).toString();
                        return InkWell(onTap: () {
                          setState(() {
                            PackagesOrderViewModel.bookingId= e.orderId.toString();
                            PackagesOrderViewModel.userMdole=HomeViewModel.profileModel;
                            PackagesOrderViewModel.userId= e.officeId.toString();
                          });
                          SamaOfficeApp.navKey
                              .currentState!
                              .push(
                            MaterialPageRoute(
                                builder:
                                    (context) =>
                                const ChatView()),
                          );

                        },
                          child: Card(elevation:5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: size.width,

                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        SvgPicture.asset(
                                          "assets/images/logo22.svg",height: 18,width: 18,
                                        ),
                                        const SizedBox(width: 10,),

                                        Text("${tr("orderNumber")} :".toString(),style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,
                                            fontSize: 14),),
                                        Text(e.orderId.toString(),style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),),],),


                                      Text(formatted.toString(),style: GoogleFonts.tajawal(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                      ),)
                                    ],),
                                  const SizedBox(height: 10,),


                                  Row(children: [
                                    Image.asset(
                                      "assets/images/conversations.png",height: 20,width: 20,color: samaColor,),
                                    const SizedBox(width: 5,),

                                    Text(
                                      e.type=="text"?
                                      e.message.toString()
                                          :"${tr("MessageFromTheMedia")}...."
                                      ,style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,
                                        fontSize: 14),),
                                  ],),




                                ],),


                            ),
                          ),
                        );
                      }
                  )).toList(),)
                      :Center(
                    child: Column( mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 120,),
                        SvgPicture.asset("assets/images/wish.svg"),
                        const SizedBox(height: 50,),
                        Text(tr("ThereAreNoConversations"),style: GoogleFonts.tajawal( fontWeight: FontWeight.bold,
                            fontSize: 17
                        )),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),

        isLoading==true?
        SizedBox(
          height: size.height / 1,
          child: const Center(
            child: CircularProgressIndicator(
              color: samaOfficeColor,
            ),
          ),
        )
            :const SizedBox.shrink()


      ]),
    );  }
  }

