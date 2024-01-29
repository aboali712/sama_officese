import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../auth/register/all_filter/cities_model.dart';
import '../../../../auth/register/all_filter/city_response.dart';
import '../../../../auth/register/all_filter/country_model.dart';
import '../../../../auth/register/all_filter/filter_model.dart';
import '../../../../auth/register/all_filter/filter_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../../core/widgets/calender_dialog.dart';
import '../models/imageModel.dart';

import 'dart:io';

import 'package:uri_to_file/uri_to_file.dart';

abstract class UpDateViewModel extends State<UpDateView>{
  final Dio dio = NetworkService.instance.dio;

  final ImagePicker imagePicker = ImagePicker();
  File? mainImage;
  List<XFile> imageFileList=[];
  File? compressedListImages;
  int lan=0;
  int description=0;
  TextEditingController packageNameArControl =TextEditingController();
  TextEditingController packageNameEnControl =TextEditingController();
  TextEditingController packagePriceControl =TextEditingController();
  TextEditingController packageDiscountControl =TextEditingController();
  TextEditingController daysControl =TextEditingController();
  TextEditingController nightsControl =TextEditingController();
  TextEditingController numOfPersonControl =TextEditingController();
  HtmlEditorController controllerDetailsAr = HtmlEditorController();
  HtmlEditorController controllerDetailsEn = HtmlEditorController();

  String detailsAr="";
  String detailsEn="";

  FilterModel? filterModel;

  List<CountryModel> selectedCountry =[];
  List<String> selectedCountryId =[];
  List<CityModel> selectedCites =[];
  List<String>? selectedCitesId ;

  String countryId="";
  List<CityModel> cites =[];
  String startSelectedDate = '';
  String endSelectedDate = '';

  String selectStatus="normal";
  String offerType="individual";
  bool? switchValue;
  bool isLoading=false;
 static OfferModel?offerModel;
 bool? isVIP;

