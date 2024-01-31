

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_view.dart';

import '../../../core/network/network_service.dart';
import '../services/model/booking_servive_model.dart';
import '../services/model/service_response.dart';

abstract class PackagesOrderViewModel extends State<PackagesOrderView>{
  final Dio dio = NetworkService.instance.dio;

  int packageStat=0;
bool isLoading=false;
  List<BookingsServiceModel> packages = [];
  List<BookingsServiceModel> packagePending = [];
  List<BookingsServiceModel> packageInReview = [];
  List<BookingsServiceModel> packageCompleted = [];



  @override
  void initState() {
    getReservationsApi();
    super.initState();
  }


  Future<void> getReservationsApi() async {
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


}