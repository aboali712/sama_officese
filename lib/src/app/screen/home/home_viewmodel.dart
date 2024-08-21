//
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:map_location_picker/map_location_picker.dart';
// import 'package:sama_officese/src/app.dart';
//
// import 'package:sama_officese/src/app/core/local/storagehelper.dart';
// import 'package:sama_officese/src/app/screen/home/packages/models/OffersResponse.dart';
// import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart';
// import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';
// import 'package:sama_officese/src/app/screen/home/services/model/booking_servive_model.dart';
// import 'package:sama_officese/src/app/screen/home/services/model/service_response.dart';
//
// import '../../auth/auth_model/auth_response.dart';
// import '../../auth/auth_model/user_model.dart';
// import '../../core/network/network_service.dart';
// import '../../core/utils/helper_manager.dart';
// import '../chat_page/chat_view.dart';
// import 'home_view.dart';
// import 'is_office_subscribe_expired/ofice_subscribe_expired_view.dart';
//
// abstract class HomeViewModel extends State<HomePage> with StorageHelper{
//   final Dio dio = NetworkService.instance.dio;
//
//  static UserModel? profileModel;
//   bool isLoading=false;
//  static String lang="";
//   List<BookingsServiceModel> services = [];
//   List<BookingsServiceModel> servicesPending = [];
//   List<BookingsServiceModel> servicesInReview = [];
//   List<BookingsServiceModel> servicesCompleted = [];
//   List<BookingsServiceModel> packages = [];
//   List<BookingsServiceModel> packagePending = [];
//   List<BookingsServiceModel> packageInReview = [];
//   List<BookingsServiceModel> packageCompleted = [];
//
//
//   List<OfferModel>? offerPageModel=[];
//   static int? difference;
//   static bool? nullValue;
//   DateTime date =DateTime.now();
//   DateTime? valEnd;
//   static bool? valDate;
//   static int pageVipExpired=0;
//   DateTime? minus5Days;
//   static  bool? valDateMinus5Days;
// UserModel? userModel ;
//
//   @override
//   void initState() {
//     getCurrentLocation();
//     getUserData();
//     getLang().then((value) => setState((){lang=value!; }));
//     getUser().then((value) => setState(() {
//       userModel=value;
//     }));
//     getReservationsApi();
//     getPackageOrderApi();
//     getOffersDataApi();
//     getNotifications();
//     super.initState();
//   }
//
//   getNotifications(){
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle notification when the app is opened from the terminated state
//       print("onMessageOpenedApp: ${message.data["firebase"]}");
//       if(message.data["firebase"]!=null) {
//         var dt=json.decode(message.data["firebase"]);
//         if(dt["notification_type"].toString()=="message") {
//           PackagesOrderViewModel.userMdole!=userModel;
//           PackagesOrderViewModel.userId=dt["userId"]!;
//           PackagesOrderViewModel.bookingId=dt["bookingId"]!;
//           Navigator.of(context)
//               .push(MaterialPageRoute(
//             builder: (context) => const ChatView(),
//           ));
//         }
//
//       }
//
//     });
//   }
//
//
//
//
//   Future<void> getUserData() async {
//     setState(() {
//       isLoading=true;
//     });
//     final response = await dio.get("/v1/office/profile");
//     var rs = AuthResponse(response.data!);
//     setState(() {
//       isLoading=false;
//     });
//     if (rs.status == 200) {
//       setState(() {
//         profileModel = rs.data;
//
//       });
//       log("${profileModel!.id} 333333333333333333333333333333333333333333");
//
//     }
//
//   }
//   static LocationPermission? permission;
//   static Position? currentPosition;
//
//   Future<void> getCurrentLocation() async {
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       toastApp("Location permission are denied", context);
//
//       if (permission == LocationPermission.deniedForever) {
//         toastApp("Location permission are permanetly denied", context);
//       }
//     }
//     Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         forceAndroidLocationManager: true)
//         .then((Position position) {
//       setState(() {
//         currentPosition = position;
//         print("${currentPosition!.latitude} 5555555555555555555");
//         print("${currentPosition!.longitude} 5555555555555555555");
//
//       });
//     }).catchError((e) {
//       toastApp(e.toString(), context);
//     });
//   }
//
//
//   GeocodingResult? result;
//   void showPlacePicker() async {
//
//
//    Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => GoogleMapLocationPicker
//           (
//           language: HomeViewModel.lang,
//            currentLatLng: LatLng(currentPosition!.latitude,currentPosition!.longitude) ,
//           apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc",
//           onNext: (GeocodingResult? resu) {
//             setState(() {
//               result=resu;
//               print(result!.formattedAddress!);
//               print(result!.geometry.location.lat);
//               print(result!.geometry.location.lng);
//
//               Navigator.pop(context);
//             });
//           },
//         )));
//     // setState(() {
//     //   result=re;
//     //   print(result);
//     // });
//
//   }
//
//   Future<void> getReservationsApi() async {
//     Map<String, String> mp = {};
//     setState(() {
//       isLoading=true;
//     });
//
//     mp["type"] = "service";
//     final response =
//     await dio.get("v1/office/getReservations", queryParameters: mp);
//     setState(() {
//       isLoading=false;
//     });
//     var rs = BookingServicesResponse(response.data!);
//     if (rs.status == 200) {
//       setState(() {
//         services = rs.data!;
//         servicesPending=services.where((element) => element.status=="pending").toList();
//         servicesInReview=services.where((element) => element.status=="inReview"||element.status=="processing" ).toList();
//         servicesCompleted=services.where((element) => element.status=="canceled" || element.status=="completed").toList();
//
//       });
//     }
//   }
//
//
//   Future<void> getPackageOrderApi() async {
//     Map<String, String> mp = {};
//     setState(() {
//       isLoading=true;
//     });
//
//     mp["type"] = "offer";
//     final response =
//     await dio.get("v1/office/getReservations", queryParameters: mp);
//     setState(() {
//       isLoading=false;
//     });
//     var rs = BookingServicesResponse(response.data!);
//     if (rs.status == 200) {
//       setState(() {
//         packages = rs.data!;
//         packagePending=packages.where((element) => element.status=="pending").toList();
//         packageInReview=packages.where((element) => element.status=="inReview"||element.status=="processing" ).toList();
//         packageCompleted=packages.where((element) => element.status=="canceled" || element.status=="completed").toList();
//       });
//
//       // log(packages.map((e) => e.toJson()).toString());
//     }
//   }
//
//
//
//   Future<void> getOffersDataApi() async {
//     setState(() {
//       isLoading=true;
//     });
//     final response = await dio.get("v1/office/offers");
//
//     var rs = OffersResponse(response.data!);
//     setState(() {
//       isLoading=false;
//     });
//     if (rs.status == 200) {
//       setState(() {
//         offerPageModel = rs.data;
//       });
//     }
//   }
//
//
// }



