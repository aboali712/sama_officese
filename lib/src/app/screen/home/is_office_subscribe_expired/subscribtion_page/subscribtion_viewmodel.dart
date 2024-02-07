import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/is_office_subscribe_expired/subscribtion_page/subscribtion_view_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../auth/register/all_filter/filter_model.dart';
import '../../../../auth/register/all_filter/filter_response.dart';
import '../../../../auth/register/all_filter/paln_model.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../payment/model/payment_response.dart';
import '../../payment/payment_view.dart';


abstract class SubscriptionViewModelPage extends State<SubscriptionPage>{
  final Dio dio = NetworkService.instance.dio;

  FilterModel? filterModel;
  String? selectedSubscriptionPlan;
  List<PlansModel>? plansModel;

  String typeSelect="";
  String typeSelectId="";
  bool isLoading=false;

  @override
  void initState() {
    getFilterDataApi();
    super.initState();
  }



  Future<void> getFilterDataApi() async {
    Map<String, String> mp = {};

    final response = await dio.get("v1/filter", queryParameters: mp);

    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;
        plansModel=filterModel!.plans!.where((element) => element.price!="0") .toList();

      });
    }

  }



   bool check(){

    if(typeSelectId==""){
      toastApp(tr("ChooseTheSubscriptionPlan"), context);
    return false;
    }
    return true;
  }


  Future<void> pay() async {
    setState(() {
      isLoading=true;
    });

    Map<String, String> mp = {};
    mp["type"]="subscribe_office";
    mp["plan_id"]=typeSelectId.toString();

    var payment= await dio.post("v1/getCheckoutUrl",data: mp);
    var response=PaymentResponse(payment.data);
    setState(() {
      isLoading=false;
    });

    if(response.status==200){
      WebViewOfferPaymentState.openUrl=response.data!.url.toString();
      SamaOfficeApp.navKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const WebViewOfferPayment()),
      );

    }else{
      toastAppSuccess(response.msg.toString(),context);
    }

  }




}