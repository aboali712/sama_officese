
import 'package:dio/dio.dart'; // HTTP client for making API requests
import 'package:flutter/cupertino.dart'; // Cupertino widgets for iOS styling
import 'package:flutter/material.dart'; // Material widgets for Android styling
import 'package:sama_officese/src/app/core/local/storagehelper.dart'; // Local storage helper
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_view.dart'; // Packages order view

import '../../../auth/auth_model/user_model.dart'; // User model for authentication
import '../../../core/network/network_service.dart'; // Network service for API calls
import '../services/model/booking_servive_model.dart'; // Booking service model
import '../services/model/service_response.dart'; // Service response model

// Abstract class for handling the logic and state of the PackagesOrderView
abstract class PackagesOrderViewModel extends State<PackagesOrderView> with StorageHelper {
  final Dio dio = NetworkService.instance.dio; // Initialize Dio for API requests

  int packageStat = 0; // Variable to track the current package status tab
  bool isLoading = false; // Loading state indicator

  // Lists to store packages based on their status
  List<BookingsServiceModel> packages = [];
  List<BookingsServiceModel> packagePending = [];
  List<BookingsServiceModel> packageInReview = [];
  List<BookingsServiceModel> packageCompleted = [];

   static UserModel? userMdole; // Static variable to hold the current user model
  int? set = 0; // Variable to control the set state

  @override
  void initState() {
    super.initState();

    // Retrieve the user data and then update the state with the retrieved user model
    getUser().then((value) {
      setState(() {
        userMdole = value;
        print("${userMdole!.id} 333333333333333333333333333333333333333");
      });
    });

    // Fetch the reservations data from the API
    getReservationsApi();
  }

  // Method to fetch reservations data from the API
  Future<void> getReservationsApi() async {
    Map<String, String> mp = {}; // Map to hold query parameters for the API call

    // Show or hide loading indicator based on the 'set' variable
    setState(() {
      isLoading = set == 1 ? false : true;
    });

    mp["type"] = "offer"; // Set the query parameter for type as "offer"

    // Make an API request to fetch the reservations data
    final response = await dio.get("v1/office/getReservations", queryParameters: mp);

    // Hide the loading indicator after receiving the response
    setState(() {
      isLoading = false;
    });

    // Parse the response data
    var rs = BookingServicesResponse(response.data!);

    // If the API call is successful, categorize the packages based on their status
    if (rs.status == 200) {
      setState(() {
        packages = rs.data!; // Store the fetched packages

        // Categorize packages into different lists based on their status
        packagePending = packages.where((element) => element.status == "pending").toList();
        packageInReview = packages.where((element) =>
        element.status != "pending" &&
            element.status != "completed" &&
            element.status != "canceled"
        ).toList();
        packageCompleted = packages.where((element) =>
        element.status == "canceled" || element.status == "completed"
        ).toList();
      });

      // Log the packages for debugging purposes (optional)
      // log(packages.map((e) => e.toJson()).toString());
    }
  }
}
