import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/input_validators.dart';
import '../../../../../core/values/colors.dart';
import 'add_service_viewmodel.dart';

class AddServiceView extends StatefulWidget {
  const AddServiceView({super.key});

  @override
  State<AddServiceView> createState() => _AddServiceViewState();
}

class _AddServiceViewState extends AddServiceViewModel {
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
                  tr("AddAService"),
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
            SizedBox(height: size.height,width: size.width,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),



                              servicesModel!=null?
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(tr("AddedServices"),style: GoogleFonts.tajawal(color: Colors.black,
                                      fontSize:15,fontWeight: FontWeight.w500),),

                                  Column( children:servicesModel!.map((e) =>

                                      Card(elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Container(width: size.width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(crossAxisAlignment:  CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("${tr("service")} : ",style: GoogleFonts.tajawal(color: Colors.black,
                                                      fontSize:14,fontWeight: FontWeight.w500),),
                                                  Text(e.title.toString(),style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                                      fontSize:14,fontWeight: FontWeight.w500),),
                                                ],
                                              ),


                                              Row(
                                                children: [
                                                  Text("${tr("price")} : ",style: GoogleFonts.tajawal(color: Colors.black,
                                                      fontSize:14,fontWeight: FontWeight.w500),),
                                                  Text("${e.cost.toString()} ${tr("Sar")}",style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                                      fontSize:14,fontWeight: FontWeight.w500),),


                                                ],
                                              ),
                                            ],
                                          ),

                                           InkWell( onTap: () {
                                               setState(() {
                                                 serviceId=e.id.toString();
                                               });
                                               deleteServiceApi();

                                           },child: const SizedBox(
                                               height: 35,width: 35,
                                               child: Icon(Icons.delete_rounded,color:Color(0xffEA8024),size: 25,)))



                                        ],) ,
                                    ),
                                  )).toList(),),




                                  const SizedBox(height: 20,),


                                ],)
                                  :const SizedBox.shrink(),



                              Text(tr("ServiceName"),style: GoogleFonts.tajawal(color: Colors.black,
                                  fontSize:15,fontWeight: FontWeight.w500),),


                              SizedBox(height: 45,
                                child: TextFormField(
                                  controller: serviceNameControl,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: (tr("ServiceName")),
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

                              Text(tr("ServicePrice"),style: GoogleFonts.tajawal(color: Colors.black,
                                  fontSize:15,fontWeight: FontWeight.w500),),


                              SizedBox(height: 45,
                                child: TextFormField(
                                  controller: servicePriceControl,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: (tr("ServicePrice")),
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

                              const SizedBox(height: 200,),



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



            Positioned(bottom:-5,left: -5,right: -5,
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
                        if(checkValid()){
                          createServiceApi();
                        }
                      },
                      child: Text(
                        tr("Send"),
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
