
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/chat_page/chat_view.dart';
import 'package:sama_officese/src/app/screen/chat_page/chat_view_model.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';

import '../../../../../app.dart';
import '../../../../core/values/colors.dart';
import '../../../../home_core.dart';
import '../../packages/packages_details/packages_details_view.dart';
import '../../packages/packages_details/packages_details_viewmodel.dart';
import 'add_service/add_service_view.dart';
import 'add_service/add_service_viewmodel.dart';

class PackagesOrderDetailsView extends StatefulWidget {
  const PackagesOrderDetailsView({Key? key}) : super(key: key);

  @override
  State<PackagesOrderDetailsView> createState() => _PackagesOrderDetailsViewState();
}

class _PackagesOrderDetailsViewState extends PackagesOrderDetailsViewModel {

  @override
  Widget build(BuildContext context) {
    // Get the size of the current screen for responsive layout
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if(PackagesOrderDetailsViewModel.pageNu==1){
          setState(() {
            HomeCorePage.index=0;
          });
          SamaOfficeApp.navKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => HomeCore(),));
          setState(() {
            PackagesOrderDetailsViewModel.pageNu=0;
          });
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFCFCFF), // Background color
        appBar: _buildAppBar(size), // Extracted AppBar into a method
        body:
        packageDetails!=null?
        Stack(
          children: [
            _buildContent(size), // Extracted the main content into a method
            if (isLoading)
              _buildLoadingIndicator(size), // Show loading indicator if loading
            _buildBottomBar(size), // Bottom bar for actions
          ],
        )
        :SizedBox(height: size.height/1.5,
            child: const Center(child: CircularProgressIndicator(color: samaColor,))),
      ),
    );
  }
  /// Method to build the AppBar widget
  AppBar _buildAppBar(Size size) {
    return
      AppBar(
      title: _buildAppBarTitle(), // Title widget for the AppBar
      flexibleSpace: packageDetails!=null?
      Stack(
        children: [
          Container(height: 30, color: const Color(0xff00A8A5)),
          Image.asset(
            'assets/images/packagedetails.png',
            fit: BoxFit.cover,
            width: size.width,
          ),
        ],
      ):const SizedBox.shrink(),
      toolbarHeight: 120, // Adjusted height for the AppBar
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }
/// Widget to build the title section of the AppBar
  Widget _buildAppBarTitle() {
    return
      packageDetails!=null?
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              InkWell(
                onTap: () {

                  if(PackagesOrderDetailsViewModel.pageNu==1){
                    setState(() {
                      HomeCorePage.index=0;
                    });
                  SamaOfficeApp.navKey.currentState!.pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeCore(),));
                  setState(() {
                    PackagesOrderDetailsViewModel.pageNu=0;
                  });
                  } else{
                  Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Text(
                "#${packageDetails!.id!}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateInfo(),
              _buildStatusChip(), // Status chip widget
            ],
          ),
        ],
      ),
    )
     :const SizedBox.shrink();
  }

/// Widget to display the creation date
  Widget _buildDateInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        SvgPicture.asset("assets/images/time.svg", color: Colors.white),
        const SizedBox(width: 5),
        Text(
          DateFormat("MMM d,yyyy", "en").format(DateTime.parse(packageDetails!.createdAt!)),
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

/// Widget to display the status chip
  Widget _buildStatusChip() {
    return Container(
      height: 25,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff5AC41A),
      ),
      child: Center(
        child: Text(
          _getStatusText(packageDetails!.status), // Get status text based on package status
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

/// Helper method to get the status text based on the package status
  String _getStatusText(String? status) {
    switch (status) {
      case "pending":
        return tr("Pending");
      case "inReview":
        return tr("Underway");
      case "canceled":
        return tr("Canceled");
      case "waiting_for_pay":
        return tr("waiting_for_pay");
      case "payment_confirmed":
        return tr("bookingConfirmed");
      case "completed":
        return tr("Complete");
      default:
        return tr("Underway");
    }
  }

/// Main content of the screen
  Widget _buildContent(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child:

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildUserCard(size), // Extracted user information into a method
                  const SizedBox(height: 10),
                  _buildBookingDetails(), // Booking details section
                  const SizedBox(height: 10),
                  if (_showAddServiceButton()) _buildAddServiceCard(size), // Add service button conditionally shown
                  if (_showInstallmentDetails()) _buildInstallmentCard(size), // Installment details if available
                  const SizedBox(height: 100),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  /// Widget to build the user information card
  Widget _buildUserCard(Size size) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserInfo(),
              if (packageDetails!.status != "canceled") _buildChatButton(),
            ],
          ),
        ),
      ),
    );
  }