// Import necessary Dart and Flutter packages
import 'dart:convert'; // For encoding and decoding JSON
import 'dart:developer'; // For logging purposes

import 'package:dio/dio.dart'; // HTTP client for making API requests
import 'package:firebase_messaging/firebase_messaging.dart'; // Firebase messaging for push notifications
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For getting the current location
import 'package:map_location_picker/map_location_picker.dart'; // For Google Map location picker
import 'package:sama_officese/src/app.dart'; // Main app navigation

// Import project-specific utilities and models
import 'package:sama_officese/src/app/core/local/storagehelper.dart'; // For local storage helper
import 'package:sama_officese/src/app/screen/home/packages/models/OffersResponse.dart'; // Offer response model
import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart'; // Offer model
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart'; // Package order view model
import 'package:sama_officese/src/app/screen/home/services/model/booking_servive_model.dart'; // Booking service model
import 'package:sama_officese/src/app/screen/home/services/model/service_response.dart'; // Service response model

import '../../auth/auth_model/auth_response.dart'; // Authentication response model
import '../../auth/auth_model/user_model.dart'; // User model
import '../../core/network/network_service.dart'; // Network service
import '../../core/utils/helper_manager.dart'; // Helper manager
import '../chat_page/chat_view.dart'; // Chat view
import 'home_view.dart'; // Home view
import 'is_office_subscribe_expired/ofice_subscribe_expired_view.dart'; // Office subscription expired view

// HomeViewModel class handles the main logic for the HomePage
abstract class HomeViewModel extends State<HomePage> with StorageHelper {
  final Dio dio = NetworkService.instance.dio; // Initialize Dio for API requests

  static UserModel? profileModel; // Static variable to store the user profile model
  bool isLoading = false; // Loading state
  static String lang = ""; // Language preference
  // List<BookingsServiceModel> services = []; // List to store services
  // List<BookingsServiceModel> servicesPending = []; // List to store pending services
  // List<BookingsServiceModel> servicesInReview = []; // List to store services in review
  // List<BookingsServiceModel> servicesCompleted = []; // List to store completed services
  List<BookingsServiceModel> packages = []; // List to store packages
  List<BookingsServiceModel> packagePending = []; // List to store pending packages
  List<BookingsServiceModel> packageInReview = []; // List to store packages in review
  List<BookingsServiceModel> packageCompleted = []; // List to store completed packages

  List<OfferModel>? offerPageModel = []; // List to store offer models
  static int? difference; // To calculate the difference in days
  static bool? nullValue; // Flag for null value checks
  DateTime date = DateTime.now(); // Current date
  DateTime? valEnd; // Subscription end date
  static bool? valDate; // Flag to check if current date is before end date
  static int pageVipExpired = 0; // VIP expired page flag
  DateTime? minus5Days; // Date 5 days before the end date
  static bool? valDateMinus5Days; // Flag to check if current date is before minus 5 days
  UserModel? userModel; // User model instance

