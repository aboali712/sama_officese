import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/auth/verify_code/verify_code_view.dart';



import '../../core/local/storagehelper.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import '../../home_core.dart';
import '../auth_model/auth_response.dart';
import '../auth_model/empty_response.dart';
import '../change_password/change_password_view.dart';



abstract class VerifyCodeViewModel extends State<VrifyCode> with StorageHelper {
  TextEditingController pinCodeControl = TextEditingController();
  String? currentText;
  bool isTimeOff = false;
  String pinCode = "";
  bool isLoading = false;
  final Dio dio = NetworkService.instance.dio;
  static String phone = "";
  static String pageType = "0";
  static bool? subscriptionPage ;
  String? tokenDevice;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1500 * 30;
  late CountdownTimerController controller =
      CountdownTimerController(endTime: endTime, onEnd: onEnd);

  void onEnd() {
    setState(() {
      isTimeOff = true;
    });
  }
  @override
  void initState() {
    super.initState();
    getTokenDevice();
  }

  getTokenDevice() async {
    await FirebaseMessaging.instance.getToken().then((value) => {
      setState(() {
        tokenDevice = value!;
      })
    });

    print(tokenDevice);
  }
  bool checkPinCode() {
    if (pinCode == "") {
      toastApp(tr("EnterTheVerificationCode"), context);
      return false;
    }
    if (pinCode.length < 4) {
      toastApp(tr("EnterTheValidVerificationCode"), context);
      return false;
    }

    return true;
  }

  Future<void> goToHomePage() async {
    pinCode = pinCodeControl.value.text;
    if (checkPinCode()) {
      verify();
    }
  }

  Future<void> verify() async {
    setState(() {
      isLoading = true;
    });
    var rs = await dio.post("v1/office/verify-code", data: Map.of({"code": pinCode,"phone":phone,"device_token":tokenDevice}));
    var response = AuthResponse(rs.data!);


    if (response.status == 200) {
      await saveToken(response.token!);
      setState(() {
        isLoading = false;
      });
      toastAppSuccess(response.msg!, context);

      if (pageType == "0") {
        await saveUser(response.data!);
        saveUserFirebase(response.data!.office!.id.toString());

       if(VerifyCodeViewModel.subscriptionPage==true){
         // SamaOfficeApp.navKey.currentState!.pushReplacement(
         //     MaterialPageRoute(builder: (context) =>  const SubscriptionPage()));
       }else{
         SamaOfficeApp.navKey.currentState!.pushReplacement(
           MaterialPageRoute(builder: (context) =>  HomeCore()),
         );
       }


      } else {
        SamaOfficeApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const ChangePassword()),
        );
      }
    } else {
      toastApp(response.msg!, context);
      setState(() {
        isLoading = false;
      });



    }
  }

  Future<void> saveUserFirebase(String id) async {
    Map<String, String> mp = Map.of({"count_offers": "0", "counts": "0"});

    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref('offices/$id');
    starCountRef.get().then((value) => {
      if (value.children.isEmpty) {starCountRef.set(mp)}
    });
  }

  Future<void> resend() async {
    setState(() {
      isLoading = true;
    });
    var rs = await dio.post("v1/office/send-code", data: Map.of({"key": phone}));
    var response = EmptyResponse(rs.data!);

    if (response.status == 200) {
      toastAppSuccess(response.msg!, context);
      setState(() {
        isLoading = false;
      });
    } else {
      toastApp(response.msg!, context);
      setState(() {
        isLoading = false;
      });
    }
  }
}
