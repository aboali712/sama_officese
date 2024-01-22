import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';
import '../signup_viewmodel.dart';

class StepTwo extends StatelessWidget {
  final SignUpViewModel signUpViewModel;
  const StepTwo(this.signUpViewModel,{super.key});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),

          Text(
          tr("ChangeLogo"),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15),
          textAlign: TextAlign.center,
        ),
          const SizedBox(height: 10,),

              signUpViewModel.imageOffice == null?
              InkWell(onTap: () async {
                signUpViewModel.imageOffice =
                (await signUpViewModel.picker.pickImage(source: ImageSource.gallery)) ;
                signUpViewModel.imageSetState();
              },
                child: Container(
                            decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: const Color(0xFFf5f9f9),
                  borderRadius: BorderRadius.circular(15)),
                            width: 95,
                            height: 95,
                            child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
                            ),
                          ),
              )
                  : Stack(
                    children: [
                      const SizedBox(width: 108,height: 105,),
                      Container(height: 95,width: 95,
                      decoration:BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                          color: const Color(0xFFf5f9f9),
                          borderRadius: BorderRadius.circular(15),
                          image:

                           DecorationImage(
                              image:  FileImage(File(signUpViewModel.imageOffice!.path)),
                              fit: BoxFit.cover)
                      ) ,

                    ),

                      Positioned(
                        bottom: 0,left: 0,
                        child: InkWell(onTap: () async {
                          signUpViewModel.imageOffice =
                          (await signUpViewModel.picker.pickImage(source: ImageSource.gallery)) ;
                          signUpViewModel.imageSetState();
                        },
                          child: Container(height: 35,width: 35,
                            padding: const EdgeInsets.all(5),
                            decoration:BoxDecoration(
                                border: Border.all(color: samaColor,width: 1),
                                color: samaColor,
                                borderRadius: BorderRadius.circular(50),
                            ) ,child:  SvgPicture.asset("assets/images/pin.svg",height: 15,color: Colors.white,),

                          ),
                        ),
                      ),

                 ] ),


        const SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [

            InkWell(onTap: () {
              signUpViewModel.lanSetState(0);
              print(signUpViewModel.lan);

            },
              child: Container(height: 30,width: 30,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color: signUpViewModel.lan==0? samaOfficeColor :Colors.grey ,
                ),
                child: Text("ع",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color:signUpViewModel.lan==0? Colors.white: Colors.white,
                      fontWeight: FontWeight.w500,fontSize: 14

                  ),),),
            ),
            const SizedBox(width: 5,),


            InkWell(onTap: () {
              signUpViewModel.lanSetState(1);
              print(signUpViewModel.lan);
            },
              child: Container(height: 30,width: 30,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color:signUpViewModel.lan==1? samaOfficeColor :Colors.grey ,
                ),
                child: Text("en",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color:signUpViewModel.lan==1? Colors.white: Colors.white,
                      fontWeight: FontWeight.w500,fontSize: 14

                  ),),),
            ),


          ],),

          Text(
            tr("fullName"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
          signUpViewModel.lan==0?
          SizedBox(height: 45,
            child: TextFormField(
              controller: signUpViewModel.completeNameEnControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: (tr("FullNameInArabic")),
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
        controller: signUpViewModel.completeNameArControl,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: (tr("FullNameInEnglish")),
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

          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(onTap: () {
                signUpViewModel.lanDescriptionSetState(0);
                print(signUpViewModel.lanDescription);

              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: signUpViewModel.lanDescription==0? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("ع",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:signUpViewModel.lanDescription==0? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),
              const SizedBox(width: 5,),


              InkWell(onTap: () {
                signUpViewModel.lanDescriptionSetState(1);
                print(signUpViewModel.lanDescription);
              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color:signUpViewModel.lanDescription==1? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("en",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:signUpViewModel.lanDescription==1? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),


            ],),

          Text(
            tr("Description"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),

         signUpViewModel.lanDescription==0?
          Column( children: [

            Container(width: size.width,
              decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
              child: QuillToolbar.simple( configurations:
              QuillSimpleToolbarConfigurations(

                toolbarIconAlignment:WrapAlignment.start,
                sectionDividerSpace: 1,
                toolbarSize: 1,
                toolbarSectionSpacing: 1,
                controller: signUpViewModel.arController,

              ) ,
              ),
            ),


            Stack(
                children: [ Container(height: 150,width: size.width,
                  padding: const EdgeInsets.only(top: 15,left: 10,right: 10),

                  decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
                  child: QuillEditor(
                      scrollController: ScrollController(), // ScrollController(),

                      focusNode: signUpViewModel.focusPhone, // FocusNode(canRequestFocus: false),
                      configurations: QuillEditorConfigurations(
                        placeholder: tr("DescriptionInArabic"),


                        controller: signUpViewModel.arController,
                        readOnly: false,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      )
                  ),
                ),

                  const Divider(height: 5,thickness: 1,color: Colors.grey,)
                ])

          ],)


        :Column( children: [

          Container(width: size.width,
            decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
            child: QuillToolbar.simple( configurations:
            QuillSimpleToolbarConfigurations(

              toolbarIconAlignment:WrapAlignment.start,
              sectionDividerSpace: 1,
              toolbarSize: 1,
              toolbarSectionSpacing: 1,
              controller: signUpViewModel.enController,

            ) ,
            ),
          ),

           Stack(
                children: [ Container(height: 150,width: size.width,
                  padding: const EdgeInsets.only(top: 15,left: 10,right: 10),

                  decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
                  child: QuillEditor(
                      scrollController: ScrollController(), // ScrollController(),

                      focusNode: signUpViewModel.focusPhone, // FocusNode(canRequestFocus: false),
                      configurations: QuillEditorConfigurations(
                        placeholder: tr("DescriptionInEnglish"),
                        controller: signUpViewModel.enController,
                        readOnly: false,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      )
                  ),
                ),

                  const Divider(height: 5,thickness: 1,color: Colors.grey,)
                ]),
        ],),

          const SizedBox(height: 20,),
          
          // Text(signUpViewModel.controller.document.toPlainText().toString(),style: GoogleFonts.tajawal(color: Colors.black),)


          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(onTap: () {
                signUpViewModel.lanAddressSetState(0);
                print(signUpViewModel.lanAddress);

              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: signUpViewModel.lanAddress==0? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("ع",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:signUpViewModel.lanAddress==0? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),
              const SizedBox(width: 5,),


              InkWell(onTap: () {
                signUpViewModel.lanAddressSetState(1);
                print(signUpViewModel.lanAddress);
              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color:signUpViewModel.lanAddress==1? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("en",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:signUpViewModel.lanAddress==1? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),


            ],),

          Text(
            tr("Address"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
          signUpViewModel.lanAddress==0?
          SizedBox(height: 45,
            child: TextFormField(
              controller: signUpViewModel.addressArControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: (tr("AddressInArabic")),
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
              controller: signUpViewModel.addressEnControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: (tr("AddressInEnglish")),
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
            tr("OfficeBranch"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),

          Container(height: 45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField2(
              isExpanded: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.only(
                    bottom: 15.0, top: 10, left: 10, right: 10),
                filled: true,
                fillColor: const Color(0xFFF3F3F5),
                floatingLabelStyle: const TextStyle(color: textGrayColor),
                errorStyle: const TextStyle(color: textError),
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
                hintText: tr("OfficeBranch"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: const Color(0xffB2B3B6)),
              ),
              items: signUpViewModel.filterModel != null
                  ?  signUpViewModel.filterModel!.countries!.map((e) => e.name)
                  .toList()
                  .map(( item) => DropdownMenuItem<String>(
                value: item.toString(),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  item.toString(),
                  style: GoogleFonts.tajawal(
                      fontSize: 14, color: Colors.black),
                ),
              ))
                  .toList()
                  : [],
              value: signUpViewModel.selectedOfficeBranch!=""?  signUpViewModel.selectedOfficeBranch:null,
              onChanged: (value) {
                signUpViewModel.selectedCity="";
                signUpViewModel.selectedOfficeBranch = value.toString();
                signUpViewModel.selectedOfficeBranchID = signUpViewModel.filterModel!.countries!
                    .firstWhere(
                        (element) => element.name ==signUpViewModel.selectedOfficeBranch)
                    .id
                    .toString();
                print(signUpViewModel.selectedOfficeBranch);
                print(signUpViewModel.selectedOfficeBranchID);
                signUpViewModel.getCityDataApi();



              },

            ),
          ),




          const SizedBox(height: 20,),
          Text(
            tr("ChooseTheCity"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),

          Container(height: 45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField2(
              isExpanded: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.only(
                    bottom: 15.0, top: 10, left: 10, right: 10),
                filled: true,
                fillColor: const Color(0xFFF3F3F5),
                floatingLabelStyle: const TextStyle(color: textGrayColor),
                errorStyle: const TextStyle(color: textError),
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
                hintText: tr("City"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: const Color(0xffB2B3B6)),
              ),
              items: signUpViewModel.cites.isNotEmpty
                  ?  signUpViewModel.cites.map((e) => e.name)
                  .toList()
                  .map(( item) => DropdownMenuItem<String>(
                value: item.toString(),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  item.toString(),
                  style: GoogleFonts.tajawal(
                      fontSize: 14, color: Colors.black),
                ),
              ))
                  .toList()
                  : [],
              value: signUpViewModel.selectedCity!=""?  signUpViewModel.selectedCity:null,
              onChanged: (value) {

                signUpViewModel.citySetState(value.toString());
                signUpViewModel.selectedCityID = signUpViewModel.cites
                    .firstWhere(
                        (element) => element.name ==signUpViewModel.selectedCity)
                    .id
                    .toString();
                print(signUpViewModel.selectedCity);
                print(signUpViewModel.selectedCityID);



              },

            ),
          ),



          const SizedBox(height: 20,),
          Text(
            tr("workHours"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20,),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const SizedBox(width: 50,),

          Row(children: [
            SizedBox(width: 90,
              child: Text(

                tr("from"),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 10,),

            SizedBox(width: 90,
              child: Text(
                tr("To"),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                textAlign: TextAlign.start,
              ),
            ),

          ],)
          ],),


          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueSat,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchSatSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Saturday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


           Row(children: [

             SizedBox(height: 35,width: 90,
               child: TextField(
                 controller: signUpViewModel.timeInSatControl,
                 textAlign: TextAlign.center,
                 style: const TextStyle(fontSize: 14,color: Colors.black),
                 decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                     filled: true,
                     fillColor: Colors.white,
                     disabledBorder: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                         borderRadius: BorderRadius.circular(5)),
                     enabledBorder:OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                         borderRadius: BorderRadius.circular(5)) ,
                     border: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5)),

                     focusedErrorBorder:OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5)),
                     errorBorder: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5))

                   // icon: const Icon(Icons.alarm_add_outlined),
                   // labelText: "Enter Time"
                 ),
                 readOnly: true,

                 onTap: () async {
                   TimeOfDay? pickedTime = await showTimePicker(
                     initialTime: TimeOfDay.now(),
                     context: context,
                     builder: (BuildContext context, Widget? child) {
                       return Theme(
                           data: Theme.of(context).copyWith(
                               colorScheme: const ColorScheme.light(
                                 // primaryContainer: Colors.black,
                                 background: Colors.white,
                                 primary: samaOfficeColor,
                               )),
                           child: MediaQuery(
                             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                             child: child!,
                           ));
                     },
                   );

                   if (pickedTime != null) {
                     print(pickedTime.format(context));
                     print(pickedTime.format(context));
                     String formattedTime = '${pickedTime.hour.toString()
                         .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                     print("${formattedTime}" );

                     signUpViewModel.timeSatSetState(formattedTime);

                     print(signUpViewModel.timeInSatControl.text);




                     // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                     //   setState(() {
                     //     hourTimeControl.text=
                     //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                     //   });
                     // }

                   } else {
                     print("Time is not selected");
                   }
                 },
               ),
             ),

             const SizedBox(width: 10,),

             SizedBox(height: 35,width: 90,
               child: TextField(
                 controller: signUpViewModel.timeoutSatControl,
                 textAlign: TextAlign.center,
                 style: const TextStyle(fontSize: 14,color: Colors.black),
                 decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                     filled: true,
                     fillColor: Colors.white,
                     disabledBorder: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                         borderRadius: BorderRadius.circular(5)),
                     enabledBorder:OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                         borderRadius: BorderRadius.circular(5)) ,
                     border: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5)),

                     focusedErrorBorder:OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5)),
                     errorBorder: OutlineInputBorder(
                         borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                         borderRadius: BorderRadius.circular(5))

                   // icon: const Icon(Icons.alarm_add_outlined),
                   // labelText: "Enter Time"
                 ),
                 readOnly: true,

                 onTap: () async {
                   TimeOfDay? pickedTime = await showTimePicker(
                     initialTime: TimeOfDay.now(),
                     context: context,
                     builder: (BuildContext context, Widget? child) {
                       return Theme(
                           data: Theme.of(context).copyWith(
                               colorScheme: const ColorScheme.light(
                                 // primaryContainer: Colors.black,
                                 background: Colors.white,
                                 primary: samaOfficeColor,
                               )),
                           child: MediaQuery(
                             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                             child: child!,
                           ));
                     },
                   );

                   if (pickedTime != null) {
                     print(pickedTime.format(context));
                     print(pickedTime.format(context));
                     String formattedTime = '${pickedTime.hour.toString()
                         .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                     print("${formattedTime}" );

                     signUpViewModel.timeoutSatSetState(formattedTime);

                     print(signUpViewModel.timeoutSatControl.text);




                     // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                     //   setState(() {
                     //     hourTimeControl.text=
                     //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                     //   });
                     // }

                   } else {
                     print("Time is not selected");
                   }
                 },
               ),
             ),


           ],)

            ],
          ),


          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueSun,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchSunSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Sunday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInSunControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeSunSetState(formattedTime);

                        print(signUpViewModel.timeInSunControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutSunControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutSunSetState(formattedTime);

                        print(signUpViewModel.timeoutSunControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),


          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueMon,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchMonSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Monday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInMonControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeInMonSetState(formattedTime);

                        print(signUpViewModel.timeInMonControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutMonControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutMonSetState(formattedTime);

                        print(signUpViewModel.timeoutMonControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),


          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueTus,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchTusSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Tuesday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInTusControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeInTusSetState(formattedTime);

                        print(signUpViewModel.timeInTusControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutTusControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutTusSetState(formattedTime);

                        print(signUpViewModel.timeoutTusControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),


          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueWed,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchWedSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Wednesday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInWedControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeInWedSetState(formattedTime);

                        print(signUpViewModel.timeInWedControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutWedControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutWedSetState(formattedTime);

                        print(signUpViewModel.timeoutWedControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),



          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueThur,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchThurSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Thursday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInThurControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeInThurSetState(formattedTime);

                        print(signUpViewModel.timeInThurControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutThurControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutThurSetState(formattedTime);

                        print(signUpViewModel.timeoutThurControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),



          const SizedBox(height: 15,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                FlutterSwitch(
                  inactiveColor: Colors.grey.shade300,
                  activeColor: AppColors.green,
                  width: 60,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 25.0,
                  value: signUpViewModel.switchValueFri,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    signUpViewModel.switchFriSetState(val);
                    print(val);
                  },
                ),
                const SizedBox(width: 10,),

                Text(
                  tr("Friday"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],),


              Row(children: [

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeInFriControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeInFriSetState(formattedTime);

                        print(signUpViewModel.timeInFriControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                SizedBox(height: 35,width: 90,
                  child: TextField(
                    controller: signUpViewModel.timeoutFriControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(5)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(5))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // primaryContainer: Colors.black,
                                    background: Colors.white,
                                    primary: samaOfficeColor,
                                  )),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ));
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString()
                            .padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        signUpViewModel.timeoutFriSetState(formattedTime);

                        print(signUpViewModel.timeoutFriControl.text);




                        // if(signUpViewModel.timeInControl.text!=""|| signUpViewModel.timeOutControl.text!=""){
                        //   setState(() {
                        //     hourTimeControl.text=
                        //     "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                        //   });
                        // }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),


              ],)

            ],
          ),



          const SizedBox(height: 80,),


      ],),
    );
  }
}
