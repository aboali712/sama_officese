import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/network/network_service.dart';
import 'Installments_view.dart';
import 'model/installment_model.dart';
import 'model/installment_response.dart';

abstract class InstallmentsViewModel extends State<InstallmentsView>{
  final Dio dio = NetworkService.instance.dio;

  bool isLoading=false;
  List <InstallmentModel>?installmentModel;
  List <InstallmentModel>?installmentLastResult=[];
  List <InstallmentModel>?installmentListSearch=[];

  TextEditingController textEditingController = TextEditingController();
  String? installmentId="";
  String? installment="";
  @override
  void initState() {
    getInstallments();
    super.initState();
  }

  Future<void> getInstallments() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("v1/office/ReservationInstallments",);
    var rs = InstallmentResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        installmentModel = rs.data;
        installmentLastResult=installmentModel;
        installmentModel!.forEach((element) {
          if(installmentListSearch!.map((e) => e.offerName).contains(element.offerName)==false){
            installmentListSearch!.add(element);
          }
        });
      });
    }
  }
}