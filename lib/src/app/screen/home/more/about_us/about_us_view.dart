import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../more_viewModel.dart';
import 'about_us_viewmodel.dart';



class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends AboutUsViewModel {
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
                    MoreViewModel.typePage == "0"
                        ? tr("AboutUs")
                        : MoreViewModel.typePage == "2"

                        ? tr("Privacy")
                        : MoreViewModel.typePage == "3"
                        ? tr("UsageInstructions")
                        : tr("UsageInstructions"),
                    style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,  fontSize: 20,color: Colors.white)),

              ],),





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
      body: Flex(
        direction: Axis.horizontal,
        children: [ Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  const SizedBox(
                  height: 20,
                ),
                  SvgPicture.asset(
                    "assets/images/logoo.svg",height: 60,width: 110,
                    
                  ),
                    
                  
              
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Html(
                        data: MoreViewModel.typePage == "0"
                            ? MoreViewModel.settingsModel!.about!
                            : MoreViewModel.typePage == "2"
                            ? MoreViewModel.settingsModel!.privacy!
                            : MoreViewModel.typePage == "3"
                            ? MoreViewModel.settingsModel!.office_terms!
                            : MoreViewModel.settingsModel!.terms!,
                        style: {
                          'div': Style(textAlign: TextAlign.start),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
