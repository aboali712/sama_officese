import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/input_validators.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/widgets/phone_number_widget.dart';
import '../update_profile_viewmodel.dart';



class StepOneProfile extends StatelessWidget {
  final UpDateProfileViewModel upDateProfileViewModel;
  const StepOneProfile(this.upDateProfileViewModel,{super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const SizedBox(height: 20,),

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        SizedBox(width: size.width/2-20,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [


            Text(
              tr("FirstName"),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 45,
              child: TextFormField(
                controller: upDateProfileViewModel.firstNameControl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: (tr("FirstName")),
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
        ),
        SizedBox(width:size.width/2-20,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              tr("LastName"),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
              SizedBox(height: 45,
                child: TextFormField(
                  controller: upDateProfileViewModel.lastNameControl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: (tr("LastName")),
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
        )
      ],),

        const SizedBox(height: 20,),

        Text(
          tr("Phone"),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15),
          textAlign: TextAlign.center,
        ),
        PhoneNumberSignUpWidget(controllerPhone: upDateProfileViewModel.phoneControl,
          isPhone: upDateProfileViewModel.isPhone,
          focusNode: upDateProfileViewModel.focusPhone,
          hintText: tr("EnterMobile"),
          onChanged: (value) {
            if (value == null ||
                value.isEmpty ||
                !InputValidators().phoneNumberValidator(
                    phoneNumber: "20$value", context: context)) {
              upDateProfileViewModel.phoneSetState(value!);
              upDateProfileViewModel.isPhone = false;
              // setState(() {
              //   // phoneValidation = true;
              //   signUpViewModel.isPhone = false;
              //   phoneNumber = value!;
              // });
            } else {
              upDateProfileViewModel.phoneSetState(value);
              upDateProfileViewModel.isPhone = true;
              // setState(() {
              //   // phoneValidation = false;
              //   signUpViewModel.isPhone = true;
              //   phoneNumber = value;
              // });
            }
          },
          onSaved: (value) {
            upDateProfileViewModel.phoneSetState(value!);

          },
        ),

        const SizedBox(height: 20,),

          Text(
            tr("E-mail"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45,
            child: TextFormField(
              controller: upDateProfileViewModel.emailControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("E-mail"),
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
                  const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    width: .7,
                    color: klightGray,
                  ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                    BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                    BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .emailValidator(email: value, context: context)) {
                  // setState(() {
                  //   isValidationEmail = true;
                  //   email = value;
                  // });
                } else {
                  // setState(() {
                  //   isValidationEmail = false;
                  //   email = value;
                  // });
                }
              },
              onSaved: (value) {
                // email = value ?? "";
              },

              cursorColor: Colors.black,
              keyboardType: TextInputType.emailAddress,
            ),
          ),




          const SizedBox(height: 20,),

          // Text(
          //   tr("Password"),
          //   style: const TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 15),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 45,
          //   child: TextFormField(
          //     controller: upDateProfileViewModel.passwordControl,
          //     autovalidateMode: AutovalidateMode.onUserInteraction,
          //     style: const TextStyle(fontSize: 15),
          //     obscureText: upDateProfileViewModel.obscureTxt,
          //     decoration: InputDecoration(
          //       hintText: tr("Password"),
          //       hintStyle: GoogleFonts.tajawal(
          //           fontSize: 12,
          //           color: const Color.fromRGBO(196, 196, 196, 1)),
          //       suffixIcon: GestureDetector(
          //         onTap: () {
          //           upDateProfileViewModel.passwordEyeSetState(!upDateProfileViewModel.obscureTxt);
          //
          //         },
          //         child: Icon(
          //           upDateProfileViewModel.obscureTxt
          //               ? Icons.visibility_off_outlined
          //               : Icons.visibility_outlined,
          //           color: upDateProfileViewModel.obscureTxt ? disabledColor : grayColor,
          //         ),
          //       ),
          //
          //       errorStyle: const TextStyle(color: accentColor),
          //       contentPadding: const EdgeInsets.symmetric(
          //           vertical: 17.0, horizontal: 10.0),
          //
          //       filled: true,
          //
          //       fillColor: const Color(0xFFF3F3F5),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius:
          //         const BorderRadius.all(Radius.circular(8)),
          //         borderSide: BorderSide(width: 1, color: klightGray),
          //       ),
          //       disabledBorder: OutlineInputBorder(
          //         borderRadius:
          //         const BorderRadius.all(Radius.circular(8)),
          //         borderSide: BorderSide(width: .7, color: klightGray),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius:
          //         const BorderRadius.all(Radius.circular(8)),
          //         borderSide: BorderSide(
          //           width: .7,
          //           color: klightGray,
          //         ),
          //       ),
          //       border: const OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(8)),
          //           borderSide: BorderSide(
          //             width: 1,
          //           )),
          //       errorBorder: const OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(8)),
          //           borderSide:
          //           BorderSide(width: 0.7, color: accentColor)),
          //       focusedErrorBorder: const OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(8)),
          //           borderSide:
          //           BorderSide(width: 0.7, color: accentColor)),
          //     ),
          //     onChanged: (value) {
          //       if (value.isEmpty ||
          //           value == null ||
          //           !InputValidators()
          //               .passwordValidator(password:  value, context: context)) {
          //         // setState(() {
          //         //   isValidationEmail = true;
          //         //   email = value;
          //         // });
          //       } else {
          //         // setState(() {
          //         //   isValidationEmail = false;
          //         //   email = value;
          //         // });
          //       }
          //     },
          //     onSaved: (value) {
          //       // email = value ?? "";
          //     },
          //
          //     cursorColor: Colors.black,
          //     keyboardType: TextInputType.text,
          //   ),
          // ),
          //






          const SizedBox(height: 70,)

      ],),
    );
  }
}
