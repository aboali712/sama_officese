

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_viewModel.dart';

import '../../../core/values/colors.dart';
import '../home_viewmodel.dart';

class PackagesView extends StatefulWidget {
  const PackagesView({Key? key}) : super(key: key);

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends PackagesViewModel {
  @override
  Widget build(BuildContext context) {
    /// Get the screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar: widgetAppBar(size),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  /// Display packages if available
                  offerPageModel?.isNotEmpty ?? false
                      ? Column(
                    children: offerPageModel!.map((e) {
                      return Column(
                        children: [
                          Card(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        // Package image
                                        Container(
                                          height: 90,
                                          width: 115,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(e.image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Package details
                                        SizedBox(
                                          height: 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  HomeViewModel.lang == "ar"
                                                      ? e.nameAr!
                                                      : e.nameEn!,
                                                  style: GoogleFonts.tajawal(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              // Number of days and nights
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/images/calender.svg"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${e.numOfDays} ${tr("Days")} ${e.num_of_nights} ${tr("Nights")}",
                                                    style: GoogleFonts.tajawal(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Package price before and after discount
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/images/money.svg"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${e.priceAfter!} ${tr("Sar")}",
                                                    style: GoogleFonts.tajawal(
                                                      color: const Color(0xff00A8A5),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${e.priceBefore!} ${tr("Sar")}",
                                                    style: GoogleFonts.tajawal(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Divider line
                                  Divider(
                                    height: 10,
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  // More information and status
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Status indicator
                                        Text(
                                          e.status == "active"
                                              ? tr("ActiveNow")
                                              : tr("ClosedNow"),
                                          style: GoogleFonts.tajawal(
                                            color: e.status == "active"
                                                ? const Color(0xff7DC11F)
                                                : Colors.red,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // More information button
                                        InkWell(
                                          onTap: () {
                                            PackagesDetailsVieModel.offerId = e.id.toString();
                                            SamaOfficeApp.navKey.currentState!.push(
                                              MaterialPageRoute(
                                                builder: (context) => const PackagesDetails(),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                tr("moreInformation"),
                                                style: GoogleFonts.tajawal(
                                                  color: Colors.blue,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
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
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  )
                      : _buildEmptyPackagesPlaceholder(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Loading indicator
          if (isLoading)
            SizedBox(
              height: size.height,
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

/// widget AppBar of Page
  AppBar widgetAppBar(Size  size){
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Back button
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                // AppBar Title
                Text(
                  tr("Packages"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      flexibleSpace: Stack(
        children: [
          Container(height: 30, color: const Color(0xffea8024)),
          Image.asset(
            'assets/images/packages.png',
            fit: BoxFit.cover,
            width: size.width,
          ),
        ],
      ),
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }

  // Widget to display when there are no packages
  Widget _buildEmptyPackagesPlaceholder(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 5,
      ),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/empty_orders.svg"),
          const SizedBox(height: 20),
          Text(
            tr("NoPackages"),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tr("NoPackagesDes"),
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
