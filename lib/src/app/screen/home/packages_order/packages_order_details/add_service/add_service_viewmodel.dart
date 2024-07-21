import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/core/utils/helper_manager.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/add_service/model/services_response.dart';

import '../../../../../auth/auth_model/empty_response.dart';
import '../../../../../core/network/network_service.dart';
import 'add_service_view.dart';
import 'model/services_model.dart';

abstract class AddServiceViewModel extends State<AddServiceView>{
  final Dio dio = NetworkService.instance.dio;
  bool isLoading =false;
  TextEditingController serviceNameControl=TextEditingController();
  TextEditingController servicePriceControl=TextEditingController();
  static int? reservationId;
  List<ServicesModel>?servicesModel;
  String? serviceId="";

@override
  void initState() {
  getServiceApi();
    super.initState();
  }

  bool checkValid(){
    if(serviceNameControl.text==""){
      toastApp(tr("ServiceName"), context);
      return false;
    }

    if(servicePriceControl.text==""){
      toastApp(tr("ServicePrice"), context);
      return false;
    }
    return true;
  }

  Future<void> createServiceApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });
    mp["reservation_id"]= AddServiceViewModel.reservationId.toString();
    mp["title"]= serviceNameControl.text.toString();
    mp["cost"]= servicePriceControl.text.toString();
    final response =
    await dio.post("v1/office/extraServices/create", data: mp);
    var rs = EmptyResponse(response.data!);

    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      toastAppSuccess(rs.msg!, context);
      Navigator.pop(context);

    }else{
      toastApp(rs.msg!, context);

    }
  }

  Future<void> getServiceApi() async {
    setState(() {
      isLoading=true;
    });
    Map<String, String> mp = {};
    mp["reservation_id"]= AddServiceViewModel.reservationId.toString();
    final response =
    await dio.get("v1/office/getReservationServices", queryParameters: mp);
    var rs = ServicesResponse(response.data!);

    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
    setState(() {
      servicesModel=rs.data;
    });
    }else{
      toastApp(rs.msg!, context);

    }
  }

  Future<void> deleteServiceApi() async {
    setState(() {
      isLoading=true;
    });
    Map<String, String> mp = {};
    mp["service_id"]= serviceId.toString();
    final response =
    await dio.post("v1/office/extraServices/delete", data: mp);
    var rs = EmptyResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
    toastAppSuccess(rs.msg.toString(), context);
    getServiceApi();
    }else{
      toastApp(rs.msg!, context);

    }
  }

}