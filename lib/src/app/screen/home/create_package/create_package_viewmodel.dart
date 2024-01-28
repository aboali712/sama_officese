import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../auth/register/all_filter/cities_model.dart';
import '../../../auth/register/all_filter/city_response.dart';
import '../../../auth/register/all_filter/country_model.dart';
import '../../../auth/register/all_filter/filter_model.dart';
import '../../../auth/register/all_filter/filter_response.dart';
import '../../../core/network/network_service.dart';
import '../../../core/widgets/calender_dialog.dart';
import 'create_package_view.dart';

abstract class CreatePackageViewModel extends  State<CreatePackageView>{
  final Dio dio = NetworkService.instance.dio;

  final ImagePicker imagePicker = ImagePicker();
  File? mainImage;
  List<XFile>? imageFileList = [];
  File? compressedListImages;
  int lan=0;
  int description=0;
  TextEditingController packageNameArControl =TextEditingController();
  TextEditingController packageNameEnControl =TextEditingController();
  TextEditingController packagePriceControl =TextEditingController();
  TextEditingController packageDiscountControl =TextEditingController();
  TextEditingController daysControl =TextEditingController();
  TextEditingController nightsControl =TextEditingController();
  HtmlEditorController controllerDetailsAr = HtmlEditorController();
  HtmlEditorController controllerDetailsEn = HtmlEditorController();

  String detailsAr="";
  String detailsEn="";

  FilterModel? filterModel;

  List<CountryModel> selectedCountry =[];
  List<String> selectedCountryId =[];
  List<CityModel> selectedCites =[];
  List<String> selectedCitesId =[];

  String countryId="";
  List<CityModel> cites =[];
  String startSelectedDate = '';
  String endSelectedDate = '';

  String selectStatus="normal";
  String offerType="individual";
  bool switchValue= false;

  @override
  void initState() {
    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(DateTime.now());

      endSelectedDate = DateFormat('yyyy-MM-dd',"en")
          .format(DateTime.now().add(const Duration(days: 1)));
    });
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

      // AddBuildingViewModel.addUnitData["image[$i]"] =
      // await MultipartFile.fromFile(compressedListImages!.path,
      //     filename: compressedListImages!.path.split('/').last);
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



}