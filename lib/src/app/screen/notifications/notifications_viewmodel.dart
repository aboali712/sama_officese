import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sama_officese/src/app.dart';

import '../../core/network/network_service.dart';
import '../home/packages_order/packages_order_details/packages_order_details_view.dart';
import '../home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'model/notification_model.dart';
import 'model/notification_response.dart';
import 'notification_view.dart';

abstract class NotificationsViewModel extends State<NotificationsView>{
  bool isLoading=false;
  final Dio dio = NetworkService.instance.dio;
 List<NotificationModel>?notificationModel;
  @override
  void initState() {
    getNotificationApi();
    super.initState();
  }


  Future<void> getNotificationApi() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("v1/office/notifications");
    var rs = NotificationResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        notificationModel = rs.data;
      });

    }
  }

  void goto(NotificationModel e){
    if(e.notificationType=="reservation"){
      setState(() {
        PackagesOrderDetailsViewModel.reservationId =e.reservationId.toString();
      });
      SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const PackagesOrderDetailsView(),));

    }

  }


}