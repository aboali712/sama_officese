
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';

import '../../auth/auth_model/auth_response.dart';
import '../../auth/auth_model/user_model.dart';
import '../../core/network/network_service.dart';
import 'home_view.dart';

abstract class HomeViewModel extends State<HomePage> with StorageHelper{
  final Dio dio = NetworkService.instance.dio;

 static UserModel? profileModel;
  bool isLoading=false;
 static String lang="";
  @override
  void initState() {
    getUserData();
    getLang().then((value) => setState((){lang=value!; }));
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("/v1/office/profile");
    var rs = AuthResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        profileModel = rs.data;

      });

    }

  }

}