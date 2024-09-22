// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sama_officese/src/app.dart';
// import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart';
// import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_view.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// import '../../../../auth/auth_model/empty_response.dart';
// import '../../../../auth/register/all_filter/cities_model.dart';
// import '../../../../auth/register/all_filter/city_response.dart';
// import '../../../../auth/register/all_filter/country_model.dart';
// import '../../../../auth/register/all_filter/filter_model.dart';
// import '../../../../auth/register/all_filter/filter_response.dart';
// import '../../../../core/network/network_service.dart';
// import '../../../../core/utils/helper_manager.dart';
// import '../../../../core/widgets/calender_dialog.dart';
// import '../models/imageModel.dart';
//
//
//
// abstract class UpDateViewModel extends State<UpDateView>{
//   final Dio dio = NetworkService.instance.dio;
//
//   final ImagePicker imagePicker = ImagePicker();
//   File? mainImage;
//   List<XFile> imageFileList=[];
//   File? compressedListImages;
//   int lan=0;
//   int description=0;
//   TextEditingController packageNameArControl =TextEditingController();
//   TextEditingController packageNameEnControl =TextEditingController();
//   TextEditingController packagePriceControl =TextEditingController();
//   TextEditingController packageDiscountControl =TextEditingController();
//   TextEditingController daysControl =TextEditingController();
//   TextEditingController nightsControl =TextEditingController();
//   TextEditingController numOfPersonControl =TextEditingController();
//   HtmlEditorController controllerDetailsAr = HtmlEditorController();
//   HtmlEditorController controllerDetailsEn = HtmlEditorController();
//
//   String detailsAr="";
//   String detailsEn="";
//
//   FilterModel? filterModel;
//
//   List<CountryModel> selectedCountry =[];
//   List<String> selectedCountryId =[];
//   List<CityModel> selectedCites =[];
//   List<String>? selectedCitesId ;
//
//   String countryId="";
//   List<CityModel> cites =[];
//   String startSelectedDate = '';
//   String endSelectedDate = '';
//
//   String selectStatus="normal";
//   String offerType="individual";
//   bool? switchValue=false;
//   bool isLoading=false;
//  static OfferModel?offerModel;
//  bool? isVIP;
//   String isSingle="";
//   String isInternational="";
//   int? installmentAvailable;
//
//
//   @override
//   void initState() {
//
//     setState(() {
//       startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(DateTime.now());
//
//       endSelectedDate = DateFormat('yyyy-MM-dd',"en")
//           .format(DateTime.now().add(const Duration(days: 1)));
//     });
//     setData();
//     getFilterDataApi();
//     print("${offerModel!.priceAfter.toString()} 88888888888888888888888888888");
//     print("${offerModel!.priceBefore.toString()} 88888888888888888888888888888");
//     print("${offerModel!.price_after_without_app_percent.toString()} 88888888888888888888888888888");
//     print("${offerModel!.price_before_without_app_percent.toString()} 88888888888888888888888888888");
//
//     super.initState();
//   }
//
//
//
//   void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     setState(() {
//       startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(args.value.startDate);
//       endSelectedDate = DateFormat('yyyy-MM-dd',"en")
//           .format(args.value.endDate ?? args.value.startDate);
//
//     });
//
//   }
//   void selectDate(){
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return CalenderDialog(onSelectionChanged);
//
//         });
//   }
//
//
//   void selectImages() async {
//     final List<XFile> selectedImages = await
//     imagePicker.pickMultiImage();
//
//     if (selectedImages.isNotEmpty) {
//       print("${selectedImages.map((e) => e.path)} 3333333333333333333333333333333");
//       imageFileList.addAll(selectedImages);
//     }
//     print("Image List Length:" + imageFileList.length.toString());
//     setState((){});
//   }
//
//
//   Future<void> addImages() async {
//
//     for (int i = 0; i < imageFileList.length; i++) {
//       var path = File(imageFileList[i].path);
//
//       var result = await FlutterImageCompress.compressAndGetFile(
//         path.absolute.path,
//         path.path + 'compressed.jpg',
//         quality: 50,
//       );
//       setState(() {
//         compressedListImages = File(result!.path);
//       });
//       print(compressedListImages!.path);
//
//
//     }
//     await Future.delayed(Duration(seconds: 10));
//   }
//
//
//   Future<void> getFilterDataApi() async {
//     Map<String, String> mp = {};
//
//     final response = await dio.get("v1/filter", queryParameters: mp);
//
//     var rs = FilterResponse(response.data!);
//     if (rs.status == 200) {
//       setState(() {
//         filterModel = rs.data;
//       });
//     }
//
//   }
//
//
//   Future<void> getCityDataApi() async {
//     Map<String, String> mp = {};
//     selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);
//
//     final response = await dio.get("v1/citiesByCountries",queryParameters: mp );
//
//     var rs = CitiesResponse(response.data!);
//     if (rs.status == 200) {
//       setState(() {
//         cites = rs.data!;
//       });
//     }
//   }
//
//   List<ImagesModel>?packageImages=[];
//
//
//
//
//
//   Future<void> setData() async {
//     setState(() {
//       isLoading = true;
//     });
//
//
//     packageNameArControl.text=offerModel!.nameAr!;
//     packageNameEnControl.text=offerModel!.nameEn!;
//     detailsAr=offerModel!.descriptionAr!;
//     detailsEn=offerModel!.descriptionEn!;
//     selectStatus= offerModel!.type.toString();
//     packagePriceControl.text=offerModel!.price_before_without_app_percent!.toString();
//     packageImages=offerModel!.images;
//      // imageFileList=[];
//   switchValue=offerModel!.is_vip.toString()=="1"? true :false;
//     packageDiscountControl.text=offerModel!.price_after_without_app_percent!.toString();
//     selectedCountryId=offerModel!.countries_list!.toList();
//     selectedCitesId=offerModel!.cities_list!.toList();
//     // print(selectedCitesId);
//     // print(selectedCountryId);
//     countryId = offerModel!.countryId.toString();
//     offerType=offerModel!.offer_type!;
//     if(offerType=="group"){
//       setState(() {
//         numOfPersonControl.text=offerModel!.num_of_persons.toString();
//       });
//     }
//     daysControl.text=offerModel!.numOfDays.toString();
//     nightsControl.text=offerModel!.num_of_nights.toString();
//     startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.startDate!));
//     endSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.endDate!));
//
//     isSingle=offerModel!.is_single.toString();
//     isInternational=offerModel!.is_international.toString();
//     installmentAvailable=offerModel!.is_installment;
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//
//   Future<bool> checkData() async {
//
//
//     // if(imageFileList!.isEmpty){
//     //   toastApp(tr("ChoosePackageImages"), context);
//     //   return false;
//     // }
//     //
//     // if(imageFileList!.length<2){
//     //   toastApp(tr("PhotosMustBeAtLeast2Photos"), context);
//     //   return false;
//     // }
//
//     if(packageNameArControl.text==""){
//       toastApp(tr("EnterTheDisplayNameInArabic"), context);
//       return false;
//     }
//     if(packageNameEnControl.text==""){
//       toastApp(tr("EnterTheDisplayNameInEnglish"), context);
//       return false;
//     }
//     if(detailsAr==""){
//       toastApp(tr("EnterTheDescriptionInArabic"), context);
//       return false;
//     }
//     if(detailsEn==""){
//       toastApp(tr("EnterTheDescriptionInEnglish"), context);
//       return false;
//     }
//
//
//     if(packagePriceControl.text==""){
//       toastApp(tr("EnterTheOfferPrice"), context);
//       return false;
//     }
//
//     if(packageDiscountControl.text==""){
//       toastApp(tr("EnterTheOfferPriceAfterDiscount"), context);
//       return false;
//     }
//
//
//     if(daysControl.text==""){
//       toastApp(tr("EnterTheNumberOfDays"), context);
//       return false;
//     }
//     if(nightsControl.text==""){
//       toastApp(tr("EnterTheNumberOfNights"), context);
//       return false;
//     }
//
//     if(selectedCountryId.isEmpty){
//       toastApp(tr("SelectCountries"), context);
//       return false;
//     }
//
//     if(selectedCitesId!.isEmpty){
//       toastApp(tr("SelectCities"), context);
//       return false;
//     }
//
//
//     return true;
//   }
//
//
//
//   Future<void> upDate() async {
//     if(await checkData()){
//     setState(() {
//     isLoading=true;
//     });
//
//     Map<String, dynamic> mp = {};
//     mp["type"]=selectStatus;
//     mp["name_ar"]=packageNameArControl.value.text.toString();
//     mp["name_en"]=packageNameEnControl.value.text.toString();
//     mp["description_ar"]=detailsAr;
//     mp["description_en"]=detailsEn;
//     mp["country_id"]=countryId;
//     mp["is_vip"]= switchValue==true ? "1":"0";
//
//     mp["city_id"]=selectedCitesId;
//     mp["price_after"]=packageDiscountControl.value.text.toString();
//     mp["price_before"]=packagePriceControl.value.text.toString();
//     mp["start_date"]=startSelectedDate;
//     mp["end_date"]=endSelectedDate;
//     selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);
//     selectedCitesId!.asMap().forEach((index, value) =>  mp["cities[$index]"] = value);
//
//     mp["offer_type"]=offerType;
//     mp["num_of_persons"]=offerType=="group"? numOfPersonControl.value.text: 1;
//     mp["num_of_days"]=daysControl.value.text;
//     mp["num_of_nights"]=nightsControl.value.text;
//     mp["is_single"]=isSingle;
//     mp["is_international"]=isInternational;
//     mp["is_installment"]=installmentAvailable;
//
//
//
//
//     //  imageFileList.asMap().forEach((index, element) async {
//    //    mp["images[$index]"] = await MultipartFile.fromFile(element.path,filename: element.path.split('/').last);
//    //  });
//    //
//    //
//    // if(imageFileList.isNotEmpty){
//    //   mp["image"]=
//    //   await MultipartFile.fromFile(imageFileList[0].path, filename:imageFileList[0].path.split('/').last);
//    // }
//
//     print(mp);
//     final response = await dio.post("v1/office/offers/${offerModel!.id}/update", data: FormData.fromMap(mp));
//
//     var rs = EmptyResponse(response.data!);
//     setState(() {
//     isLoading=false;
//     });
//
//     if (rs.status == 200) {
//     setState(() {
//     toastAppSuccess(rs.msg!, context);
//      SamaOfficeApp.navKey.currentState!.pop(context);
//
//
//     });
//     }else{
//     toastApp(rs.msg!, context);
//
//     }
//     }
//
//
//   }
//
//
//
//
// }


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
import 'package:html/parser.dart' as html_parser;
abstract class UpDateViewModel extends State<UpDateView> {
  final Dio dio = NetworkService.instance.dio; // Dio instance for network requests
  final ImagePicker imagePicker = ImagePicker(); // Image picker instance