/// Widget to display user image and name
  Widget _buildUserInfo() {
    return Row(
      children: [
        Container(
          height: 45,
          width: 50,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff8a8c8e),
            border: Border.all(width: 1.5, color: Colors.white),
            image: DecorationImage(
              image: NetworkImage(packageDetails!.user!.image.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${packageDetails!.user!.firstName.toString()} ${packageDetails!.user!.lastName.toString()}",
              style: GoogleFonts.tajawal(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

/// Widget to build the chat button
  Widget _buildChatButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(0),
        fixedSize: const Size(130, 35),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff00A8A5)),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color(0xff00A8A5),
      ),
      onPressed: startChatWithClient,
      child: Text(
        tr('TalkToTheClient'),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

/// Widget to build the booking details section
  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            tr("BookingDetails"),
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 3),
        _buildOfferDetails(),
      ],
    );
  }

/// Widget to display offer details
  Widget _buildOfferDetails() {
    return Column(
      children: [1].map((e) {
        return Column(
          children: [
            _buildOfferCard(),
            if (packageDetails!.status == "canceled") _buildCancellationReason(),
          ],
        );
      }).toList(),
    );
  }

/// Widget to build the offer information card
  Widget _buildOfferCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOfferInfo(),
            const SizedBox(height: 5),
            _buildOfferDates(),
             Divider(height: 5, thickness: 1, color: Colors.grey.shade300),
            _buildOfferPeriodInfo(),
             Divider(height: 5, thickness: 1, color: Colors.grey.shade300),
            _buildMoreInformation(),
          ],
        ),
      ),
    );
  }

/// Widget to display offer image and description
  Widget _buildOfferInfo() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(packageDetails!.offer!.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          _buildOfferDescription(),
        ],
      ),
    );
  }

/// Widget to display offer name, duration, and price
  Widget _buildOfferDescription() {
    return SizedBox(
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            HomeViewModel.lang == "ar"
                ? packageDetails!.offer!.nameAr!
                : packageDetails!.offer!.nameEn!,
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          _buildOfferDetailsRow(
            icon: SvgPicture.asset("assets/images/calender.svg"),
            text: "${packageDetails!.offer!.numOfDays} ${tr("Days")} - "
                "${packageDetails!.offer!.num_of_nights} ${tr("Nights")}",
          ),
          const SizedBox(height: 5),
          _buildOfferDetailsRow(
            icon: SvgPicture.asset("assets/images/money.svg"),
            text: "${packageDetails!.offer!.priceBefore!} ${tr("Sar")} - "
                "${packageDetails!.offer!.priceAfter!} ${tr("Sar")}",
          ),
        ],
      ),
    );
  }

/// Widget to display offer details row (icon and text)
  Widget _buildOfferDetailsRow({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

/// Widget to display offer start and end dates
  Widget _buildOfferDates() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateText(
            label: tr("Departure"),
            date: packageDetails!.startDate.toString(),
          ),
          const SizedBox(width: 10),
          _buildDateText(
            label: tr("Return"),
            date: packageDetails!.endDate.toString(),
          ),
        ],
      ),
    );
  }

