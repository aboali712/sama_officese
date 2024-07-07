import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';

import '../../../../core/values/colors.dart';
import 'Installments_viewmodel.dart';
import 'installment_details/installment_details_view.dart';
import 'installment_details/installment_details_viewmodel.dart';

class InstallmentsView extends StatefulWidget {
  const InstallmentsView({super.key});

  @override
  State<InstallmentsView> createState() => _InstallmentsViewState();
}

class _InstallmentsViewState extends InstallmentsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  tr("Installments"),
                  style: GoogleFonts.tajawal(
                      color:  Colors.white,
                      fontSize: 21, fontWeight: FontWeight.w500),
                ),

              ],),


            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [
              Container(height: 30,color: const Color(0xff00A8A5),),
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
            SizedBox(height: size.height,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [

                          Container(height: 40,width: size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  canvasColor: Colors.white),
                              child: DropdownButtonFormField2(
                                dropdownStyleData: const DropdownStyleData(maxHeight: 350),
                                dropdownSearchData: DropdownSearchData(
                                  searchController:textEditingController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.text,
                                      expands: true,
                                      maxLines: null,
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,size: 20),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: tr("SearchHere"),
                                        hintStyle: const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value.toString().contains(searchValue);
                                  },
                                ),
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    textEditingController.clear();
                                  }
                                },

                                isExpanded: true,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,color: Color(0xff043C7C),),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 5.0, top: 5, left: 10, right: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelStyle: const TextStyle(color: textGrayColor),
                                  errorStyle: const TextStyle(color: textError),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: .1, color: Colors.grey.shade400),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 1,color: Colors.grey.shade400,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide( width: 1,color: Colors.grey.shade400
                                      )),
                                  errorBorder:  OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.grey.shade400)),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      borderSide:
                                      BorderSide(width:1, color: Colors.grey.shade400)),
                                  // hintText: tr("ChooseCountry"),
                                  hintStyle: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      color: const Color(0xffB2B3B6)),
                                ),
                                items: installmentListSearch != null
                                    ?   installmentListSearch!.map((e) => e.offerName)
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
                                value:installment!=""?
                                installment: null,
                                onChanged: (value) {
                                  setState(() {
                                    installmentLastResult=[];
                                    installment = value.toString();
                                    installmentId  = installmentListSearch!
                                        .firstWhere(
                                            (element) => element.offerName == installment)
                                        .id
                                        .toString();
                                    installmentLastResult=   installmentModel!.where((elementModel) => elementModel.offerName==installment).toList();
                                  });
                                  print(installment);
                                  print(installmentId);

                                },

                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),

                          Column( children:
                          installmentLastResult!=null?
                        installmentLastResult!.map((e) => InkWell(
                          onTap: () {
                            setState(() {
                              InstallmentDetailsViewModel.installmentDetails=e;
                            });
                            SamaOfficeApp.navKey.currentState!.push(
                                MaterialPageRoute(builder: (context) => const InstallmentDetailsView(),));
                          },
                          child: Card(elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width: size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                 color: Colors.white,
                                    // border: Border.all(width: .4,color: Colors.grey)
                                ),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  Text(
                                    e.offerName.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),

                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${tr("dueDate")} : ",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                e.dueDate.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xff043C7C),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text(
                                                "${tr("dueAmount")} : ",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${e.dueAmount.toString().substring(0,4)} ${tr("Sar")}",
                                                style: const TextStyle(
                                                  color: Color(0xff043C7C),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],),



                                      Text(
                                        e.status=="paid"?
                                        tr("Paid")
                                            :tr("WaitingForPayment"),
                                        style:  TextStyle(
                                          color:
                                          e.status=="paid"?
                                          Colors.green
                                              :Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],),






                                ],),
                              ),
                            ),
                        )).toList()
                            :[]
                            ,)
                        //   Column( children:
                        //   installmentLastResult!=null?
                        //   installmentLastResult!.where((element) => false).map((e) => Card(elevation: 5,
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        //     child: Container(
                        //       width: size.width,
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         // border: Border.all(width: .4,color: Colors.grey)
                        //       ),
                        //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //
                        //           Text(
                        //             e.offerName.toString(),
                        //             style: const TextStyle(
                        //               color: Colors.black,
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           const SizedBox(height: 5,),
                        //
                        //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Row(
                        //                     children: [
                        //                       Text(
                        //                         "${tr("dueDate")} : ",
                        //                         style: const TextStyle(
                        //                           color: Colors.black,
                        //                           fontSize: 14,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         e.dueDate.toString(),
                        //                         style: const TextStyle(
                        //                           color: Color(0xff043C7C),
                        //                           fontSize: 15,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //
                        //                       Text(
                        //                         "${tr("dueAmount")} : ",
                        //                         style: const TextStyle(
                        //                           color: Colors.black,
                        //                           fontSize: 14,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         "${e.dueAmount.toString().substring(0,4)} ${tr("Sar")}",
                        //                         style: const TextStyle(
                        //                           color: Color(0xff043C7C),
                        //                           fontSize: 15,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],),
                        //
                        //
                        //
                        //               Text(
                        //                 e.status=="paid"?
                        //                 tr("Paid")
                        //                     :tr("WaitingForPayment"),
                        //                 style:  TextStyle(
                        //                   color:
                        //                   e.status=="paid"?
                        //                   Colors.green
                        //                       :Colors.red,
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.w500,
                        //                 ),
                        //               )
                        //             ],),
                        //
                        //
                        //
                        //
                        //
                        //
                        //         ],),
                        //     ),
                        //   )).toList()
                        //       :[]
                        //     ,)

                        ],),
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








          ] ),


    );
  }
}
