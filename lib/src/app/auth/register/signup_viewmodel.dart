
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/auth/register/signup_view.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';

import '../../../../main.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import '../../core/utils/input_validators.dart';
import '../../core/widgets/phone_number_widget.dart';
import '../../screen/home/home_viewmodel.dart';
import '../auth_model/empty_response.dart';
import '../login/loginViewModel.dart';
import '../verify_code/verify_code_view.dart';
import '../verify_code/verify_code_view_model.dart';
import 'all_filter/cities_model.dart';
import 'all_filter/city_response.dart';
import 'all_filter/filter_model.dart';
import 'all_filter/filter_response.dart';
import 'all_filter/service_model.dart';
import 'all_filter/work_hour_model.dart';

abstract class SignUpViewModel extends State<SignUp> with StorageHelper{
  final Dio dio = NetworkService.instance.dio;

  int step = 0;
  int lan=0;
  int lanDescription=0;
  int lanAddress=0;
  TextEditingController firstNameControl = TextEditingController();
  TextEditingController lastNameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController completeNameEnControl = TextEditingController();
  TextEditingController completeNameArControl = TextEditingController();
  TextEditingController addressArControl = TextEditingController();
  TextEditingController addressEnControl = TextEditingController();

  TextEditingController timeInSatControl = TextEditingController();
  TextEditingController timeoutSatControl = TextEditingController();

  TextEditingController timeInSunControl = TextEditingController();
  TextEditingController timeoutSunControl = TextEditingController();

  TextEditingController timeInMonControl = TextEditingController();
  TextEditingController timeoutMonControl = TextEditingController();

  TextEditingController timeInTusControl = TextEditingController();
  TextEditingController timeoutTusControl = TextEditingController();

  TextEditingController timeInWedControl = TextEditingController();
  TextEditingController timeoutWedControl = TextEditingController();

  TextEditingController timeInThurControl = TextEditingController();
  TextEditingController timeoutThurControl = TextEditingController();

  TextEditingController timeInFriControl = TextEditingController();
  TextEditingController timeoutFriControl = TextEditingController();

  TextEditingController bankNameControl = TextEditingController();
  TextEditingController bankNumberControl = TextEditingController();
  TextEditingController ibanNumberControl = TextEditingController();

  HtmlEditorController controllerDetailsAr = HtmlEditorController();
  HtmlEditorController controllerDetailsEn = HtmlEditorController();

  String detailsAr="";
  String detailsEn="";

  bool obscureTxt = true;

  String phoneNumber="";
  bool isPhone = false;
  final FocusNode focusPhone = FocusNode();
  ImagePicker picker = ImagePicker();
  XFile? imageOffice;
  QuillController arController = QuillController.basic();
  QuillController enController = QuillController.basic();
  FilterModel? filterModel;
  String? selectedOfficeBranch;
  String? selectedOfficeBranchID;
  bool isLoading=false;
  List<CityModel> cites =[];
  String? selectedCity;
  String? selectedCityID;
  String plan="";
  String planId="";


  bool switchValueSat = true;
  bool switchValueSun = true;
  bool switchValueMon = true;
  bool switchValueTus = true;
  bool switchValueWed = true;
  bool switchValueThur = true;
  bool switchValueFri = false;

  bool terms = false;


  late  List<ServiceModel> selectServices = [];
  String planPrice="";
  String tokenDevice="";


  @override
  void initState() {
    getFilterDataApi();
    getDeviceToken().then((value) => setState((){tokenDevice=value!;}));
    super.initState();
  }

  void passwordEyeSetState(bool eye ){ setState(() { obscureTxt=eye;}); }

  void phoneSetState(String phone ){ setState(() { phoneNumber=phone;}); }
  void imageSetState( ){ setState(() {});}
  void lanSetState(int lang ){ setState(() {lan=lang;});}
  void lanDescriptionSetState(int lang ){ setState(() {lanDescription=lang;});}
  void lanAddressSetState(int lang ){ setState(() {lanAddress=lang;});}
  void citySetState(String cit ){ setState(() {selectedCity=cit;});}

