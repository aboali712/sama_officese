import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

import '../../core/network/network_service.dart';
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

      // log(notificationModel!.map((e) => e.toJson()).toString());
    }
  }

}