/// Widget to display a date with a label (e.g., Departure, Return)
  Widget _buildDateText({required String label, required String date}) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          date,
          style: GoogleFonts.tajawal(
            color: const Color(0xff00A8A5),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

/// Widget to display offer period information (from and to dates, number of guests)
  Widget _buildOfferPeriodInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPeriodColumn(
            date: packageDetails!.offer!.startDate!,
            period: tr("PeriodFrom"),
          ),
          _buildVerticalDivider(),
          _buildPeriodColumn(
            date: packageDetails!.offer!.endDate!,
            period: tr("PeriodTo"),
          ),
          _buildVerticalDivider(),
          _buildGuestInfoColumn(),
        ],
      ),
    );
  }

  /// Widget to display a period column with date and period label
  Widget _buildPeriodColumn({required String date, required String period}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              DateFormat("MMMd", lang=="ar"?"ar": "en").format(DateTime.parse(date)),
              style: GoogleFonts.tajawal(
                color: const Color(0xff00A8A5),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              DateFormat("EEEE", lang=="ar"?"ar": "en").format(DateTime.parse(date)),
              style: GoogleFonts.tajawal(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          period,
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

/// Widget to build a vertical divider
  Widget _buildVerticalDivider() {
    return SizedBox(
      height: 60,
      child: VerticalDivider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }

/// Widget to display guest information
  Widget _buildGuestInfoColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "${packageDetails!.offer!.num_of_persons!.toString()} ${tr("Individuals")}",
              style: GoogleFonts.tajawal(
                color: const Color(0xff00A8A5),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${packageDetails!.adultsCount!} ${tr("AnIndividual")} - ${packageDetails!.childrenCount} ${tr("children")}",
              style: GoogleFonts.tajawal(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          tr("numberOfGuests"),
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

/// Widget to display the "More Information" link
  Widget _buildMoreInformation() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: _navigateToPackageDetails,
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
            const SizedBox(width: 20),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _navigateToPackageDetails() {
    setState(() {
      PackagesDetailsVieModel.offerId = packageDetails!.offer!.id.toString();
    });
    SamaOfficeApp.navKey.currentState!.push(
      MaterialPageRoute(builder: (context) => const PackagesDetails()),
    );
  }

  /// Method to check if the "Add Service" button should be shown
  Widget _buildCancellationReason() {
    return Row(
      children: [
        if (packageDetails!.cancellation_reasons != null)
          Text(
            "${tr("ReasonForCancellation")}: ",
            style: GoogleFonts.tajawal(
              color: const Color(0xff00A8A5),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        Text(
          packageDetails!.cancellation_reasons ?? "",
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  bool _showAddServiceButton() {
    return packageDetails!.status != "canceled" &&
        packageDetails!.status != "completed" &&
        packageDetails!.status != "payment_confirmed";
  }

/// Widget to build the "Add Service" card
  Widget _buildAddServiceCard(Size size) {
    return Card(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr("AddAService"),
              style: GoogleFonts.tajawal(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildAddServiceButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddServiceButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(0),
        fixedSize: const Size(80, 30),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff00A8A5)),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color(0xff00A8A5),
      ),
      onPressed: _navigateToAddService,
      child: const Icon(Icons.add, color: Colors.white, size: 25),
    );
  }

  void _navigateToAddService() {
    AddServiceViewModel.reservationId = packageDetails!.id;
    SamaOfficeApp.navKey.currentState!.push(
      MaterialPageRoute(builder: (context) => const AddServiceView()),
    );
  }

  bool _showInstallmentDetails() {
    return installmentModel != null && installmentModel!.isNotEmpty;
  }

/// Widget to build the installment details card
  Widget _buildInstallmentCard(Size size) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("InstallmentDetails"),
                style: GoogleFonts.tajawal(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _buildInstallmentButton(),
            ],
          ),
        ),
      ),
    );
  }

/// Widget to build the "Installment Payments" button
  Widget _buildInstallmentButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(0),
        fixedSize: const Size(130, 35),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff00A8A5)),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color(0xff00A8A5),
      ),
      onPressed: () {
        showBottomSheetInstallment(context);
      },
      child: Text(
        tr('Payments'),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

/// Widget to display a loading indicator if data is still loading
  Widget _buildLoadingIndicator(Size size) {
    return SizedBox(
      height: size.height,
      child: const Center(
        child: CircularProgressIndicator(color: samaOfficeColor),
      ),
    );
  }

/// Widget to build the bottom action bar with status change options
  Widget _buildBottomBar(Size size) {
    return Positioned(
      bottom: -5,
      left: -5,
      right: -5,
      child: Card(
        elevation: 20,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Container(
          height: 120,
          width: size.width,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: _buildBottomBarContent(),
        ),
      ),
    );
  }

/// Widget to build the content of the bottom action bar
  Widget _buildBottomBarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr("RequestStatusChanged"),
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        _buildStatusDropdown(),
      ],
    );
  }

/// Widget to build the status change dropdown
  Widget _buildStatusDropdown() {
    return InkWell(
      onTap: () {
        setState(() {
          changeState = packageDetails!.status!;
        });
        changeStatus();
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xffe2e9ef),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getStatusText(packageDetails!.status),
              style: GoogleFonts.tajawal(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xff8e8e93)),
          ],
        ),
      ),
    );
  }
}
