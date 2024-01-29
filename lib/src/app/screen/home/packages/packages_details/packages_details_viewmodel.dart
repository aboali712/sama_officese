import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../models/offer_model.dart';
import 'model/PackagerDetailsResponse.dart';
import 'model/package_details_model.dart';

abstract class PackagesDetailsVieModel extends State<PackagesDetails>{

  final Dio dio = NetworkService.instance.dio;
  PackageDetailsModel? offerDetailsModel;


  bool isLoading=false;
  int activeIndex =0;
  bool switchValue= true;
 OfferModel? offer;
static String offerId ="";
 @override
  void initState() {
   getOfferDetailsApi();
    super.initState();
  }



  Future<void> changeOfferApi(String status) async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> mp = {};
    mp["offer_id"] = offerId;
    mp["status"] = status;

    final response = await dio.post("v1/office/change-offer-status", data: mp);

    var rs = EmptyResponse(response.data!);
    setState(() {
      isLoading = false;
    });
    if (rs.status == 200) {
      getOfferDetailsApi();
      toastAppSuccess(rs.msg!, context);
    }else{
      toastApp(rs.msg!, context);
    }
  }




  Future<void> getOfferDetailsApi() async {
   setState(() {
     isLoading=true;
   });
    Map<String, String> mp = {};

    mp["offer_id"] = offerId;


    final response = await dio.get("v1/office/offerDetails", queryParameters: mp);
   setState(() {
     isLoading=false;
   });
    var rs = OffersDetailsResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        offer = rs.data!.offerDetails;
        switchValue= offer!.status=="active" ? true: false ;

      });
    }

  }



}