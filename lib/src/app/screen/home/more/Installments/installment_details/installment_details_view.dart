import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'installment_details_viewmodel.dart';

class InstallmentDetailsView extends StatefulWidget {
  const InstallmentDetailsView({super.key});

  @override
  State<InstallmentDetailsView> createState() => _InstallmentDetailsViewState();
}

class _InstallmentDetailsViewState extends InstallmentDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              Row(children: [

                InkWell( onTap: () {
                  Navigator.pop(context);
                }
                    ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                Text(
                  "#${installment!.id!}",
                  style: const TextStyle(
                      color:  Colors.white,
                      fontSize: 21, fontWeight: FontWeight.w400),
                ),

              ],),
              const SizedBox(height: 10,),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10,),
                      SvgPicture.asset("assets/images/time.svg",color: Colors.white,),
                      const SizedBox(width: 5,),
                      Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(installment!.dueDate!)),
                        style: GoogleFonts.tajawal(color: Colors.white,
                            fontSize:13,fontWeight: FontWeight.w400),),
                    ],
                  ),

                  Container(height: 25,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                        color: installment!.status=="paid"?const Color(0xff5AC41A):Colors.red ),
                    child: Center(
                      child: Text(
                          installment!.status=="paid"?
                          tr("Paid")
                              :tr("WaitingForPayment")
                        ,style: GoogleFonts.tajawal(color: Colors.white,
                          fontSize:12,fontWeight: FontWeight.w500),),
                    ),
                  )

                ],
              ),



            ],
          ),
        ),
        flexibleSpace:  Stack(
            children: [


              Container(height: 30,color: const Color(0xff00A8A5),),
              Image(
                image: const AssetImage('assets/images/packagedetails.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                  children: [
                     Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const SizedBox(height: 10,),

                          Card(elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(width: size.width,

                              decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      tr("ClientDetails"),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),

                                    Row(children: [
                                      Container(
                                        height: 50,width: 50,
                                        padding: const EdgeInsets.all(11),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff8a8c8e),
                                            border: Border.all(width: 1.5,color: Colors.white)
                                        ),
                                        child:Center(child: SvgPicture.asset("assets/images/user.svg",)) ,),


                                      const SizedBox(width: 10,),

                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(installment!.userName.toString(),
                                            style: GoogleFonts.tajawal(color: Colors.black,
                                                fontSize:15,fontWeight: FontWeight.w500),),
                                          // Text(packageDetails!.user!.phone!,style: GoogleFonts.tajawal(color: Colors.black,
                                          //     fontSize:13,fontWeight: FontWeight.w400),),

                                        ],)
                                    ],),
                                  ],
                                ),
                              ) ,
                            ),
                          ),
                          const SizedBox(height: 10,),

                          Card(elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(width: size.width,

                              decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      tr("InstallmentDetails"),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),

                                    Text(
                                      installment!.offerName.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),

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
                                          installment!.dueDate.toString(),
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
                                          "${installment!.dueAmount.toString().substring(0,4)} ${tr("Sar")}",
                                          style: const TextStyle(
                                            color: Color(0xff043C7C),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],),
                              ) ,
                            ),
                          ),



                        ],),
                      ),
                    ),
                  ]),
            ),



          ]),


    );
  }
}