  File? mainImage; // Main image file
  List<XFile> imageFileList = []; // List of selected images
  File? compressedListImages; // Compressed image file
  int lan = 0; // Language selection (0: Arabic, 1: English)
  int description = 0; // Description selection

  // Text controllers for input fields
  TextEditingController packageNameArControl = TextEditingController();
  TextEditingController packageNameEnControl = TextEditingController();
  TextEditingController packagePriceControl = TextEditingController();
  TextEditingController packageDiscountControl = TextEditingController();
  TextEditingController daysControl = TextEditingController();
  TextEditingController nightsControl = TextEditingController();
  TextEditingController numOfPersonControl = TextEditingController();

  // HTML editors for rich text input
  HtmlEditorController controllerDetailsAr = HtmlEditorController();
  HtmlEditorController controllerDetailsEn = HtmlEditorController();
  TextEditingController priceIncludeArControl =TextEditingController();
  TextEditingController priceIncludeEnControl =TextEditingController();
  TextEditingController priceNotIncludeControl =TextEditingController();
  TextEditingController priceNotIncludeEnControl =TextEditingController();
  TextEditingController afterPayControl =TextEditingController();
  TextEditingController afterPayEnControl =TextEditingController();
  TextEditingController notesControl =TextEditingController();
  TextEditingController notesEnControl =TextEditingController();

