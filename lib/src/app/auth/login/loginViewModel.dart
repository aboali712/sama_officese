import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:sama_officese/src/app.dart';

import '../../core/local/storagehelper.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import '../../core/widgets/phone_number_widget.dart';
import '../../home_core.dart';
import '../auth_model/auth_response.dart';
import '../verify_code/verify_code_view.dart';
import '../verify_code/verify_code_view_model.dart';
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
    getCurrentLocation();
    // getDeviceToken().then((value) => setState(() {
    //   tokenDevice = value!;
    // }));
    getTokenDevice();
    getCurrentLocation();
    print("${tokenDevice} 3333333333333333333333330");
    super.initState();
  }

  getTokenDevice() async {
    await FirebaseMessaging.instance.getToken().then((value) => {
      setState(() {
        tokenDevice = value!;
      })
    });

    print(tokenDevice);
  }




  static LocationPermission? permission;
  static Position? currentPosition;

  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      toastApp("Location permission are denied", context);

      if (permission == LocationPermission.deniedForever) {
        toastApp("Location permission are permanetly denied", context);
      }
    }
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        print("${currentPosition!.latitude} 5555555555555555555");
        print("${currentPosition!.longitude} 5555555555555555555");

      });
    }).catchError((e) {
     toastApp(e.toString(), context);
    });
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

  Future<void> checkLogin() async {
    if (chekValidationLogin()) {
      setState(() {
        isLoading = true;
      });

      var ph = phoneNumber;
      if (ph.startsWith("0")) {
        ph = phoneNumber.substring(1);
      }

      ph = PhoneNumberSignUpWidgetState.codePhone + ph;
       // tokenDevice = (await FirebaseMessaging.instance.getToken())!;

      var lo = await dio.post("v1/office/login",
          data: Map.of(
              {"key": ph, "password": password, "device_token": tokenDevice}));
      var response = AuthResponse(lo.data!!);

      if (response.status == 200) {
        toastAppSuccess(response.msg!, context);
        await saveUser(response.data!);
        await saveToken(response.token!);
       saveUserFirebase(response.data!.office!.id!.toString());
        SamaOfficeApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) =>  HomeCore()),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        toastApp(response.msg!, context);
        setState(() {
          isLoading = false;
        });

        if (response.status == 201) {
          VerifyCodeViewModel.phone = ph;
          VerifyCodeViewModel.pageType = "0";
          SamaOfficeApp.navKey.currentState!.push(
            MaterialPageRoute(builder: (context) => const VrifyCode()),
          );
        }
      }
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

}