  String pendingPackageNumber ="";
  @override
  void initState() {
    // Initialize data and check for notifications
    getCurrentLocation(); // Get the current location of the user
    getUserData(); // Get user data
    getLang().then((value) => setState(() {
      lang = value!; // Set language preference
    }));
    getUser().then((value) => setState(() {
      userModel = value; // Set user model
    }));
    // getReservationsApi(); // Fetch reservations
    getPackageOrderApi(); // Fetch package orders
    getOffersDataApi(); // Fetch offers data
    // getNotifications(); // Set up notification listener
    super.initState();
  }

  // Method to handle incoming notifications
  // void getNotifications() {
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     // Handle notification when the app is opened from a terminated state
  //     print("onMessageOpenedApp: ${message.data["firebase"]}");
  //     if (message.data["firebase"] != null) {
  //       var dt = json.decode(message.data["firebase"]);
  //       if (dt["notification_type"].toString() == "message") {
  //         PackagesOrderViewModel.userMdole != userModel;
  //         PackagesOrderViewModel.userId = dt["userId"]!;
  //         PackagesOrderViewModel.bookingId = dt["bookingId"]!;
  //         Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => const ChatView(),
  //         ));
  //       }
  //     }
  //   });
  // }

  // Fetch the user data from the server
  Future<void> getUserData() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    final response = await dio.get("/v1/office/profile"); // Get user profile
    var rs = AuthResponse(response.data!);
    setState(() {
      isLoading = false; // Hide loading indicator
    });
    if (rs.status == 200) {
      setState(() {
        profileModel = rs.data; // Update profile model
      });
      log("${profileModel!.id} 333333333333333333333333333333333333333333");
    }
  }

  static LocationPermission? permission; // Location permission status
  static Position? currentPosition; // User's current position

  // Get the user's current location
  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission(); // Check for location permission
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); // Request location permission
      toastApp("Location permission are denied", context);

      if (permission == LocationPermission.deniedForever) {
        toastApp("Location permission are permanently denied", context);
      }
    }
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position; // Update current position
        print("${currentPosition!.latitude} 5555555555555555555");
        print("${currentPosition!.longitude} 5555555555555555555");
      });
    }).catchError((e) {
      toastApp(e.toString(), context); // Handle location error
    });
  }

  GeocodingResult? result; // Store the result of geocoding

  // Show the Google Map location picker
  void showPlacePicker() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GoogleMapLocationPicker(
          language: HomeViewModel.lang, // Use the current language
          currentLatLng: LatLng(currentPosition!.latitude,
              currentPosition!.longitude), // Use the current position
          apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc", // Google API key
          onNext: (GeocodingResult? resu) {
            setState(() {
              result = resu; // Update result with selected location
              print(result!.formattedAddress!);
              print(result!.geometry.location.lat);
              print(result!.geometry.location.lng);

              Navigator.pop(context); // Close the picker
            });
          },
        )));
  }

  // Fetch reservations data from the API
  // Future<void> getReservationsApi() async {
  //   Map<String, String> mp = {};
  //   setState(() {
  //     isLoading = true; // Show loading indicator
  //   });
  //
  //   mp["type"] = "service"; // Request services data
  //   final response = await dio.get("v1/office/getReservations", queryParameters: mp);
  //   setState(() {
  //     isLoading = false; // Hide loading indicator
  //   });
  //   var rs = BookingServicesResponse(response.data!);
  //   if (rs.status == 200) {
  //     setState(() {
  //       services = rs.data!; // Update services list
  //       servicesPending = services.where((element) => element.status == "pending").toList();
  //       servicesInReview = services.where((element) => element.status == "inReview" || element.status == "processing").toList();
  //       servicesCompleted = services.where((element) => element.status == "canceled" || element.status == "completed").toList();
  //     });
  //   }
  // }

  // Fetch package orders data from the API
  Future<void> getPackageOrderApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading = true; // Show loading indicator
    });

    mp["type"] = "offer"; // Request offers data
    final response = await dio.get("v1/office/getReservations", queryParameters: mp);
    setState(() {
      isLoading = false; // Hide loading indicator
    });
    var rs = BookingServicesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        packages = rs.data!; // Update packages list
        packagePending = packages.where((element) => element.status == "pending").toList();
        packageInReview = packages.where((element) => element.status == "inReview" || element.status == "processing").toList();
        packageCompleted = packages.where((element) => element.status == "canceled" || element.status == "completed").toList();
        pendingPackageNumber=packagePending.length.toString();
      });
      print("${pendingPackageNumber.toString()} 888888888888888888888888888888");
    }
  }

  // Fetch offers data from the API
  Future<void> getOffersDataApi() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    final response = await dio.get("v1/office/offers");
    var rs = OffersResponse(response.data!);
    setState(() {
      isLoading = false; // Hide loading indicator
    });
    if (rs.status == 200) {
      setState(() {
        offerPageModel = rs.data; // Update offer models list
      });
    }
  }
}
