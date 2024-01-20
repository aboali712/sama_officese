import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          tr("تغير اللوجو"),
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
                            decoration:BoxDecoration(
                                border: Border.all(color: samaColor,width: 1),
                                color: samaColor,
                                borderRadius: BorderRadius.circular(50),
                            ) ,child:  Image.asset("assets/images/pin.png",height: 15,color: Colors.white,),

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
            tr("الأسم بالكامل"),
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
                hintText: (tr("الأسم بالكامل بالعربى")),
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
          hintText: (tr("الأسم بالكامل بالأنجليزى")),
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



      ],),
    );
  }
}