  void switchSatSetState(bool cit ){ setState(() {switchValueSat=cit;});}
  void timeSatSetState(String time ){ setState(() {timeInSatControl.text=time;});}
  void timeoutSatSetState(String time ){ setState(() {timeoutSatControl.text=time;});}

  void switchSunSetState(bool cit ){ setState(() {switchValueSun=cit;});}
  void timeSunSetState(String time ){ setState(() {timeInSunControl.text=time;});}
  void timeoutSunSetState(String time ){ setState(() {timeoutSunControl.text=time;});}

  void switchMonSetState(bool cit ){ setState(() {switchValueMon=cit;});}
  void timeInMonSetState(String time ){ setState(() {timeInMonControl.text=time;});}
  void timeoutMonSetState(String time ){ setState(() {timeoutMonControl.text=time;});}

  void switchTusSetState(bool cit ){ setState(() {switchValueTus=cit;});}
  void timeInTusSetState(String time ){ setState(() {timeInTusControl.text=time;});}
  void timeoutTusSetState(String time ){ setState(() {timeoutTusControl.text=time;});}

  void switchWedSetState(bool cit ){ setState(() {switchValueWed=cit;});}
  void timeInWedSetState(String time ){ setState(() {timeInWedControl.text=time;});}
  void timeoutWedSetState(String time ){ setState(() {timeoutWedControl.text=time;});}

  void switchThurSetState(bool cit ){ setState(() {switchValueThur=cit;});}
  void timeInThurSetState(String time ){ setState(() {timeInThurControl.text=time;});}
  void timeoutThurSetState(String time ){ setState(() {timeoutThurControl.text=time;});}

  void switchFriSetState(bool cit ){ setState(() {switchValueFri=cit;});}
  void timeInFriSetState(String time ){ setState(() {timeInFriControl.text=time;});}
  void timeoutFriSetState(String time ){ setState(() {timeoutFriControl.text=time;});}

  void termsSetState(bool time ){ setState(() {terms=time;});}

  void descArSetState(String time ){ setState(() {detailsAr=time;});}
  void descEnSetState(String time ){ setState(() {detailsEn=time;});}

  ServiceModel? serviceModel;
  void serviceSetState(ServiceModel service ){ setState(() {
    serviceModel=service;
   if( selectServices.contains(service)==false){
     selectServices.add(service);
   }else{
     selectServices.remove(service);
   }
   print(selectServices.map((e) => e.id));

  });}

