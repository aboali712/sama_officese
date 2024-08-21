
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/reports/reports_viewmodel.dart';

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
      appBar: _buildAppBar(size), // Builds the custom AppBar
      body: Stack(
        children: [
          if (reportModel != null) _buildReportCards(size), // Builds report cards if data is available
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
            tr("Reports"),
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

  /// Builds the report cards
  Widget _buildReportCards(Size size) {
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
                  _buildReportCardRow(size, [
                    _buildReportCard(
                      size,
                      color: const Color(0xffCAD7E5),
                      iconColor: const Color(0xff00417e),
                      iconAsset: "assets/images/plan.svg",
                      count: reportModel!.offersCount.toString(),
                      label: tr("NumberOfOffers"),
                    ),
                    _buildReportCard(
                      size,
                      color: const Color(0xffCAEBED),
                      iconColor: const Color(0xff00a8a5),
                      iconAsset: "assets/images/planee.svg",
                      count: reportModel!.pendingReservationsCount.toString(),
                      label: tr("pendingReservations"),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  _buildReportCardRow(size, [
                    _buildReportCard(
                      size,
                      color: const Color(0xffF8E3D3),
                      iconColor: const Color(0xffea8024),
                      iconAsset: "assets/images/plancc.svg",
                      count: reportModel!.completedReservationsCount.toString(),
                      label: tr("completedReservations"),
                    ),
                    _buildReportCard(
                      size,
                      color: const Color(0xffE5E6E8),
                      iconColor: Colors.grey,
                      iconAsset: "assets/images/plan.svg",
                      count: reportModel!.totalReservations.toString(),
                      label: tr("TotalReservations"),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  _buildReportCard(
                    size,
                    color: const Color(0xffCAEBED),
                    iconColor: const Color(0xff00a8a5),
                    iconAsset: "assets/images/planee.svg",
                    count: reportModel!.totalSales.toString(),
                    label: tr("TotalSales"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a row of report cards
  Widget _buildReportCardRow(Size size, List<Widget> cards) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cards,
    );
  }

  /// Builds a single report card with specified parameters
  Widget _buildReportCard(
      Size size, {
        required Color color,
        required Color iconColor,
        required String iconAsset,
        required String count,
        required String label,
      }) {
    return Container(
      height: 165,
      width: size.width / 2.2,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(iconColor, iconAsset, count),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the header of the report card with an icon and count
  Widget _buildCardHeader(Color iconColor, String iconAsset, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 53,
          width: 58,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: iconColor,
          ),
          child: SvgPicture.asset(iconAsset),
        ),
        Container(
          height: 27,
          width: 27,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xff5AC41A),
          ),
          child: Center(
            child: Text(
              count,
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
