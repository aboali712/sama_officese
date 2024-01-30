import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../more_viewModel.dart';
import 'contact_us_view.dart';

abstract class ContactUsViewModel extends State<ContactUsView>{
  final Dio dio = NetworkService.instance.dio;

  bool isLoading=false;
  TextEditingController subControl =TextEditingController();
  TextEditingController questionControl =TextEditingController();
  String phone="";
@override
  void initState() {
  pho();
    super.initState();
  }
  void pho(){
  if(MoreViewModel.settingsModel!.phone!.startsWith("+9666")){
    phone=MoreViewModel.settingsModel!.phone!;
    print(phone);
  }else{
    phone="+966${MoreViewModel.settingsModel!.phone!}";
    print(phone);
  }

  }





  bool checkValidation() {
    if (subControl.value.text == "") {
      toastApp(tr("Subject"), context);
      return false;
    }
    if (questionControl.value.text == "") {
      toastApp(tr("yourInquiry"), context);
      return false;
    }
    return true;
  }

  Future<void> contactApi() async {
    if (!checkValidation()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final response = await dio.post("v1/office/sendContact",
        data: Map.of({
          "subject": subControl.value.text,
          "message": questionControl.value.text
        }));

    var rs = EmptyResponse(response.data!);
    setState(() {
      isLoading = false;
    });
    if (rs.status == 200) {
      toastAppSuccess(rs.msg!,context);
      Navigator.pop(context);


    }
  }




}