import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_viewModel.dart';

import '../../../../auth/register/all_filter/country_model.dart';
import '../../../../core/utils/input_validators.dart';
import '../../../../core/values/colors.dart';

class UpDateView extends StatefulWidget {
  const UpDateView({Key? key}) : super(key: key);

  @override
  State<UpDateView> createState() => _UpDateViewState();
}

class _UpDateViewState extends UpDateViewModel {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [

                InkWell( onTap: () {
                  Navigator.pop(context);
                }
                    ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                Text(
                  tr("EditThePackage"),
                  style: const TextStyle(
                      color:  Colors.white,
                      fontSize: 21, fontWeight: FontWeight.w500),
                ),

              ],),





            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [
              Container(height: 30,color: const Color(0xff231f20),),
              Image(
                image: const AssetImage('assets/images/create.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),

                              InkWell(onTap: () {
                                selectImages();
                                setState(() {});
                              },
                                child: Container(
                                  height: 165,width: size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(20) ,
                                    color: const Color(0xff00A8A5),

                                  ),
                                  child: DottedBorder(
                                    padding: const EdgeInsets.all(0),
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(20),
                                    dashPattern: const [5, 5],
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                    child: Center(
                                      child:  Column(
                                          children: [

                                            const SizedBox(height: 15,),
                                            SvgPicture.asset("assets/images/upload.svg") ,
                                            const SizedBox(height: 10,),

                                            Text(
                                              tr("UploadThePackageImage"),
                                              style: const TextStyle(
                                                  color:  Colors.white,
                                                  fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              textAlign: TextAlign.center,
                                              tr("UploadUpTo6Photos,MakeTheFirstPhotoStandOutAsThisWillBeTheMainPhoto"),
                                              style: const TextStyle(
                                                  color:  Colors.white,
                                                  fontSize: 13, fontWeight: FontWeight.w400),
                                            ),


                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              packageImages!.isNotEmpty || imageFileList.isNotEmpty?
                              SizedBox(height: 100,
                                child: imageFileList.isNotEmpty?
                                ListView.builder(
                                  scrollDirection:  Axis.horizontal,
                                  itemCount: imageFileList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(width: 85,height: 85,
                                      child: Column(
                                        children: [
                                          Stack(
                                              children: [




                                                Container(
                                                  height: 70,width: 70,
                                                  margin: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(color: Colors.grey.shade300),
                                          image: DecorationImage(image: FileImage(File(imageFileList![index].path,) ),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                ),

                                                Positioned(right: -3,top: -3,
                                                  child: InkWell(onTap: () {
                                                    setState(() {
                                                      imageFileList!.removeAt(index);
                                                    });
                                                  },
                                                    child: Card(elevation: 10,shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(50)
                                                    ),
                                                      child: Container(height: 20,width: 20,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                                            color: Colors.white70),
                                                        child: const Icon(Icons.close,color: Colors.grey,size: 15,),
                                                      ),
                                                    ),
                                                  ),
                                                ),



                                              ]),
                                          index==0?
                                          Text(
                                            tr("MainImage"),
                                            style: const TextStyle(
                                                color:  Colors.black,
                                                fontSize: 10, fontWeight: FontWeight.w500),
                                          ):const SizedBox.shrink(),

                                        ],
                                      ),
                                    );
                                  },
                                )
                              :  ListView.builder(
                                  scrollDirection:  Axis.horizontal,
                                  itemCount: packageImages!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(width: 85,height: 85,
                                      child: Column(
                                        children: [
                                          Stack(
                                              children: [




                                                Container(
                                                  height: 70,width: 70,
                                                  margin: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(color: Colors.grey.shade300),
                                                image: DecorationImage(image: NetworkImage( packageImages![index].image!,),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                ),

                                                Positioned(right: -3,top: -3,
                                                  child: InkWell(onTap: () {
                                                    setState(() {
                                                      packageImages!.removeAt(index);
                                                    });
                                                  },
                                                    child: Card(elevation: 10,shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(50)
                                                    ),
                                                      child: Container(height: 20,width: 20,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                                            color: Colors.white70),
                                                        child: const Icon(Icons.close,color: Colors.grey,size: 15,),
                                                      ),
                                                    ),
                                                  ),
                                                ),



                                              ]),
                                          index==0?
                                          Text(
                                            tr("MainImage"),
                                            style: const TextStyle(
                                                color:  Colors.black,
                                                fontSize: 10, fontWeight: FontWeight.w500),
                                          ):const SizedBox.shrink(),

                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                                  :const SizedBox.shrink(),


                              const SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(onTap: () {
                                    setState(() {
                                      lan=0;
                                    });

                                  },
                                    child: Container(height: 30,width: 30,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                        color: lan==0? samaOfficeColor :Colors.grey ,
                                      ),
                                      child: Text("ع",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.tajawal(color:lan==0? Colors.white: Colors.white,
                                            fontWeight: FontWeight.w500,fontSize: 14

                                        ),),),
                                  ),
                                  const SizedBox(width: 5,),


                                  InkWell(onTap: () {
                                    setState(() {
                                      lan=1;
                                    });
                                  },
                                    child: Container(height: 30,width: 30,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                        color:lan==1? samaOfficeColor :Colors.grey ,
                                      ),
                                      child: Text("en",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.tajawal(color:lan==1? Colors.white: Colors.white,
                                            fontWeight: FontWeight.w500,fontSize: 14

                                        ),),),
                                  ),


                                ],),

                              Text(
                                tr("PackageName"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              lan==0?
                              SizedBox(height: 45,
                                child: TextFormField(
                                  controller: packageNameArControl,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: (tr("TheNameOfThePackageInArabic")),
                                    hintStyle: GoogleFonts.tajawal(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(196, 196, 196, 1)),

                                    errorStyle: const TextStyle(color: accentColor),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17.0, horizontal: 10.0),

                                    filled: true,
                                    fillColor: const Color(0xFFF3F3F5),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(width: 1, color: klightGray),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(width: .7, color: klightGray),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                        width: .7,
                                        color: klightGray,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                          width: 1,
                                        )),
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide:
                                        BorderSide(width: 0.7, color: accentColor)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide:
                                        BorderSide(width: 0.7, color: accentColor)),
                                  ),
                                  onChanged: (value) {
                                    if (value.isEmpty ||
                                        value == null ||
                                        !InputValidators()
                                            .nameValidator(name: value, context: context)) {

                                    } else {

                                    }
                                  },
                                  onSaved: (value) {

                                  },

                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                ),
                              )
                                  : SizedBox(height: 45,
                                child: TextFormField(
                                  controller: packageNameEnControl,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: (tr("PackageNameInEnglish")),
                                    hintStyle: GoogleFonts.tajawal(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(196, 196, 196, 1)),

                                    errorStyle: const TextStyle(color: accentColor),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17.0, horizontal: 10.0),

                                    filled: true,
                                    fillColor: const Color(0xFFF3F3F5),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(width: 1, color: klightGray),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(width: .7, color: klightGray),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                        width: .7,
                                        color: klightGray,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                          width: 1,
                                        )),
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide:
                                        BorderSide(width: 0.7, color: accentColor)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide:
                                        BorderSide(width: 0.7, color: accentColor)),
                                  ),
                                  onChanged: (value) {
                                    if (value.isEmpty ||
                                        value == null ||
                                        !InputValidators()
                                            .nameValidator(name: value, context: context)) {

                                    } else {

                                    }
                                  },
                                  onSaved: (value) {

                                  },

                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                ),
                              ),

                              const SizedBox(height: 20,),


                              Text(
                                tr("PackageDetailsInArabic"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),


                              Container(
                                height: 160,width: size.width,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFF3F3F5)),
                                child: HtmlEditor(
                                  controller: controllerDetailsAr, //required
                                  callbacks: Callbacks(
                                      onInit: () {
                                        controllerDetailsAr.editorController!.evaluateJavascript(
                                            source: "\$('div.note-editable').attr('dir', 'rtl');");
                                      },
                                      onChangeContent: (String? changed) {
                                        setState(() {
                                          detailsAr = changed!;
                                        });
                                        print(detailsAr);
                                      }),
                                  htmlEditorOptions: HtmlEditorOptions(
                                      hint: tr("DescriptionInArabic") ,
                                      initialText: detailsAr
                                    //initalText: "text content initial, if any",
                                  ),
                                  htmlToolbarOptions: const HtmlToolbarOptions(

                                      toolbarPosition: ToolbarPosition.aboveEditor, //by default
                                      toolbarType: ToolbarType.nativeScrollable),
                                  otherOptions:  OtherOptions(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5) ),
                                    height: 400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),

                              Text(
                                tr("PackageDetailsInEnglish"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),

                              Container(
                                height: 160,width: size.width,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFF3F3F5)),
                                child: HtmlEditor(
                                  controller: controllerDetailsEn, //required
                                  callbacks: Callbacks(
                                      onInit: () {
                                        controllerDetailsEn.editorController!.evaluateJavascript(
                                            source: "\$('div.note-editable').attr('dir', 'rtl');");
                                      },
                                      onChangeContent: (String? changed) {
                                        setState(() {
                                          detailsEn = changed!;
                                        });
                                        print(detailsEn);
                                      }),
                                  htmlEditorOptions: HtmlEditorOptions(
                                      hint: tr("DescriptionInEnglish"),
                                      initialText: detailsEn
                                    //initalText: "text content initial, if any",
                                  ),
                                  htmlToolbarOptions: const HtmlToolbarOptions(

                                      toolbarPosition: ToolbarPosition.aboveEditor, //by default
                                      toolbarType: ToolbarType.nativeScrollable),
                                  otherOptions:  OtherOptions(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5) ),
                                    height: 400,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: size.width/2-25,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr("PackagePrice"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 45,
                                          child: TextFormField(
                                            controller: packagePriceControl,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            style: const TextStyle(fontSize: 15),
                                            decoration: InputDecoration(
                                              hintText: (tr("PackagePrice")),
                                              hintStyle: GoogleFonts.tajawal(
                                                  fontSize: 12,
                                                  color: const Color.fromRGBO(196, 196, 196, 1)),

                                              errorStyle: const TextStyle(color: accentColor),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),

                                              filled: true,
                                              fillColor: const Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: 1, color: klightGray),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: .7, color: klightGray),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(
                                                  width: .7,
                                                  color: klightGray,
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                  )),
                                              errorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                              focusedErrorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                            ),
                                            onChanged: (value) {
                                              if (value.isEmpty ||
                                                  value == null ||
                                                  !InputValidators()
                                                      .nameValidator(name: value, context: context)) {

                                              } else {

                                              }
                                            },
                                            onSaved: (value) {

                                            },

                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],),
                                  ),
                                  SizedBox(width:size.width/2-25,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr("PackagePriceAfterDiscount"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 45,
                                          child: TextFormField(
                                            controller: packageDiscountControl,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            style: const TextStyle(fontSize: 15),
                                            decoration: InputDecoration(
                                              hintText: (tr("PackagePriceAfterDiscount")),
                                              hintStyle: GoogleFonts.tajawal(
                                                  fontSize: 12,
                                                  color: const Color.fromRGBO(196, 196, 196, 1)),

                                              errorStyle: const TextStyle(color: accentColor),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),

                                              filled: true,
                                              fillColor: const Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: 1, color: klightGray),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: .7, color: klightGray),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(
                                                  width: .7,
                                                  color: klightGray,
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                  )),
                                              errorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                              focusedErrorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                            ),
                                            onChanged: (value) {
                                              if (value.isEmpty ||
                                                  value == null ||
                                                  !InputValidators()
                                                      .nameValidator(name: value, context: context)) {

                                              } else {

                                              }
                                            },
                                            onSaved: (value) {

                                            },

                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],),
                                  )
                                ],),

                              const SizedBox(height: 20,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: size.width/2-25,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr("NumberOfDays"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 45,
                                          child: TextFormField(
                                            controller: daysControl,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            style: const TextStyle(fontSize: 15),
                                            decoration: InputDecoration(
                                              hintText: (tr("NumberOfDays")),
                                              hintStyle: GoogleFonts.tajawal(
                                                  fontSize: 12,
                                                  color: const Color.fromRGBO(196, 196, 196, 1)),

                                              errorStyle: const TextStyle(color: accentColor),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),

                                              filled: true,
                                              fillColor: const Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: 1, color: klightGray),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: .7, color: klightGray),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(
                                                  width: .7,
                                                  color: klightGray,
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                  )),
                                              errorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                              focusedErrorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                            ),
                                            onChanged: (value) {
                                              if (value.isEmpty ||
                                                  value == null ||
                                                  !InputValidators()
                                                      .nameValidator(name: value, context: context)) {

                                              } else {

                                              }
                                            },
                                            onSaved: (value) {

                                            },

                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],),
                                  ),
                                  SizedBox(width:size.width/2-25,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr("NumberOfNights"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 45,
                                          child: TextFormField(
                                            controller: nightsControl,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            style: const TextStyle(fontSize: 15),
                                            decoration: InputDecoration(
                                              hintText: (tr("NumberOfNights")),
                                              hintStyle: GoogleFonts.tajawal(
                                                  fontSize: 12,
                                                  color: const Color.fromRGBO(196, 196, 196, 1)),

                                              errorStyle: const TextStyle(color: accentColor),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),

                                              filled: true,
                                              fillColor: const Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: 1, color: klightGray),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(width: .7, color: klightGray),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5)),
                                                borderSide: BorderSide(
                                                  width: .7,
                                                  color: klightGray,
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                  )),
                                              errorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                              focusedErrorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderSide:
                                                  BorderSide(width: 0.7, color: accentColor)),
                                            ),
                                            onChanged: (value) {
                                              if (value.isEmpty ||
                                                  value == null ||
                                                  !InputValidators()
                                                      .nameValidator(name: value, context: context)) {

                                              } else {

                                              }
                                            },
                                            onSaved: (value) {

                                            },

                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],),
                                  )
                                ],),
                              const SizedBox(height: 20,),

                              Text(
                                tr("SelectCountries"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),

                              MultiSelectDialogField<CountryModel>(
                                items:filterModel!=null?

                                filterModel!.countries!.map((e) => MultiSelectItem(e, e.name!,)).toList()
                                    : []   ,
                                title: Text(tr("Countries"),style: GoogleFonts.tajawal(fontSize: 16,
                                    fontWeight: FontWeight.w500),),
                                selectedColor: const Color(0xFF28B0A9),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3F3F5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                                buttonText:  Text(
                                    tr("SelectCountries"),
                                    style:GoogleFonts.tajawal(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(196, 196, 196, 1))),
                                backgroundColor: Colors.white,
                                cancelText: Text(tr("Back"),style: GoogleFonts.tajawal(fontSize: 15,
                                    fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9) ),),
                                confirmText: Text(tr("Accept"),style: GoogleFonts.tajawal(fontSize: 15,
                                    fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9))),
                                searchable: true,
                                searchHint: tr("SearchForACountry"),
                                searchHintStyle: GoogleFonts.tajawal(fontSize: 15
                                    ,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9)),

                                selectedItemsTextStyle:  GoogleFonts.tajawal(fontSize: 15
                                    ,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9)),
                                dialogHeight: 500,
                                itemsTextStyle: GoogleFonts.tajawal(fontSize: 15,fontWeight: FontWeight.w500),

                                listType: MultiSelectListType.LIST,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedCountryId=[];
                                  });
                                  selectedCountry =  values;
                                  selectedCountryId=selectedCountry.map((e) => e.id.toString()).toList();
                                  print(selectedCountryId);
                                  getCityDataApi();
                                },
                                onSelectionChanged: (p0) {
                                  getCityDataApi();
                                },



                              ) ,
                              const SizedBox(height: 20,),
                              Text(
                                tr("SelectCities"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),

                              MultiSelectDialogField(
                                items:cites.map((e) => MultiSelectItem(e, e.name!,)).toList(),
                                title: Text(tr("cities"),style: GoogleFonts.tajawal(fontSize: 16,fontWeight: FontWeight.w500),),
                                selectedColor: const Color(0xFF28B0A9),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3F3F5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                                buttonText:  Text(
                                    tr("SelectCities"),
                                    style:GoogleFonts.tajawal(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(196, 196, 196, 1))),
                                backgroundColor: Colors.white,
                                // barrierColor: Colors.green,
                                // checkColor: Colors.green,
                                cancelText: Text(tr("Back"),style: GoogleFonts.tajawal(
                                    fontSize: 15,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9) ),),
                                confirmText: Text(tr("Accept"),style: GoogleFonts.tajawal(
                                    fontSize: 15,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9))),
                                searchable: true,
                                searchHint: tr("SearchForACity"),
                                searchHintStyle: GoogleFonts.tajawal(fontSize: 15
                                    ,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9)),
                                itemsTextStyle: GoogleFonts.tajawal(fontSize: 15,fontWeight: FontWeight.w500),
                                selectedItemsTextStyle:  GoogleFonts.tajawal(fontSize: 15
                                    ,fontWeight: FontWeight.w500,color:const Color(0xFF28B0A9)),
                                dialogHeight: 500,

                                listType: MultiSelectListType.LIST,
                                onConfirm: (values) {
                                  selectedCites = values;
                                  selectedCitesId=selectedCites.map((e) => e.id.toString()).toList();
                                  print(selectedCitesId);
                                },



                              ),



                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                tr('ChooseDate'),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              Center(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          const Color(0xFFF3F3F5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                          // side: const BorderSide(
                                          //   color: samaColor,
                                          //   width: 1.0,
                                          // ),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      startSelectedDate != ""
                                          ? "$startSelectedDate - $endSelectedDate"
                                          : tr('chooseDate'),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    onPressed: () {
                                      selectDate();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("ChooseTheTypeOfPackage"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),



                                  Row(children: [

                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                                          fixedSize:  const Size(100, 45),
                                          shape: RoundedRectangleBorder(

                                              side:  BorderSide(
                                                  color:selectStatus=="normal" ?const Color(0xff00A8A5)
                                                      :Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          backgroundColor: selectStatus=="normal" ?const Color(0xff00A8A5)
                                              :Colors.white70),
                                      onPressed: () {
                                        setState(() {
                                          selectStatus="normal";
                                        });

                                      },
                                      child: Text(
                                        tr('Normal'),
                                        style:  TextStyle(
                                            fontSize: 14,
                                            color: selectStatus=="normal"?Colors.white :Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),

                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                                          fixedSize:  const Size(100, 45),
                                          shape: RoundedRectangleBorder(

                                              side:  BorderSide(
                                                  color: selectStatus=="weekend" ?const Color(0xff00A8A5)
                                                      :Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          backgroundColor: selectStatus=="weekend" ?const Color(0xff00A8A5)
                                              :Colors.white70),
                                      onPressed: () {
                                        setState(() {
                                          selectStatus="weekend";
                                        });

                                      },
                                      child: Text(
                                        tr('Weekend'),
                                        style:  TextStyle(
                                            fontSize: 14,
                                            color:selectStatus=="weekend"?Colors.white :Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )

                                  ],)


                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("ChooseTheDisplayType"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),

                                  Row(children: [

                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                                          fixedSize:  const Size(100, 45),
                                          shape: RoundedRectangleBorder(

                                              side:  BorderSide(
                                                  color:offerType=="individual" ?const Color(0xff00A8A5)
                                                      :Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          backgroundColor: offerType=="individual" ?const Color(0xff00A8A5)
                                              :Colors.white70),
                                      onPressed: () {
                                        setState(() {
                                          offerType="individual";
                                        });

                                      },
                                      child: Text(
                                        tr('individual'),
                                        style:  TextStyle(
                                            fontSize: 14,
                                            color: offerType=="individual"?Colors.white :Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),

                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                                          fixedSize:  const Size(100, 45),
                                          shape: RoundedRectangleBorder(

                                              side:  BorderSide(
                                                  color: offerType=="group" ?const Color(0xff00A8A5)
                                                      :Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          backgroundColor: offerType=="group" ?const Color(0xff00A8A5)
                                              :Colors.white70),
                                      onPressed: () {
                                        setState(() {
                                          offerType="group";
                                        });

                                      },
                                      child: Text(
                                        tr('group'),
                                        style:  TextStyle(
                                            fontSize: 14,
                                            color:offerType=="group"?Colors.white :Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )

                                  ],),


                                ],
                              ),

                              const SizedBox(height: 20,),
                              offerType=="group"?
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("EnterTheNumberOfGroup"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),


                                  SizedBox(width: size.width/2-25,
                                    child: SizedBox(height: 45,
                                      child: TextFormField(
                                        controller: numOfPersonControl,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        style: const TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: (tr("EnterTheNumberOfGroup")),
                                          hintStyle: GoogleFonts.tajawal(
                                              fontSize: 12,
                                              color: const Color.fromRGBO(196, 196, 196, 1)),

                                          errorStyle: const TextStyle(color: accentColor),
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),

                                          filled: true,
                                          fillColor: const Color(0xFFF3F3F5),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(5)),
                                            borderSide: BorderSide(width: 1, color: klightGray),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(5)),
                                            borderSide: BorderSide(width: .7, color: klightGray),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(5)),
                                            borderSide: BorderSide(
                                              width: .7,
                                              color: klightGray,
                                            ),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              borderSide: BorderSide(
                                                width: 1,
                                              )),
                                          errorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              borderSide:
                                              BorderSide(width: 0.7, color: accentColor)),
                                          focusedErrorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              borderSide:
                                              BorderSide(width: 0.7, color: accentColor)),
                                        ),
                                        onChanged: (value) {
                                          if (value.isEmpty ||
                                              value == null ||
                                              !InputValidators()
                                                  .nameValidator(name: value, context: context)) {

                                          } else {

                                          }
                                        },
                                        onSaved: (value) {

                                        },

                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),

                                ],)
                                  :const SizedBox.shrink(),

                              const SizedBox(
                                height: 30,
                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    tr("PackageISVip"),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),

                                  FlutterSwitch(
                                    inactiveColor: Colors.grey.shade300,
                                    activeColor: const Color(0xff7DC11F),
                                    width: 55,
                                    height: 25.0,
                                    valueFontSize: 25.0,
                                    toggleSize: 25.0,
                                    value: switchValue!,
                                    borderRadius: 30.0,
                                    padding: 3.0,
                                    showOnOff: false,
                                    onToggle: (val) {
                                      setState(() {
                                        switchValue=val;
                                      });
                                      print(val);
                                    },
                                  ),

                                ],
                              ),
                              const SizedBox(height: 120,),


                            ]),
                      ),
                    ),
                  ),
                  ]),
            ),

            isLoading==true?
            SizedBox(
                height: size.height/1,
                child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
                )))
                :const SizedBox.shrink(),



            Positioned(bottom: -5,left: -5,right: -5,
              child: Card( elevation: 20,color: Colors.white,shape: const RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(25)
                      ,topRight:Radius.circular(25) )),
                child: Container(height: 110,width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25)
                          ,topRight:Radius.circular(25) )),

                  child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                          fixedSize:  Size(size.width-20, 50),
                          shape: RoundedRectangleBorder(

                              side: const BorderSide(
                                  color: Color(0xffEA8024)),
                              borderRadius:
                              BorderRadius.circular(15)),
                          backgroundColor: const Color(0xffEA8024)),
                      onPressed: () {

                        upDate();
                      },
                      child: Text(
                        tr("EditThePackage"),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            )




          ] ),


    );
  }
}
