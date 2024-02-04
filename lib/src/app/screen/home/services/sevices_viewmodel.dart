
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/services/sevices_view.dart';

import '../../../core/network/network_service.dart';
import 'model/booking_servive_model.dart';
import 'model/service_response.dart';

abstract class ServicesViewModel extends State<ServiceView>{
  final Dio dio = NetworkService.instance.dio;

  int serviceStat=0;
  bool isLoading=false;
  List<BookingsServiceModel> services = [];
  List<BookingsServiceModel> servicesPending = [];
  List<BookingsServiceModel> servicesInReview = [];
  List<BookingsServiceModel> servicesCompleted = [];


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



}