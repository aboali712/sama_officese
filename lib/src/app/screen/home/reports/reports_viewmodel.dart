import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/reports/reports_view.dart';

import '../../../core/network/network_service.dart';
import 'model/report_rsponse.dart';
import 'model/reports_model.dart';

abstract class ReportsViewModel extends State<ReportsView>{
bool isLoading =false;
final Dio dio = NetworkService.instance.dio;
ReportModel ?reportModel;

@override
  void initState() {
  getReportDataApi();
    super.initState();
  }



Future<void> getReportDataApi() async {
  setState(() {
    isLoading=true;
  });
  final response = await dio.get("v1/office/statistics");

  var rs = ReportResponse(response.data!);
  setState(() {
    isLoading=false;
  });
  if (rs.status == 200) {
    setState(() {
      reportModel = rs.data;
    });
  }
}

}