  Future<void> getFilterDataApi() async {
    setState(() {
      isLoading=true;
    });
    Map<String, String> mp = {};

    final response = await dio.get("v1/filter", queryParameters: mp);
    setState(() {
      isLoading=false;
    });
    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;

      });
    }

  }


  Future<void> getCityDataApi() async {
    Map<String, String> mp = {};
    mp["country_id"]=selectedOfficeBranchID!;

    final response = await dio.get("v1/cities", queryParameters: mp);

    var rs = CitiesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        cites = rs.data!;
      });
    }

  }
  GeocodingResult? result;
  void showPlacePicker() async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapLocationPicker
          (
          language:"ar",
          currentLatLng: LatLng(LoginViewModel.currentPosition!.latitude,LoginViewModel.currentPosition!.longitude) ,
          apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc",
          onNext: (GeocodingResult? resu) {
            setState(() {
              result=resu;
              print(result!.formattedAddress!);
              print(result!.geometry.location.lat);
              print(result!.geometry.location.lng);

              Navigator.pop(context);
            });
          },
        )));
    // setState(() {
    //   result=re;
    //   print(result);
    // });

  }



  bool validStepOne(){
    if(firstNameControl.text==""){
      toastApp(tr("EnterFirstName"),context);
      return false;
    }
    if(lastNameControl.text==""){
      toastApp(tr("EnterTheLastName"),context);
      return false;
    }

    if(phoneNumber==""){
      toastApp(tr("PleaseEnterTheMobileNumber"),context);
      return false;
    }
    if(emailControl.text==""){
      toastApp(tr("EnterEmail"),context);
      return false;
    }
    if ( !InputValidators().emailValidator( email: emailControl.text, context: context ) ){
      toastApp(tr("EnterCorrectEmail"),context);
      return false;
    }

    if(passwordControl.text==""){
      toastApp(tr("EnterPassword"),context);
      return false;
    }

    return true;
  }


  bool validStepTwo(){
    if(imageOffice==null){
      toastApp(tr("ChooseTheOfficeLogo"),context);
      return false;
    }
    if(completeNameArControl.text==""){
      toastApp(tr("EnterTheOfficeNameInArabic"),context);
      return false;
    }
    if(completeNameEnControl.text==""){
      toastApp(tr("EnterTheOfficeNameInEnglish"),context);
      return false;
    }

    if(detailsAr==""){
      toastApp(tr("EnterTheDescriptionInArabic"),context);
      return false;
    }

    if( detailsEn==""){
      toastApp(tr("EnterTheDescriptionInEnglish"),context);
      return false;
    }
    if(addressArControl.text==""){
      toastApp(tr("EnterTheAddressInArabic"),context);
      return false;
    }

    if(addressEnControl.text==""){
      toastApp(tr("EnterTheAddressInEnglish"),context);
      return false;
    }

    if(result==null){
      toastApp(tr("ChooseAddressFrom"),context);
      return false;
    }

    if(selectedOfficeBranch==null){
      toastApp(tr("ChooseTheOfficeBranch"),context);
      return false;
    }
    if(selectedCity==""){
      toastApp(tr("ChooseTheCity"),context);
      return false;
    }

    if(switchValueSat==true){
      if(timeInSatControl.text==""){ toastApp("أدخل بداية عمل يوم السبت", context);return false; }
      if(timeoutSatControl.text==""){ toastApp("أدخل نهاية عمل يوم السبت", context);return false; }

    }

    if(switchValueSun==true){
      if(timeInSunControl.text==""){ toastApp("أدخل بداية عمل يوم الأحد", context);return false; }
      if(timeoutSunControl.text==""){ toastApp("أدخل نهاية عمل يوم الأحد", context);return false; }

    }


    if(switchValueMon==true){
      if(timeInMonControl.text==""){ toastApp("أدخل بداية عمل يوم الأثنين", context);return false; }
      if(timeInMonControl.text==""){ toastApp("أدخل نهاية عمل يوم الأثنين", context);return false; }

    }


    if(switchValueTus==true){
      if(timeInTusControl.text==""){ toastApp("أدخل بداية عمل يوم الثلاثاء", context);return false; }
      if(timeoutTusControl.text==""){ toastApp("أدخل نهاية عمل يوم الثلاثاء", context);return false; }

    }



    if(switchValueWed==true){
      if(timeInWedControl.text==""){ toastApp("أدخل بداية عمل يوم الأربعاء", context);return false; }
      if(timeoutWedControl.text==""){ toastApp("أدخل نهاية عمل يوم الأربعاء", context);return false; }

    }



    if(switchValueThur==true){
      if(timeInThurControl.text==""){ toastApp("أدخل بداية عمل يوم الخميس", context);return false; }
      if(timeoutThurControl.text==""){ toastApp("أدخل نهاية عمل يوم الخميس", context);return false; }
    }


    if(switchValueFri==true){
      if(timeInFriControl.text==""){ toastApp("أدخل بداية عمل يوم الجمعة", context);return false; }
      if(timeoutFriControl.text==""){ toastApp("أدخل نهاية عمل يوم الجمعة", context);return false; }

    }


    return true;
  }






  bool validStepThree(){
    if(selectServices.length==0){
      toastApp(tr("ChooseServices"),context);
      return false;
    }

    if(bankNameControl.text==""){
      toastApp(tr("EnterTheNameOfTheBank"),context);
      return false;
    }
    if(bankNumberControl.text==""){
      toastApp(tr("EnterTheAccountNumber"),context);
      return false;
    }
    if(ibanNumberControl.text==""){
      toastApp(tr("EnterTheIBANNumber"),context);
      return false;
    }
    if(plan==""){
      toastApp(tr("ChooseTheSubscriptionPlan"),context);
      return false;
    }

    if (terms == false) {
      toastApp(tr("ChooseTermsAndConditions"),context);
      return false;
    }

    return true;
  }





  Future<void> registerCallApi() async {





    var ph=phoneNumber;
    if (ph.startsWith("0")) {
      ph = phoneNumber.substring(1);
    }

    ph = PhoneNumberSignUpWidgetState.codePhone + ph;

    //+201030025254
    setState(() {
      isLoading=true;
    });

    // tokenDevice=(await FirebaseMessaging.instance.getToken())!;





    String imageOfficeName = imageOffice!.path.split('/').last;
    String imageCommercialName = imageOffice!.path.split('/').last;
    Map<String,dynamic> mp={};
    mp["name"]="${firstNameControl.value.text} ${lastNameControl.value.text}";
    mp["email"]=emailControl.value.text;
    mp["device_token"]=tokenDevice;
    mp["phone"]=ph;
    mp["password"]=passwordControl.value.text;
    mp["country_id"]=selectedOfficeBranchID.toString();
    mp["city_id"]=selectedCityID.toString();
    mp["plan_id"]=planId.toString();
    mp["address"]=addressArControl.value.text;
    mp["office_name"]=completeNameArControl.value.text;
    mp["lat"]=result!.geometry.location.lat.toString();
    mp["lng"]=result!.geometry.location.lng.toString();
    mp["bank_name"]=bankNameControl.value.text;
    mp["bank_account"]=bankNumberControl.value.text;
    mp["iban"]=ibanNumberControl.value.text;
    mp["working_hours"]="من ${timeInSatControl.value.text} الى ${timeoutSatControl.value.text}";
    mp["start_work_at"]=timeInSatControl.value.text;
    mp["end_work_at"]=timeoutSatControl.value.text;
    selectServices.asMap().forEach((index, element)  {mp[ "services[$index]"] =element.id.toString(); });
    mp["image"]=
    await MultipartFile.fromFile(imageOffice!.path, filename:imageOfficeName);
    mp["commercial_registeration_no"]=await MultipartFile.fromFile(imageOffice!.path, filename:imageCommercialName);

List<WorkHourModel> listWorkHour=[];

   listWorkHour.add(WorkHourModel(id: 1,officeId:87,day: "saturday",startWorkAt:timeInSatControl.text,
       endWorkAt: timeoutSatControl.text,status: switchValueSat==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 2,officeId:87,day: "sunday",startWorkAt:timeInSunControl.text,
        endWorkAt: timeoutSunControl.text,status: switchValueSun==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 3,officeId:87,day: "monday",startWorkAt:timeInMonControl.text,
        endWorkAt: timeoutMonControl.text,status: switchValueMon==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 4,officeId:87,day: "tuesday",startWorkAt:timeInTusControl.text,
        endWorkAt: timeoutTusControl.text,status: switchValueTus==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 5,officeId:87,day: "wednesday",startWorkAt:timeInWedControl.text,
        endWorkAt: timeoutWedControl.text,status: switchValueWed==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 6,officeId:87,day: "thursday",startWorkAt:timeInThurControl.text,
        endWorkAt: timeoutThurControl.text,status: switchValueThur==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 7,officeId:87,day: "friday",startWorkAt:timeInFriControl.text,
        endWorkAt: timeoutFriControl.text,status: switchValueFri==true?1:0 ));


    for(var index=0; index< listWorkHour.length;index++){
      mp["days[$index][day]"]=listWorkHour[index].day;
      mp["days[$index][start_work_at]"]=listWorkHour[index].startWorkAt;
      mp["days[$index][end_work_at]"]=listWorkHour[index].endWorkAt;
      mp["days[$index][status]"]=listWorkHour[index].status;

    }


    await Future.delayed(const Duration(seconds: 2));

  log(mp.toString());


    var rs = await dio.post("v1/office/register",data:FormData.fromMap(mp));
    var response = EmptyResponse(rs.data!!);

    if(response.status==201){
      VerifyCodeViewModel.phone=ph;
      VerifyCodeViewModel.pageType="0";

      if(planPrice!="0"){
        setState(() {
          VerifyCodeViewModel.subscriptionPage=true;
        });
      }

      toastAppSuccess(response.msg!,context);
      SamaOfficeApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const VrifyCode()),
      );
      setState(() {
        isLoading=false;
      });
    }else{
      toastApp(response.msg!,context);
      setState(() {
        isLoading=false;
      });
    }
  }







}