  // Details in Arabic and English
  String detailsAr = "";
  String detailsEn = "";

  FilterModel? filterModel; // Filter model data

  List<CountryModel> selectedCountry = []; // Selected countries
  List<String> selectedCountryId = []; // Selected country IDs
  List<CityModel> selectedCites = []; // Selected cities
  List<String>? selectedCitesId; // Selected city IDs

  String countryId = ""; // Selected country ID
  List<CityModel> cites = []; // List of cities
  String startSelectedDate = ''; // Start date of the package
  String endSelectedDate = ''; // End date of the package

  String selectStatus = "normal"; // Package status
  String offerType = "individual"; // Offer type (individual/group)
  bool? switchValue = false; // VIP status switch value
  bool isLoading = false; // Loading state
  static OfferModel? offerModel; // Offer model
  bool? isVIP; // VIP status
  String isSingle = ""; // Single/couple selection
  String isInternational = ""; // International/local selection
  int? installmentAvailable; // Installment availability


  final ValueNotifier<int> priceIncludeLang = ValueNotifier<int>(0);
  final ValueNotifier<int> priceNotIncludeLang = ValueNotifier<int>(0);
  final ValueNotifier<int> afterPaymentLang = ValueNotifier<int>(0);
  final ValueNotifier<int> notesLang = ValueNotifier<int>(0);

