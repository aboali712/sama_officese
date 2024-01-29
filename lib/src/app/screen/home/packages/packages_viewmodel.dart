import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_view.dart';

import '../../../core/network/network_service.dart';
import 'models/OffersResponse.dart';
import 'models/offer_model.dart';

abstract class PackagesViewModel extends State<PackagesView>{
  final Dio dio = NetworkService.instance.dio;
 bool isLoading=false;
  List<OfferModel>? offerPageModel=[];
  @override
  void initState() {
    getOffersDataApi();
    super.initState();
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