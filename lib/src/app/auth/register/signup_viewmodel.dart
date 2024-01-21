import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_officese/src/app/auth/register/signup_view.dart';

import '../../core/network/network_service.dart';
import 'all_filter/cities_model.dart';
import 'all_filter/city_response.dart';
import 'all_filter/filter_model.dart';
import 'all_filter/filter_response.dart';

abstract class SignUpViewModel extends State<SignUp>{
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


  @override
  void initState() {
    getFilterDataApi();

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







}