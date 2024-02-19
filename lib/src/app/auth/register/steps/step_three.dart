import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/auth/register/signup_viewmodel.dart';

import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';

class StepThree extends StatelessWidget {
 final SignUpViewModel signUpViewModel;
  const StepThree(this.signUpViewModel,{super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const SizedBox(height: 10,),



          Text(tr("ChooseServices"),
              style: GoogleFonts.tajawal(
                  fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Column(
              children:signUpViewModel.filterModel != null
                  ?signUpViewModel.filterModel!.services!
                  .map((e) => Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 40,
                        child: Checkbox(
                          activeColor: samaColor,

                          value: signUpViewModel.selectServices.contains(e),
                          onChanged: (newValue) {
                            signUpViewModel.serviceSetState(e);

                          },
                        ),
                      ),
                      Text(e.name!,
                          style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ))
                  .toList()
                  : []),


          const SizedBox(
            height: 20,
          ),


        Text(
          tr("BankAccountInformation"),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15),
          textAlign: TextAlign.start,
        ),

          const SizedBox(height: 20,),

          Text(
            tr("BankName"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 45,
            child: TextFormField(
              controller: signUpViewModel.bankNameControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("BankName"),
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
                        .textValidator(name: value, context: context)) {
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
              keyboardType: TextInputType.text,
            ),
          ),



          const SizedBox(height: 20,),

          Text(
            tr("accountNumber"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 45,
            child: TextFormField(
              controller: signUpViewModel.bankNumberControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("accountNumber"),
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
                        .textValidator(name: value, context: context)) {
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
              keyboardType: TextInputType.number,
            ),
          ),



          const SizedBox(height: 20,),

          Text(
            tr("IBANNumber"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 45,
            child: TextFormField(
              controller: signUpViewModel.ibanNumberControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("IBANNumber"),
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
                        .textValidator(name: value, context: context)) {
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
              keyboardType: TextInputType.text,
            ),
          ),



          const SizedBox(height: 20,),

          Text(
            tr("SubscriptionPlan"),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
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
                hintText: tr("SubscriptionPlan"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: const Color(0xffB2B3B6)),
              ),
              items: signUpViewModel.filterModel != null
                  ?  signUpViewModel.filterModel!.plans!.map((e) => e.name)
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
              value: signUpViewModel.plan!=""?  signUpViewModel.plan:null,
              onChanged: (value) {

                signUpViewModel.plan = value.toString();
                signUpViewModel.planId = signUpViewModel.filterModel!.plans!
                    .firstWhere(
                        (element) => element.name ==signUpViewModel.plan)
                    .id
                    .toString();
                print(signUpViewModel.plan);
                print(signUpViewModel.planId);




              },

            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(activeColor: samaColor,
                value: signUpViewModel.terms,
                onChanged: (bool? value) {
                signUpViewModel.termsSetState(value!);

                },
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                tr("IAgree"),
                style: const TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  // MoreViewModelPage.typePage = "3";
                  //
                  // SamaOfficesApp.navKey.currentState!.push(
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //         const AboutUs()));

                },
                child:  Text(
                  tr("Terms and Conditions"),
                  style: const TextStyle(
                      fontFamily: "Tajawal",
                      decoration: TextDecoration.underline,
                      decorationThickness: 20,

                      fontSize:14,
                      fontWeight: FontWeight.bold,
                      color: samaColor),
                ),
              ),
            ],
          ),





          const SizedBox(height: 70,)







        ],),
    );
  }
}
