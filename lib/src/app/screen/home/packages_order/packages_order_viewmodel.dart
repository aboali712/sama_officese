

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_view.dart';

import '../../../auth/auth_model/user_model.dart';
import '../../../core/network/network_service.dart';
import '../services/model/booking_servive_model.dart';
import '../services/model/service_response.dart';

abstract class PackagesOrderViewModel extends State<PackagesOrderView> with StorageHelper{
  final Dio dio = NetworkService.instance.dio;

  int packageStat=0;
bool isLoading=false;
  List<BookingsServiceModel> packages = [];
  List<BookingsServiceModel> packagePending = [];
  List<BookingsServiceModel> packageInReview = [];
  List<BookingsServiceModel> packageCompleted = [];

  static UserModel? userMdole;
  static String bookingId="";
  static String userId="";

  @override
  void initState() {
    getUser().then((value) => setState(() {
      userMdole=value;
    }));
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
        packageInReview=packages.where((element) => element.status!="pending" && element.status!="completed" && element.status!="canceled"  ).toList();
        packageCompleted=packages.where((element) => element.status=="canceled" || element.status=="completed").toList();
      });

      // log(packages.map((e) => e.toJson()).toString());
    }
  }


}