import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../auth/auth_model/auth_response.dart';
import '../../screen/home/home_viewmodel.dart';
import '../local/storagehelper.dart';




class AuthenticationManager with StorageHelper {
  BuildContext context;
  AuthenticationManager({
    required this.context,
  }) {
    fetchUserLogin();
    fetchLang();
  }

  bool isLogin = false;
  bool isFirst = true;
  String lang = "en";

  Future<void> fetchUserLogin() async {
    final token = await getToken();

    if (token != null && token.length > 3) {
      isLogin = true;
    }
  }

  Future<void> fetchUserIsFirst() async {
    final first = await getFirst();

    if (first != null) {
      isFirst = first;
    }
  }

  Future<void> fetchLang() async {
    final first = await getLang();

    if (first != null) {
      lang = first;
    }
  }

  Future<void> saveChoosedLang() async {
    await saveLang(lang);
  }


  Future<void> getProfileDate() async {
    final response = await dio.get("/v1/office/profile"); // Get user profile
    var rs = AuthResponse(response.data!);
    if (rs.status == 200) {
      HomeViewModel.profileModel = rs.data;

          }
  }

}
