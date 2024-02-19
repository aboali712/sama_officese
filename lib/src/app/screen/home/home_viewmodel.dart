
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:sama_officese/src/app.dart';

import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/screen/home/packages/models/OffersResponse.dart';
import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart';
import 'package:sama_officese/src/app/screen/home/services/model/booking_servive_model.dart';
import 'package:sama_officese/src/app/screen/home/services/model/service_response.dart';

import '../../auth/auth_model/auth_response.dart';
import '../../auth/auth_model/user_model.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import 'home_view.dart';
import 'is_office_subscribe_expired/ofice_subscribe_expired_view.dart';

abstract class HomeViewModel extends State<HomePage> with StorageHelper{
  final Dio dio = NetworkService.instance.dio;

 static UserModel? profileModel;
  bool isLoading=false;
 static String lang="";
  List<BookingsServiceModel> services = [];
  List<BookingsServiceModel> servicesPending = [];
  List<BookingsServiceModel> servicesInReview = [];
  List<BookingsServiceModel> servicesCompleted = [];
  List<BookingsServiceModel> packages = [];
  List<BookingsServiceModel> packagePending = [];
  List<BookingsServiceModel> packageInReview = [];
  List<BookingsServiceModel> packageCompleted = [];


  List<OfferModel>? offerPageModel=[];
  static int? difference;
  static bool? nullValue;
  DateTime date =DateTime.now();
  DateTime? valEnd;
  static bool? valDate;
  static int pageVipExpired=0;
  DateTime? minus5Days;
  static  bool? valDateMinus5Days;


  @override
  void initState() {
    getCurrentLocation();
    getUserData().then((value) => { sub()});
    getLang().then((value) => setState((){lang=value!; }));
    getReservationsApi();
    getPackageOrderApi();
    getOffersDataApi();
    super.initState();
  }



  void sub(){

    if(profileModel!.office!.subscriptionEndDate==null){
      setState((){
        nullValue=true;
      });

      SamaOfficeApp.navKey.currentState!.pushReplacement(MaterialPageRoute(builder:
          (context) => const OfficeSubscribeView(),));

    }else{

      valEnd = DateTime.parse(profileModel!.office!.subscriptionEndDate.toString()) ;
      print(profileModel!.office!.subscriptionEndDate.toString());
      minus5Days = valEnd!.subtract(const Duration(days: 5));
      setState(() {
        difference = valEnd!.difference(date).inDays ;
        print(difference);
      });
      valDate = date.isBefore(valEnd!);
      valDateMinus5Days = date.isBefore(minus5Days!);
      print(valDateMinus5Days);


      if(valDateMinus5Days==false ){

        if(pageVipExpired==0){
          valDate==false?
          SamaOfficeApp.navKey.currentState!.pushReplacement(MaterialPageRoute(
            builder: (context) => const OfficeSubscribeView(),))

              :SamaOfficeApp.navKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const OfficeSubscribeView(),));

          setState((){
            HomeViewModel.pageVipExpired=1;

          });
        }


      }
    }
  }


  Future<void> getUserData() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("/v1/office/profile");
    var rs = AuthResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        profileModel = rs.data;

      });
      log("${profileModel!.office!.toJson().toString()} 333333333333333333333333333333333333333333");

    }

  }
  static LocationPermission? permission;
  static Position? currentPosition;

  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      toastApp("Location permission are denied", context);

      if (permission == LocationPermission.deniedForever) {
        toastApp("Location permission are permanetly denied", context);
      }
    }
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        // print("${currentPosition!.latitude} 5555555555555555555");
        // print("${currentPosition!.longitude} 5555555555555555555");

      });
    }).catchError((e) {
      toastApp(e.toString(), context);
    });
  }


  GeocodingResult? result;
  void showPlacePicker() async {

   Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapLocationPicker
          (
          language: HomeViewModel.lang,
           currentLatLng: LatLng(currentPosition!.latitude,currentPosition!.longitude) ,
          apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc",
          onNext: (GeocodingResult? resu) {
            setState(() {
              result=resu;
              print(result!.formattedAddress!);
              print(result!.geometry.location.lat);
              print(result!.geometry.location.lng);

              Navigator.pop(context);
            });
          },
        )));
    // setState(() {
    //   result=re;
    //   print(result);
    // });

  }

  Future<void> getReservationsApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });

    mp["type"] = "service";
    final response =
    await dio.get("v1/office/getReservations", queryParameters: mp);
    setState(() {
      isLoading=false;
    });
    var rs = BookingServicesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        services = rs.data!;
        servicesPending=services.where((element) => element.status=="pending").toList();
        servicesInReview=services.where((element) => element.status=="inReview"||element.status=="processing" ).toList();
        servicesCompleted=services.where((element) => element.status=="canceled" || element.status=="completed").toList();

      });
    }
  }


  Future<void> getPackageOrderApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });

    mp["type"] = "offer";
    final response =
    await dio.get("v1/office/getReservations", queryParameters: mp);
    setState(() {
      isLoading=false;
    });
    var rs = BookingServicesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        packages = rs.data!;
        packagePending=packages.where((element) => element.status=="pending").toList();
        packageInReview=packages.where((element) => element.status=="inReview"||element.status=="processing" ).toList();
        packageCompleted=packages.where((element) => element.status=="canceled" || element.status=="completed").toList();
      });

      // log(packages.map((e) => e.toJson()).toString());
    }
  }



  Future<void> getOffersDataApi() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("v1/office/offers");

    var rs = OffersResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        offerPageModel = rs.data;
      });
    }
  }


}