  @override
  void initState() {

    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(DateTime.now());

      endSelectedDate = DateFormat('yyyy-MM-dd',"en")
          .format(DateTime.now().add(const Duration(days: 1)));
    });
    setData();
    getFilterDataApi();
    super.initState();
  }



  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(args.value.startDate);
      endSelectedDate = DateFormat('yyyy-MM-dd',"en")
          .format(args.value.endDate ?? args.value.startDate);

    });

  }
  void selectDate(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CalenderDialog(onSelectionChanged);

        });
  }


  void selectImages() async {
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      print("${selectedImages.map((e) => e.path)} 3333333333333333333333333333333");
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){});
  }


  Future<void> addImages() async {

    for (int i = 0; i < imageFileList!.length; i++) {
      var path = File(imageFileList![i].path);

      var result = await FlutterImageCompress.compressAndGetFile(
        path.absolute.path,
        path.path + 'compressed.jpg',
        quality: 50,
      );
      setState(() {
        compressedListImages = result;
      });
      print(compressedListImages!.path);


    }
    await Future.delayed(Duration(seconds: 10));
  }


  Future<void> getFilterDataApi() async {
    Map<String, String> mp = {};

    final response = await dio.get("v1/filter", queryParameters: mp);

    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;
      });
    }

  }


  Future<void> getCityDataApi() async {
    Map<String, String> mp = {};
    selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);

    final response = await dio.get("v1/citiesByCountries",queryParameters: mp );

    var rs = CitiesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        cites = rs.data!;
      });
    }
  }

  List<ImagesModel>?packageImages;





  Future<void> setData() async {
    setState(() {
      isLoading = true;
    });


    packageNameArControl.text=offerModel!.nameAr!;
    packageNameEnControl.text=offerModel!.nameEn!;
    detailsAr=offerModel!.descriptionAr!;
    detailsEn=offerModel!.descriptionEn!;
   offerModel!.status.toString()=="active"?   selectStatus =="normal" :"weekend" ;

    packagePriceControl.text=offerModel!.priceBefore!.toString();

    packageImages=offerModel!.images;


    imageFileList=[];



  switchValue=offerModel!.is_vip.toString()=="1"? true :false;
    packageDiscountControl.text=offerModel!.priceAfter!.toString();
    selectedCountryId=offerModel!.countries_list!.toList();
    selectedCitesId=offerModel!.cities_list!.toList();
    print(selectedCitesId);
    print(selectedCountryId);
    countryId = offerModel!.countryId.toString();

    offerType=offerModel!.offer_type!;
    if(offerType=="group"){
      setState(() {
        numOfPersonControl.text=offerModel!.num_of_persons.toString();
      });
    }
    daysControl.text=offerModel!.numOfDays.toString();
    nightsControl.text=offerModel!.num_of_nights.toString();

    startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.startDate!));

    endSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.endDate!));

    setState(() {
      isLoading = false;
    });
  }


  Future<bool> checkData() async {


    // if(imageFileList!.isEmpty){
    //   toastApp(tr("ChoosePackageImages"), context);
    //   return false;
    // }
    //
    // if(imageFileList!.length<2){
    //   toastApp(tr("PhotosMustBeAtLeast2Photos"), context);
    //   return false;
    // }

    if(packageNameArControl.text==""){
      toastApp(tr("EnterTheDisplayNameInArabic"), context);
      return false;
    }
    if(packageNameEnControl.text==""){
      toastApp(tr("EnterTheDisplayNameInEnglish"), context);
      return false;
    }
    if(detailsAr==""){
      toastApp(tr("EnterTheDescriptionInArabic"), context);
      return false;
    }
    if(detailsEn==""){
      toastApp(tr("EnterTheDescriptionInEnglish"), context);
      return false;
    }


    if(packagePriceControl.text==""){
      toastApp(tr("EnterTheOfferPrice"), context);
      return false;
    }

    if(packageDiscountControl.text==""){
      toastApp(tr("EnterTheOfferPriceAfterDiscount"), context);
      return false;
    }


    if(daysControl.text==""){
      toastApp(tr("EnterTheNumberOfDays"), context);
      return false;
    }
    if(nightsControl.text==""){
      toastApp(tr("EnterTheNumberOfNights"), context);
      return false;
    }

    if(selectedCountryId.isEmpty){
      toastApp(tr("SelectCountries"), context);
      return false;
    }

    if(selectedCitesId!.isEmpty){
      toastApp(tr("SelectCities"), context);
      return false;
    }


    return true;
  }



  Future<void> upDate() async {
    if(await checkData()){
    setState(() {
    isLoading=true;
    });

    Map<String, dynamic> mp = {};
    mp["type"]=selectStatus;
    mp["name_ar"]=packageNameArControl.value.text.toString();
    mp["name_en"]=packageNameEnControl.value.text.toString();
    mp["description_ar"]=detailsAr;
    mp["description_en"]=detailsEn;
    mp["country_id"]=countryId;
    mp["is_vip"]= switchValue==true ? "1":"0";

    mp["city_id"]=selectedCitesId;
    mp["price_after"]=packagePriceControl.value.text.toString();
    mp["price_before"]=packageDiscountControl.value.text.toString();
    mp["start_date"]=startSelectedDate;
    mp["end_date"]=endSelectedDate;
    selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);
    selectedCitesId!.asMap().forEach((index, value) =>  mp["cities[$index]"] = value);

    mp["offer_type"]=offerType;
    mp["num_of_persons"]=offerType=="group"? numOfPersonControl.value.text: 1;
    mp["num_of_days"]=daysControl.value.text;
    mp["num_of_nights"]=nightsControl.value.text;



    if(imageFileList!=null) {
      imageFileList?.asMap().forEach((index, element) async {
        mp["images[$index]"] = await MultipartFile.fromFile(element.path,filename: element.path.split('/').last);
      });
    }





    if(imageFileList!=null){
      mp["image"]=
      await MultipartFile.fromFile(imageFileList![0].path, filename:imageFileList![0].path.split('/').last);
    }


    print(mp);
    final response = await dio.post("v1/office/offers/${offerModel!.id}/update", data: FormData.fromMap(mp));

    var rs = EmptyResponse(response.data!);
    setState(() {
    isLoading=false;
    });

    if (rs.status == 200) {
    setState(() {
    toastAppSuccess(rs.msg!, context);
    SamaOfficeApp.navKey.currentState!.pop(context);

    });
    }else{
    toastApp(rs.msg!, context);

    }
    }


  }




}