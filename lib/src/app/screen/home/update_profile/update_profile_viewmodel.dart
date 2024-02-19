import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';



import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/core/local/storagehelper.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/update_profile/update_profile_view.dart';

import '../../../auth/auth_model/auth_response.dart';
import '../../../auth/register/all_filter/cities_model.dart';
import '../../../auth/register/all_filter/city_response.dart';
import '../../../auth/register/all_filter/filter_model.dart';
import '../../../auth/register/all_filter/filter_response.dart';
import '../../../auth/register/all_filter/work_hour_model.dart';
import '../../../core/network/network_service.dart';
import '../../../core/utils/helper_manager.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/phone_number_widget.dart';
import '../../../home_core.dart';

abstract class UpDateProfileViewModel  extends State<UpDateProfileView> with StorageHelper{
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
   // LocationResult? result;


  @override
  void initState() {
    getFilterDataApi();
    HomeViewModel.profileModel!.office!=null?
    setData()
    : null;
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


  void descArSetState(String time ){ setState(() {detailsAr=time;});}
  void descEnSetState(String time ){ setState(() {detailsEn=time;});}


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
          language: HomeViewModel.lang,
          currentLatLng: LatLng(HomeViewModel.currentPosition!.latitude,HomeViewModel.currentPosition!.longitude) ,
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




  void setData(){
    setState(() {
      firstNameControl.text=HomeViewModel.profileModel!.firstName.toString();
      lastNameControl.text=HomeViewModel.profileModel!.lastName.toString();
      phoneControl.text=HomeViewModel.profileModel!.phone.toString();
      emailControl.text=HomeViewModel.profileModel!.email.toString();
      if(HomeViewModel.profileModel!.phone!.startsWith("+2")){
        phoneNumber=HomeViewModel.profileModel!.phone!.substring(0,3);
        phoneControl.text=HomeViewModel.profileModel!.phone!.substring(3);
      }
      else  if(HomeViewModel.profileModel!.phone!.startsWith("+9")){
        phoneNumber=HomeViewModel.profileModel!.phone!.substring(0,4);
        phoneControl.text=HomeViewModel.profileModel!.phone!.substring(4);

      }
      PhoneNumberSignUpWidgetState.codePhone=phoneNumber;

      PhoneNumberSignUpWidgetState.dropdownValue=phoneNumber;

      detailsAr=HomeViewModel.profileModel!.office!.description.toString()??"";
      completeNameArControl.text=HomeViewModel.profileModel!.office!.name.toString();
      addressArControl.text=HomeViewModel.profileModel!.office!.address.toString();
      // workHoursControl.text=HomeViewModel.profileModel!.office!.workingHours.toString();
      timeInSatControl.text=HomeViewModel.profileModel!.office!.startWorkAt.toString();
      timeoutSatControl.text=HomeViewModel.profileModel!.office!.endWorkAt.toString();
      completeNameEnControl.text=HomeViewModel.profileModel!.office!.nameEn.toString();
      detailsEn=HomeViewModel.profileModel!.office!.descriptionEn.toString();
      addressEnControl.text=HomeViewModel.profileModel!.office!.addressEn.toString();
      // workingHoursEnControl.text=HomeViewModel.profileModel!.office!.working_hours_en.toString();
      bankNameControl.text=HomeViewModel.profileModel!.office!.paymentInfo!.bankName!;
      bankNumberControl.text=HomeViewModel.profileModel!.office!.paymentInfo!.bankAccount!;
      ibanNumberControl.text=HomeViewModel.profileModel!.office!.paymentInfo!.iban!;

      if( HomeViewModel.profileModel!.office!.workingDays!.isNotEmpty){
        switchValueSat=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="saturday").status==1?true:false;
        switchValueSun=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="sunday").status==1?true:false;
        switchValueMon=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="monday").status==1?true:false;
        switchValueTus=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="tuesday").status==1?true:false;
        switchValueWed=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="wednesday").status==1?true:false;
        switchValueThur=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="thursday").status==1?true:false;
        switchValueFri=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="friday").status==1?true:false;

        timeInSatControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="saturday")
            .startWorkAt.toString();

        timeoutSatControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="saturday")
            .endWorkAt.toString();

        timeInSunControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="sunday")
            .startWorkAt.toString();

        timeoutSunControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="sunday")
            .endWorkAt.toString();

        timeInMonControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="monday")
            .startWorkAt.toString();

        timeoutMonControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="monday")
            .endWorkAt.toString();

        timeInTusControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="tuesday")
            .startWorkAt.toString();

        timeoutTusControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="tuesday")
            .endWorkAt.toString();

        timeInWedControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="wednesday")
            .startWorkAt.toString();

        timeoutWedControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="wednesday")
            .endWorkAt.toString();

        timeInThurControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="thursday")
            .startWorkAt.toString();

        timeoutThurControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="thursday")
            .endWorkAt.toString();

        timeInFriControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="friday")
            .startWorkAt.toString();

        timeoutFriControl.text=HomeViewModel.profileModel!.office!.workingDays!.firstWhere((e) => e.day=="friday")
            .endWorkAt.toString();

      }

    });


  }
  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });
    Map<String,dynamic> formData={};
    if(imageOffice!=null) {
      String imageUpdateUser = imageOffice!
          .path
          .split('/')
          .last;
      formData["image"]=  await MultipartFile.fromFile(imageOffice!.path, filename:imageUpdateUser);
    }
    formData["first_name"]=firstNameControl.value.text;
    formData["last_name"]=lastNameControl.value.text;
    formData["name_ar"]=completeNameArControl.value.text;
    formData["description_ar"]=detailsAr;
    formData["address_ar"]=addressArControl.value.text;
    if(selectedOfficeBranchID==null){
      formData["country_id"]= HomeViewModel.profileModel!.office!.countryId!.toString();
    }else{
      formData["country_id"]= selectedOfficeBranchID;
    }
    if(selectedCityID==null){
      formData["city_id"]= HomeViewModel.profileModel!.office!.cityId!.toString();
    }else{
      formData["city_id"]= selectedCityID;
    }

    if(result==null){
      formData["lat"]= HomeViewModel.profileModel!.office!.lat!.toString();
      formData["lng"]= HomeViewModel.profileModel!.office!.lng!.toString();
    }else{
      formData["lat"]= result!.geometry.location.lat.toString();
      formData["lng"]=result!.geometry.location.lng.toString();
    }
    formData["start_work_at"]=timeInSatControl.value.text;
    formData["end_work_at"]=timeoutSatControl.value.text;
    formData["working_hours_ar"]="من ${timeInSatControl.value.text} الى ${timeoutSatControl.value.text}";
    formData["name_en"]=completeNameEnControl.value.text;
    formData["description_en"]=detailsEn;
    formData["working_hours_en"]="from ${timeInSatControl.value.text} to ${timeoutSatControl.value.text}";
    formData["address_en"]=addressEnControl.value.text;
    formData["bank_name"]=bankNameControl.value.text;
    formData["bank_account"]=bankNumberControl.value.text;
    formData["iban"]=ibanNumberControl.value.text;


    List<WorkHourModel> listWorkHour=[];

    listWorkHour.add(WorkHourModel(id: 1,officeId:HomeViewModel.profileModel!.office!.id,
        day: "saturday",startWorkAt:timeInSatControl.text,
        endWorkAt: timeoutSatControl.text,status: switchValueSat==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 2,officeId:HomeViewModel.profileModel!.office!.id,
        day: "sunday",startWorkAt:timeInSunControl.text,
        endWorkAt: timeoutSunControl.text,status: switchValueSun==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 3,officeId:HomeViewModel.profileModel!.office!.id,
        day: "monday",startWorkAt:timeInMonControl.text,
        endWorkAt: timeoutMonControl.text,status: switchValueMon==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 4,officeId:HomeViewModel.profileModel!.office!.id,
        day: "tuesday",startWorkAt:timeInTusControl.text,
        endWorkAt: timeoutTusControl.text,status: switchValueTus==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 5,officeId:HomeViewModel.profileModel!.office!.id,
        day: "wednesday",startWorkAt:timeInWedControl.text,
        endWorkAt: timeoutWedControl.text,status: switchValueWed==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 6,officeId:HomeViewModel.profileModel!.office!.id,
        day: "thursday",startWorkAt:timeInThurControl.text,
        endWorkAt: timeoutThurControl.text,status: switchValueThur==true?1:0 ));

    listWorkHour.add(WorkHourModel(id: 7,officeId:HomeViewModel.profileModel!.office!.id,
        day: "friday",startWorkAt:timeInFriControl.text,
        endWorkAt: timeoutFriControl.text,status: switchValueFri==true?1:0 ));


    for(var index=0; index< listWorkHour.length;index++){
      formData["days[$index][day]"]=listWorkHour[index].day;
      formData["days[$index][start_work_at]"]=listWorkHour[index].startWorkAt;
      formData["days[$index][end_work_at]"]=listWorkHour[index].endWorkAt;
      formData["days[$index][status]"]=listWorkHour[index].status;

    }


    await Future.delayed(const Duration(seconds: 2));

    log(formData.toString());



    var up= await dio.post("v1/office/updateProfile",data:FormData.fromMap(formData) );
    var rs=AuthResponse(up.data!);
    setState(() {
      isLoading = false;
    });

    if(rs.status==200){

      toastAppSuccess(rs.msg!,context);
      await saveUser(rs.data);
      setState(() {
        HomeCorePage.index=0;
      });
      SamaOfficeApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) =>  HomeCore()),
      );


    }else{
      toastAppSuccess(rs.msg!,context);

    }
  }

}