import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';

import '../../../../core/utils/input_validators.dart';
import '../../../../core/values/colors.dart';
import '../update_profile_viewmodel.dart';



class StepTwoProfile extends StatelessWidget {
  final UpDateProfileViewModel upDateProfileViewModel;
  const StepTwoProfile(this.upDateProfileViewModel,{super.key});


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

         Stack(
                    children: [
                      const SizedBox(width: 108,height: 105,),
                      Container(height: 95,width: 95,
                      decoration:BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                          color: const Color(0xFFf5f9f9),
                          borderRadius: BorderRadius.circular(15),
                          image:
                              upDateProfileViewModel.imageOffice!=null?
                           DecorationImage(
                              image:
                                FileImage(File(upDateProfileViewModel.imageOffice!.path)),
                              fit: BoxFit.cover)
                                  : DecorationImage(
                                  image:
                                      HomeViewModel.profileModel!.office==null?
                                      const NetworkImage("https://samaapp.com/storage/default.png")
                                 : NetworkImage(
                                    HomeViewModel.profileModel!.office!.image?? "",
                                  ),
                                  fit: BoxFit.cover)

                      ) ,

                    ),

                      Positioned(
                        bottom: 0,left: 0,
                        child: InkWell(onTap: () async {
                          upDateProfileViewModel.imageOffice =
                          (await upDateProfileViewModel.picker.pickImage(source: ImageSource.gallery)) ;
                          upDateProfileViewModel.imageSetState();
                        },
                          child: Container(height: 35,width: 35,
                            padding: const EdgeInsets.all(5),
                            decoration:BoxDecoration(
                                border: Border.all(color: samaColor,width: 1),
                                color: samaColor,
                                borderRadius: BorderRadius.circular(50),
                            ) ,child:  SvgPicture.asset("assets/images/pin.svg",
                              height: 15,color: Colors.white,),

                          ),
                        ),
                      ),

                 ] ),


        const SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [

            InkWell(onTap: () {
              upDateProfileViewModel.lanSetState(0);
              print(upDateProfileViewModel.lan);

            },
              child: Container(height: 30,width: 30,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color: upDateProfileViewModel.lan==0? samaOfficeColor :Colors.grey ,
                ),
                child: Text("ع",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color:upDateProfileViewModel.lan==0? Colors.white: Colors.white,
                      fontWeight: FontWeight.w500,fontSize: 14

                  ),),),
            ),
            const SizedBox(width: 5,),


            InkWell(onTap: () {
              upDateProfileViewModel.lanSetState(1);
              print(upDateProfileViewModel.lan);
            },
              child: Container(height: 30,width: 30,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color:upDateProfileViewModel.lan==1? samaOfficeColor :Colors.grey ,
                ),
                child: Text("en",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color:upDateProfileViewModel.lan==1? Colors.white: Colors.white,
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
          upDateProfileViewModel.lan==0?
          SizedBox(height: 45,
            child: TextFormField(
              controller: upDateProfileViewModel.completeNameArControl,
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
        controller: upDateProfileViewModel.completeNameArControl,
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
                upDateProfileViewModel.lanDescriptionSetState(0);
                print(upDateProfileViewModel.lanDescription);

              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: upDateProfileViewModel.lanDescription==0? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("ع",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:upDateProfileViewModel.lanDescription==0? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),
              const SizedBox(width: 5,),


              InkWell(onTap: () {
                upDateProfileViewModel.lanDescriptionSetState(1);
                print(upDateProfileViewModel.lanDescription);
              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color:upDateProfileViewModel.lanDescription==1? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("en",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:upDateProfileViewModel.lanDescription==1? Colors.white: Colors.white,
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
              controller: upDateProfileViewModel.controllerDetailsAr, //required
              callbacks: Callbacks(
                  onInit: () {
                    upDateProfileViewModel.controllerDetailsAr.editorController!.evaluateJavascript(
                        source: "\$('div.note-editable').attr('dir', 'rtl');");
                  },
                  onChangeContent: (String? changed) {
                    upDateProfileViewModel.descArSetState(changed!);

                    print(upDateProfileViewModel.detailsAr);
                  }),
              htmlEditorOptions: HtmlEditorOptions(
                  hint: tr("DescriptionInArabic") ,
                  initialText: upDateProfileViewModel.detailsAr
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
              controller: upDateProfileViewModel.controllerDetailsEn, //required
              callbacks: Callbacks(
                  onInit: () {
                    upDateProfileViewModel.controllerDetailsEn.editorController!.evaluateJavascript(
                        source: "\$('div.note-editable').attr('dir', 'rtl');");
                  },
                  onChangeContent: (String? changed) {
                    upDateProfileViewModel.descEnSetState(changed!);

                    print(upDateProfileViewModel.detailsEn);
                  }),
              htmlEditorOptions: HtmlEditorOptions(
                  hint: tr("DescriptionInEnglish"),
                  initialText: upDateProfileViewModel.detailsEn
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



        //  upDateProfileViewModel.lanDescription==0?
        //   Column( children: [
        //
        //     Container(width: size.width,
        //       decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
        //       child: QuillToolbar.simple( configurations:
        //       QuillSimpleToolbarConfigurations(
        //
        //         toolbarIconAlignment:WrapAlignment.start,
        //         sectionDividerSpace: 1,
        //         toolbarSize: 1,
        //         toolbarSectionSpacing: 1,
        //         controller: upDateProfileViewModel.arController,
        //
        //       ) ,
        //       ),
        //     ),
        //
        //
        //     Stack(
        //         children: [ Container(height: 150,width: size.width,
        //           padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
        //
        //           decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
        //           child: QuillEditor(
        //               scrollController: ScrollController(), // ScrollController(),
        //
        //               focusNode: upDateProfileViewModel.focusPhone, // FocusNode(canRequestFocus: false),
        //               configurations: QuillEditorConfigurations(
        //                 placeholder: tr("DescriptionInArabic"),
        //
        //
        //                 controller: upDateProfileViewModel.arController,
        //                 readOnly: false,
        //                 sharedConfigurations: const QuillSharedConfigurations(
        //                   locale: Locale('de'),
        //                 ),
        //               )
        //           ),
        //         ),
        //
        //           const Divider(height: 5,thickness: 1,color: Colors.grey,)
        //         ])
        //
        //   ],)
        // :Column( children: [
        //
        //   Container(width: size.width,
        //     decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
        //     child: QuillToolbar.simple( configurations:
        //     QuillSimpleToolbarConfigurations(
        //
        //       toolbarIconAlignment:WrapAlignment.start,
        //       sectionDividerSpace: 1,
        //       toolbarSize: 1,
        //       toolbarSectionSpacing: 1,
        //       controller: upDateProfileViewModel.enController,
        //
        //     ) ,
        //     ),
        //   ),
        //
        //    Stack(
        //         children: [ Container(height: 150,width: size.width,
        //           padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
        //
        //           decoration: BoxDecoration(color: const Color(0xFFF3F3F5),borderRadius: BorderRadius.circular(5)),
        //           child: QuillEditor(
        //               scrollController: ScrollController(), // ScrollController(),
        //
        //               focusNode: upDateProfileViewModel.focusPhone, // FocusNode(canRequestFocus: false),
        //               configurations: QuillEditorConfigurations(
        //                 placeholder: tr("DescriptionInEnglish"),
        //                 controller: upDateProfileViewModel.enController,
        //                 readOnly: false,
        //                 sharedConfigurations: const QuillSharedConfigurations(
        //                   locale: Locale('de'),
        //                 ),
        //               )
        //           ),
        //         ),
        //
        //           const Divider(height: 5,thickness: 1,color: Colors.grey,)
        //         ]),
        // ],),

          const SizedBox(height: 20,),


          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(onTap: () {
                upDateProfileViewModel.lanAddressSetState(0);
                print(upDateProfileViewModel.lanAddress);

              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: upDateProfileViewModel.lanAddress==0? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("ع",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:upDateProfileViewModel.lanAddress==0? Colors.white: Colors.white,
                        fontWeight: FontWeight.w500,fontSize: 14

                    ),),),
              ),
              const SizedBox(width: 5,),


              InkWell(onTap: () {
                upDateProfileViewModel.lanAddressSetState(1);
                print(upDateProfileViewModel.lanAddress);
              },
                child: Container(height: 30,width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color:upDateProfileViewModel.lanAddress==1? samaOfficeColor :Colors.grey ,
                  ),
                  child: Text("en",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:upDateProfileViewModel.lanAddress==1? Colors.white: Colors.white,
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
          upDateProfileViewModel.lanAddress==0?
          SizedBox(height: 45,
            child: TextFormField(
              controller: upDateProfileViewModel.addressArControl,
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
              controller: upDateProfileViewModel.addressEnControl,
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

          const SizedBox(
            height: 20,
          ),

          Text(tr("ChooseAddressFrom"),
              style: GoogleFonts.tajawal()),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              upDateProfileViewModel.showPlacePicker();
            },
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F5),
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: const EdgeInsets.all(10),
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width,
                child: Text(upDateProfileViewModel.result!=null ?
                upDateProfileViewModel.result!.formattedAddress! : tr("ChooseAddressFrom"),
                    style: GoogleFonts.tajawal(fontSize: 12))),
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
                hintText: HomeViewModel.profileModel!.office!=null? HomeViewModel.profileModel!.office!.country_name : "",
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

                hintStyle: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: const Color(0xffB2B3B6)),
              ),
              items: upDateProfileViewModel.filterModel != null
                  ?  upDateProfileViewModel.filterModel!.countries!.map((e) => e.name)
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
              value: upDateProfileViewModel.selectedOfficeBranch!=""?  upDateProfileViewModel.selectedOfficeBranch:null,
              onChanged: (value) {
                upDateProfileViewModel.selectedCity="";
                upDateProfileViewModel.selectedOfficeBranch = value.toString();
                upDateProfileViewModel.selectedOfficeBranchID = upDateProfileViewModel.filterModel!.countries!
                    .firstWhere(
                        (element) => element.name ==upDateProfileViewModel.selectedOfficeBranch)
                    .id
                    .toString();
                print(upDateProfileViewModel.selectedOfficeBranch);
                print(upDateProfileViewModel.selectedOfficeBranchID);
                upDateProfileViewModel.getCityDataApi();



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
                hintText: HomeViewModel.profileModel!.office!=null? HomeViewModel.profileModel!.office!.city_name :"",
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

                hintStyle: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: const Color(0xffB2B3B6)),
              ),
              items: upDateProfileViewModel.cites.isNotEmpty
                  ?  upDateProfileViewModel.cites.map((e) => e.name)
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
              value: upDateProfileViewModel.selectedCity!=""?  upDateProfileViewModel.selectedCity:null,
              onChanged: (value) {

                upDateProfileViewModel.citySetState(value.toString());
                upDateProfileViewModel.selectedCityID = upDateProfileViewModel.cites
                    .firstWhere(
                        (element) => element.name ==upDateProfileViewModel.selectedCity)
                    .id
                    .toString();
                print(upDateProfileViewModel.selectedCity);
                print(upDateProfileViewModel.selectedCityID);



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
                  value: upDateProfileViewModel.switchValueSat,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchSatSetState(val);
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
                 controller: upDateProfileViewModel.timeInSatControl,
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

                     upDateProfileViewModel.timeSatSetState(formattedTime);

                     print(upDateProfileViewModel.timeInSatControl.text);




                     // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                 controller: upDateProfileViewModel.timeoutSatControl,
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

                     upDateProfileViewModel.timeoutSatSetState(formattedTime);

                     print(upDateProfileViewModel.timeoutSatControl.text);




                     // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueSun,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchSunSetState(val);
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
                    controller: upDateProfileViewModel.timeInSunControl,
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

                        upDateProfileViewModel.timeSunSetState(formattedTime);

                        print(upDateProfileViewModel.timeInSunControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutSunControl,
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

                        upDateProfileViewModel.timeoutSunSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutSunControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueMon,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchMonSetState(val);
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
                    controller: upDateProfileViewModel.timeInMonControl,
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

                        upDateProfileViewModel.timeInMonSetState(formattedTime);

                        print(upDateProfileViewModel.timeInMonControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutMonControl,
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

                        upDateProfileViewModel.timeoutMonSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutMonControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueTus,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchTusSetState(val);
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
                    controller: upDateProfileViewModel.timeInTusControl,
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

                        upDateProfileViewModel.timeInTusSetState(formattedTime);

                        print(upDateProfileViewModel.timeInTusControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutTusControl,
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

                        upDateProfileViewModel.timeoutTusSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutTusControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueWed,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchWedSetState(val);
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
                    controller: upDateProfileViewModel.timeInWedControl,
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

                        upDateProfileViewModel.timeInWedSetState(formattedTime);

                        print(upDateProfileViewModel.timeInWedControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutWedControl,
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

                        upDateProfileViewModel.timeoutWedSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutWedControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueThur,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchThurSetState(val);
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
                    controller: upDateProfileViewModel.timeInThurControl,
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

                        upDateProfileViewModel.timeInThurSetState(formattedTime);

                        print(upDateProfileViewModel.timeInThurControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutThurControl,
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

                        upDateProfileViewModel.timeoutThurSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutThurControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                  value: upDateProfileViewModel.switchValueFri,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  onToggle: (val) {
                    upDateProfileViewModel.switchFriSetState(val);
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
                    controller: upDateProfileViewModel.timeInFriControl,
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

                        upDateProfileViewModel.timeInFriSetState(formattedTime);

                        print(upDateProfileViewModel.timeInFriControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
                    controller: upDateProfileViewModel.timeoutFriControl,
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

                        upDateProfileViewModel.timeoutFriSetState(formattedTime);

                        print(upDateProfileViewModel.timeoutFriControl.text);




                        // if(upDateProfileViewModel.timeInControl.text!=""|| upDateProfileViewModel.timeOutControl.text!=""){
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
