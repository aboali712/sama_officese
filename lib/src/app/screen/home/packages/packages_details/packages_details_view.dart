

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../chat/chat_page.dart';
import '../../../../core/values/colors.dart';
import '../update_package/upDate_viewModel.dart';

class PackagesDetails extends StatefulWidget {
  const PackagesDetails({Key? key}) : super(key: key);

  @override
  State<PackagesDetails> createState() => _PackagesDetailsState();
}

class _PackagesDetailsState extends PackagesDetailsVieModel {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar:widgetAppBar(size) ,
      body: offer != null
          ? Stack(
        children: [
          // Main content
          SizedBox(height: size.height),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Package details section
                    SizedBox(
                      height: 125,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Package name
                          Text(
                            HomeViewModel.lang == "ar"
                                ? offer!.nameAr!
                                : offer!.nameEn!,
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Duration and dates
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/calender.svg"),
                              const SizedBox(width: 10),
                              Text(
                                "${offer!.numOfDays} ${tr("Days")} ${offer!.num_of_nights} ${tr("Nights")}",
                                style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${offer!.startDate} - ${offer!.endDate}",
                                style: GoogleFonts.tajawal(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),

                          // Pricing information
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/money.svg"),
                              const SizedBox(width: 10),
                              Text(
                                "${offer!.priceAfter!} ${tr("Sar")}",
                                style: GoogleFonts.tajawal(
                                  color: const Color(0xff00A8A5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${offer!.priceBefore!} ${tr("Sar")}",
                                style: GoogleFonts.tajawal(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),

                          // Trip type information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/packplan.svg"),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${tr("TripType")} :",
                                    style: GoogleFonts.tajawal(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    offer!.type == "normal"
                                        ? tr("Normal")
                                        : tr("Weekend"),
                                    style: GoogleFonts.tajawal(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Divider(height: 10, thickness: 1, color: Colors.grey.shade300),

                    /// Package summary
                    _buildPackageSummary(),

                    Divider(height: 10, thickness: 1, color: Colors.grey.shade300),
                    const SizedBox(height: 10),

                    /// Package details section
                    Text(
                      tr("Details"),
                      style: GoogleFonts.tajawal(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Package description
                    _buildPackageDetails(),

                    const SizedBox(height: 170),
                  ],
                ),
              ),
            ),
          ),

          /// Loading indicator
          if (isLoading)
            SizedBox(
              height: size.height / 1.5,
              child: const Center(
                child: CircularProgressIndicator(color: samaOfficeColor),
              ),
            ),

          /// Bottom action button
          Positioned(
            bottom: -5,
            left: -5,
            right: -5,
            child: _buildBottomActionButton(context, size),
          ),
        ],
      )
          : SizedBox(
        height: size.height / 1.5,
        child: const Center(
          child: CircularProgressIndicator(color: samaOfficeColor),
        ),
      ),
    );
  }


  /// Widget of page
  AppBar widgetAppBar(Size size){
    return AppBar(
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Stack(
        children: [
          /// Display package images in a carousel if available
          offer != null
              ? CarouselSlider(
            items: offer!.images!
                .map(
                  (e) => GestureDetector(
                onTap: () {
                  // Open image viewer with multi-image support
                  MultiImageProvider multiImageProvider = MultiImageProvider(
                    offer!.images!
                        .map((e) => Image.network(e.image!).image)
                        .toList(),
                  );
                  showImageViewerPager(
                    context,
                    multiImageProvider,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                  );
                },
                child: Hero(
                  tag: 'imageHero',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(e.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
              height: 350.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              viewportFraction: 1,
            ),
          )
              : const SizedBox.shrink(),

          /// Display page indicator if images are available
          offer != null
              ? Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: offer!.images!.isEmpty? 1: offer!.images!.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: const Color(0xffea8024),
                ),
              ),
            ),
          )
              : const SizedBox.shrink(),

          // Back button
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
        ],
      ),
      toolbarHeight: 255,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }


  /// Widget to build the package summary section
  Widget _buildPackageSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        // height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryColumn(
              offer!.num_of_persons!.toString(),
              tr("TotalNumberOfPeople"),
            ),
            _buildVerticalDivider(),
            _buildSummaryColumn(
              offer!.num_of_reserved_persons.toString(),
              tr("numOfReservedPersons"),
            ),
            _buildVerticalDivider(),
            SizedBox(width: 78,
              child: _buildSummaryColumn(
                (offer!.num_of_persons! -
                    int.parse(offer!.num_of_reserved_persons.toString() ?? ""))
                    .toString(),
                tr("TheRemainingNumber"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget to build a summary column
  Widget _buildSummaryColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.tajawal(
            color: const Color(0xff00A8A5),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.tajawal(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Widget to build Package Details
  Widget _buildPackageDetails() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        containsHtmlTags(offer!.description!.toString())?
        Html(
          data: offer!.description!.toString() ?? '',
          style: {
            "body": Style(
              fontSize: FontSize(14.0),
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: GoogleFonts.tajawal().fontFamily,
            ),
          },
        )
            : Text(
          offer!.description!.toString(),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          textAlign: TextAlign.start,
        ),

        _buildDivider(),
        offer!.priceIncludeAr!=null?
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
             padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: samaOfficeColor),
            child: Text(
              tr("PriceInclude"),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              textAlign: TextAlign.start,
            ),
          ),

            containsHtmlTags(offer!.priceIncludeAr!)?
            Html(
              data: HomeViewModel.lang == "ar"
                  ? offer!.priceIncludeAr!
                  : offer!.priceExcludeEn!,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              },
            )
          :  Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  HomeViewModel.lang == "ar"
                    ? offer!.priceIncludeAr!
                     : offer!.priceExcludeEn!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),


            const SizedBox(height: 10,),
        ],)
            :const SizedBox.shrink(),


        offer!.priceExcludeAr!=null?
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.red),
              child: Text(
                tr("PriceNotInclude"),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10,),
            containsHtmlTags(offer!.priceExcludeAr!)?
            Html(
              data: HomeViewModel.lang == "ar"
                  ? offer!.priceExcludeAr!
                  : offer!.priceExcludeEn!,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              },
            )

                :

            Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  HomeViewModel.lang == "ar"
                      ? offer!.priceExcludeAr!
                      : offer!.priceExcludeEn!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),


            const SizedBox(height: 10,),
          ],)
            :const SizedBox.shrink(),


        offer!.whatAfterPayAr!=null?
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: const Color(0xff22AF0B)),
              child: Text(
                tr("WhatfterPayment"),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 10,),
            containsHtmlTags(offer!.whatAfterPayAr!)?
            Html(
              data: HomeViewModel.lang == "ar"
                  ? offer!.whatAfterPayAr!
                  : offer!.whatAfterPayEn!,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              },
            )

                :
            Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  HomeViewModel.lang == "ar"
                      ? offer!.whatAfterPayAr!
                      : offer!.whatAfterPayEn!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),


            const SizedBox(height: 10,),
          ],)
            :const SizedBox.shrink(),



        offer!.notesAr!=null?
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color:Colors.blue.shade200),
              child: Text(
                tr("notes"),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10,),

            containsHtmlTags(offer!.notesAr!)?
            Html(
              data: HomeViewModel.lang == "ar"
                  ? offer!.notesAr!
                  : offer!.notesEn!,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              },
            )

            :Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  HomeViewModel.lang == "ar"
                      ? offer!.notesAr!
                      : offer!.notesEn!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),


            const SizedBox(height: 10,),
          ],)
            :const SizedBox.shrink()


      ],
    );
  }

  /// Widget to build a vertical divider
  Widget _buildVerticalDivider() {
    return SizedBox(
      height: 50,
      child: VerticalDivider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }

  /// Widget to build a vertical divider
  Widget _buildDivider() {
    return  Column( children: [
      const SizedBox(height: 10),
      Divider(height: 10, thickness: 1, color: Colors.grey.shade300),
      const SizedBox(height: 10),

    ],);
  }

  /// Widget to build the bottom action button
  Widget _buildBottomActionButton(BuildContext context, Size size) {
    return Card(
      elevation: 20,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Container(
        height: 135,
        width: size.width,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Package condition and status
                Row(
                  children: [
                    Text(
                      tr("PackageCondition"),
                      style: GoogleFonts.tajawal(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      offer!.status == "active" ? tr("ActiveNow") : tr("ClosedNow"),
                      style: GoogleFonts.tajawal(
                        color: offer!.status == "active"
                            ? const Color(0xff7DC11F)
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Toggle switch for package status
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: const Color(0xff7DC11F),
                  width: 55,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: switchValue,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      switchValue = val;
                      changeOfferApi(
                          offer!.status == "active" ? "inactive" : "active");
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Edit package button
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(0),
                fixedSize: Size(size.width - 20, 50),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xff00A8A5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color(0xff00A8A5),
              ),
              onPressed: () {
                UpDateViewModel.offerModel = offer;
                SamaOfficeApp.navKey.currentState!.pushReplacement(
                  MaterialPageRoute(builder: (context) => const UpDateView()),
                );
              },
              child: Text(
                tr('EditThePackage'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
