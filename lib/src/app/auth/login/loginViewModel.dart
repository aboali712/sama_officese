import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/local/storagehelper.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import 'loginPage.dart';

abstract class LoginViewModel extends State<LoginPage> with StorageHelper {
  bool isLoading = false;
  bool isPhone = false;
  final FocusNode focusPhone = FocusNode();
  String phoneNumber = "";
  var obscureTxt = true;
  String password = "";
  bool isValidationError = false;
  bool phoneValidation = false;
  final Dio dio = NetworkService.instance.dio;
  String tokenDevice = "";

  @override
  void initState() {

    super.initState();
  }

  bool chekValidationLogin() {
    if (phoneNumber == "") {
      toastApp(tr("EnterMobile"), context);
      return false;
    }
    if (password == "") {
      toastApp(tr("EnterPassword"), context);
      return false;
    }
    return true;
  }

}