  @override
  void initState() {
    // Initialize state
    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateTime.now());
      endSelectedDate = DateFormat('yyyy-MM-dd', "en")
          .format(DateTime.now().add(const Duration(days: 1)));
    });
    setData(); // Set data from the offer model
    getFilterDataApi(); // Fetch filter data
    super.initState();
  }

  // Handles date range selection
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(args.value.startDate);
      endSelectedDate = DateFormat('yyyy-MM-dd', "en")
          .format(args.value.endDate ?? args.value.startDate);
    });
  }

  // Opens date selection dialog
  void selectDate() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CalenderDialog(onSelectionChanged);
      },
    );
  }

  // Selects multiple images
  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

  // Compresses selected images
  Future<void> addImages() async {
    for (int i = 0; i < imageFileList.length; i++) {
      var path = File(imageFileList[i].path);
      var result = await FlutterImageCompress.compressAndGetFile(
        path.absolute.path,
        path.path + 'compressed.jpg',
        quality: 50,
      );
      setState(() {
        compressedListImages = File(result!.path);
      });
    }
    await Future.delayed(const Duration(seconds: 10));
  }

  // Fetches filter data from the API
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

  // Fetches city data based on selected countries
  Future<void> getCityDataApi() async {
    Map<String, String> mp = {};
    selectedCountryId.asMap().forEach((index, value) => mp["countries[$index]"] = value);
    final response = await dio.get("v1/citiesByCountries", queryParameters: mp);
    var rs = CitiesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        cites = rs.data!;
      });
    }
  }

  List<ImagesModel>? packageImages = []; // Package images


  // Function to parse HTML and return a readable string
  String parseHtmlToText(String htmlString) {
    // Parse the HTML string
    var document = html_parser.parse(htmlString);

    // Extract the text from <li> elements
    List<String> listItems = document
        .querySelectorAll('li')
        .map((element) => '• ${element.text}')
        .toList();

    // Join the list items with new lines or bullet points
    return listItems.join('\n'); // You can use '\n• ' for bullet points
  }



  // Sets the data from the offer model into the form fields
  Future<void> setData() async {
    setState(() {
      isLoading = true;
    });
    print("${offerModel!.priceIncludeAr} 7777777777777777777777");

    // Set the form fields from the offer model
    packageNameArControl.text = offerModel!.nameAr!;
    packageNameEnControl.text = offerModel!.nameEn!;
    detailsAr = offerModel!.descriptionAr!;
    detailsEn = offerModel!.descriptionEn!;
    selectStatus = offerModel!.type.toString();
    packagePriceControl.text = offerModel!.price_before_without_app_percent!=null?offerModel!.price_before_without_app_percent!.toString():"0";
    packageImages = offerModel!.images;
    switchValue = offerModel!.is_vip.toString() == "1" ? true : false;
    packageDiscountControl.text =offerModel!.price_after_without_app_percent!=null? offerModel!.price_after_without_app_percent!.toString():"0";
    selectedCountryId = offerModel!.countries_list!.toList();
    selectedCitesId = offerModel!.cities_list!.toList();
    countryId = offerModel!.countryId.toString();
    offerType = offerModel!.offer_type!;
    if (offerType == "group") {
      numOfPersonControl.text = offerModel!.num_of_persons.toString();
    }
    daysControl.text = offerModel!.numOfDays.toString();
    nightsControl.text = offerModel!.num_of_nights.toString();
    startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.startDate!));
    endSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.endDate!));
    isSingle = offerModel!.is_single.toString();
    isInternational = offerModel!.is_international.toString();
    installmentAvailable = offerModel!.is_installment;

    priceIncludeArControl.text= offerModel!.priceIncludeAr.toString().contains("<li>")? parseHtmlToText(offerModel!.priceIncludeAr.toString()):offerModel!.priceIncludeAr.toString();

    priceIncludeEnControl.text=offerModel!.priceIncludeEn.toString().contains("<li>")?parseHtmlToText(offerModel!.priceIncludeEn.toString()) :offerModel!.priceIncludeEn.toString()
    ;
    priceNotIncludeControl.text= offerModel!.priceExcludeAr.toString().contains("<li>")?parseHtmlToText(offerModel!.priceExcludeAr.toString()):offerModel!.priceExcludeAr.toString();
    priceNotIncludeEnControl.text=offerModel!.priceExcludeEn.toString().contains("<li>")?parseHtmlToText(offerModel!.priceExcludeEn.toString()):offerModel!.priceExcludeEn.toString();
    afterPayControl.text=offerModel!.whatAfterPayAr.toString().contains("<li>")?parseHtmlToText(offerModel!.whatAfterPayAr.toString()): offerModel!.whatAfterPayAr.toString();
    afterPayEnControl.text=offerModel!.whatAfterPayEn.toString().contains("<li>")?parseHtmlToText(offerModel!.whatAfterPayEn.toString()): offerModel!.whatAfterPayEn.toString();
    notesControl.text=offerModel!.notesAr.toString().contains("<li>")?parseHtmlToText(offerModel!.notesAr.toString()): offerModel!.notesAr.toString();
    notesEnControl.text=offerModel!.notesEn.toString().contains("<li>")?parseHtmlToText(offerModel!.notesEn.toString()): offerModel!.notesEn.toString();

    setState(() {
      isLoading = false;
    });
  }

  // Validates the form data before submitting
  Future<bool> checkData() async {
    if (packageNameArControl.text.isEmpty) {
      toastApp(tr("EnterTheDisplayNameInArabic"), context);
      return false;
    }
    if (packageNameEnControl.text.isEmpty) {
      toastApp(tr("EnterTheDisplayNameInEnglish"), context);
      return false;
    }
    if (detailsAr.isEmpty) {
      toastApp(tr("EnterTheDescriptionInArabic"), context);
      return false;
    }
    if (detailsEn.isEmpty) {
      toastApp(tr("EnterTheDescriptionInEnglish"), context);
      return false;
    }
    if (packagePriceControl.text.isEmpty) {
      toastApp(tr("EnterTheOfferPrice"), context);
      return false;
    }
    if (packageDiscountControl.text.isEmpty) {
      toastApp(tr("EnterTheOfferPriceAfterDiscount"), context);
      return false;
    }
    if (daysControl.text.isEmpty) {
      toastApp(tr("EnterTheNumberOfDays"), context);
      return false;
    }
    if (nightsControl.text.isEmpty) {
      toastApp(tr("EnterTheNumberOfNights"), context);
      return false;
    }
    if (selectedCountryId.isEmpty) {
      toastApp(tr("SelectCountries"), context);
      return false;
    }
    if (selectedCitesId!.isEmpty) {
      toastApp(tr("SelectCities"), context);
      return false;
    }

    if(priceIncludeArControl.text==""){
      toastApp(tr("EnterPriceIncludes"), context);
      return false;
    }
    if(priceIncludeEnControl.text==""){
      toastApp(tr("EnterPriceIncludesEn"), context);
      return false;
    }

    if(priceNotIncludeControl.text==""){
      toastApp(tr("EnterPriceDoesNotInclude"), context);
      return false;
    }
    if(priceNotIncludeEnControl.text==""){
      toastApp(tr("EnterPriceDoesNotIncludeEn"), context);
      return false;
    }
    if(afterPayControl.text==""){
      toastApp(tr("EnterWhatAfterPayment"), context);
      return false;
    }
    if(afterPayEnControl.text==""){
      toastApp(tr("EnterWhatAfterPaymentEn"), context);
      return false;
    }
    if(notesControl.text==""){
      toastApp(tr("EnterNotes"), context);
      return false;
    }
    if(notesEnControl.text==""){
      toastApp(tr("EnterEnNotes"), context);
      return false;
    }
    return true;
  }

  // Updates the offer with the form data
  Future<void> upDate() async {
    if (await checkData()) {
      setState(() {
        isLoading = true;
      });

      // Prepare the data for the API request
      Map<String, dynamic> mp = {
        "type": selectStatus,
        "name_ar": packageNameArControl.text,
        "name_en": packageNameEnControl.text,
        "description_ar": detailsAr,
        "description_en": detailsEn,
        "country_id": countryId,
        "is_vip": switchValue == true ? "1" : "0",
        "city_id": selectedCitesId,
        "price_after": packageDiscountControl.text,
        "price_before": packagePriceControl.text,
        "start_date": startSelectedDate,
        "end_date": endSelectedDate,
        "offer_type": offerType,
        "num_of_persons": offerType == "group" ? numOfPersonControl.text : "1",
        "num_of_days": daysControl.text,
        "num_of_nights": nightsControl.text,
        "is_single": isSingle,
        "is_international": isInternational,
        "is_installment": installmentAvailable,

      "price_include_ar":priceIncludeArControl.text,
      "price_include_en":priceIncludeEnControl.text,
      "price_exclude_ar":priceNotIncludeControl.text,
      "price_exclude_en":priceNotIncludeEnControl.text,
      "what_after_pay_ar":afterPayControl.text,
      "what_after_pay_en":afterPayEnControl.text,
      "notes_ar":notesControl.text,
      "notes_en":notesEnControl.text,

      };

      // Add selected countries and cities to the request data
      selectedCountryId.asMap().forEach((index, value) => mp["countries[$index]"] = value);
      selectedCitesId!.asMap().forEach((index, value) => mp["cities[$index]"] = value);

      // Send the update request to the API
      final response = await dio.post("v1/office/offers/${offerModel!.id}/update", data: FormData.fromMap(mp));

      var rs = EmptyResponse(response.data!);
      setState(() {
        isLoading = false;
      });

      // Handle the response
      if (rs.status == 200) {
        toastAppSuccess(rs.msg!, context);
        SamaOfficeApp.navKey.currentState!.pop(context);
      } else {
        toastApp(rs.msg!, context);
      }
    }
  }
}
