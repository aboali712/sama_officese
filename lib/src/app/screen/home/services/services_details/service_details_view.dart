import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/services/services_details/service_details_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/values/colors.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends ServiceDetailsViewModel {
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
              const SizedBox(height: 20,),

              Row(children: [

                InkWell( onTap: () {
                  Navigator.pop(context);
                }
                    ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                 Text(
                  "#${serviceDetails!.id!}",
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
                      Text(DateFormat("MMM d,yyyy","en" ).format(DateTime.parse(serviceDetails!.createdAt!)),
                        style: GoogleFonts.tajawal(color: Colors.white,
                          fontSize:13,fontWeight: FontWeight.w400),),
                    ],
                  ),

                  Container(height: 25,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                        color:const Color(0xff5AC41A) ),
                    child: Center(
                      child: Text(
                          serviceDetails!.status=="pending"?
                        tr("New")
                          : serviceDetails!.status=="inReview"?
                              tr("Underway")
                              : serviceDetails!.status=="canceled"  ?
                              tr("Canceled")
                           : serviceDetails!.status=="completed"?
                         tr("Complete")
                              :tr("Underway")
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


              Container(height: 30,color: const Color(0xff00417E),),
              Image(
                image: const AssetImage('assets/images/servdetails.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 120,
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
                child: Column(children: [
                  const SizedBox(height: 10,),

                        Card(elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(width: size.width,

                      decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Container(
                                height: 45,width: 50,
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff8a8c8e),
                                    border: Border.all(width: 1.5,color: Colors.white,),
                                    image:  DecorationImage(
                                      image: NetworkImage(serviceDetails!.user!.image!),fit: BoxFit.cover )
                                ),
                              ),

                              const SizedBox(width: 10,),

                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("${serviceDetails!.user!.firstName!} ${serviceDetails!.user!.lastName}",
                                    style: GoogleFonts.tajawal(color: Colors.black,
                                      fontSize:15,fontWeight: FontWeight.w500),),
                                  Text(serviceDetails!.user!.phone!,style: GoogleFonts.tajawal(color: Colors.black,
                                      fontSize:13,fontWeight: FontWeight.w400),),

                                ],)
                            ],),

                            InkWell(onTap: () {
                              launchUrl(Uri.parse(
                                  "tel://${serviceDetails!.user!.phone!}"));

                            },child: SvgPicture.asset("assets/images/phone.svg"))


                          ],
                        ),
                      ) ,
                    ),
                  ),
                  const SizedBox(height: 5,),

                       Padding(
                         padding: const EdgeInsets.all(8),
                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           Text(tr("Services"),style: GoogleFonts.tajawal(color: Colors.black,
                               fontSize:17,fontWeight: FontWeight.w500),),


                           Text(serviceDetails!.services!.length.toString(),style: GoogleFonts.tajawal(color: Colors.black,
                               fontSize:14,fontWeight: FontWeight.w500),),

                         ],),
                       ),
                  const SizedBox(height: 5,),
                Column(children: serviceDetails!.services!.map((e) =>
                    Column(
                      children: [
                        Card(elevation: 5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: Container(width: size.width,

                        decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                       e.serviceId== 1
                                      ? "${ tr("Vises")} ${e.countryTitle}"
                                      : e.serviceId ==2
                                      ? tr("CarRent")
                                      : e.serviceId ==3
                                      ? tr("HotelBookings")
                                      : e.serviceId ==4
                                      ? tr("FlightTickets")
                                      : tr("Licenses"),


                                        style: GoogleFonts.tajawal(color: Colors.black,
                                    fontSize:16,fontWeight: FontWeight.w500),),
                              ),
                              Divider(height: 5,thickness: 1,color: Colors.grey.shade300,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    e.serviceId==1?

                                Column(children: [

                                  Row(
                                    children: [
                                      SizedBox(width: 90,
                                        child: Text(tr("${tr("Nationality")} : "),
                                          style: GoogleFonts.tajawal(color: Colors.black,
                                            fontSize:15,fontWeight: FontWeight.w500),),
                                      ),


                                      Text(e.nationalityTitle!,style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      SizedBox(width: 90,
                                        child: Text(tr("${tr("Country")} : "),
                                          style: GoogleFonts.tajawal(color: Colors.black,
                                            fontSize:15,fontWeight: FontWeight.w500),),
                                      ),


                                      Text(e.countryTitle!,style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      SizedBox(width: 90,
                                        child: Text(tr("${tr("Notes")} : "),
                                          style: GoogleFonts.tajawal(color: Colors.black,
                                            fontSize:15,fontWeight: FontWeight.w500),),
                                      ),


                                      Text(e.notes??"",style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                    ],
                                  ),

                                ],)
                                :Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          e.ticketType! ==
                                              "go"
                                              ? "${tr("TicketType")} : ${tr("OneWay")}"
                                              : e.ticketType! == "go_back"
                                              ? "${tr("TicketType")} : ${tr("RoundTrip")}"
                                              : "${tr("TicketType")} : ${tr("MultipleCities")}",
                                          style: const TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize:
                                              14,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          e.ticketClass! ==
                                              "first"
                                              ? "${tr("TravelClass")} : ${tr("FirstClass")}"
                                              : e.ticketClass == "economy"
                                              ? "${tr("TravelClass")} : ${tr("Economic")}"
                                              : "${tr("TravelClass")} : ${tr("Business")}",
                                          style: const TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize:
                                              14,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        e.ticketType ==
                                            "multi_cities"
                                            ? SizedBox(
                                          height:
                                          (80 * double.parse(e.transits!.length.toString())),
                                          child:
                                          ListView.builder(
                                            itemBuilder: (BuildContext context, int inex) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${tr("From")} : ${e.transits![inex].startCity!}",
                                                    style: const TextStyle(color: Colors.black,
                                                        fontSize: 14, fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${tr("To")} : ${e.transits![inex].endCity!}",
                                                    style: const TextStyle(color: Colors.black,
                                                        fontSize: 14, fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${tr("DepartuareDate")} : ${e.transits![inex].startDate!}",
                                                    style: const TextStyle(color: Colors.black,
                                                        fontSize: 14, fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${tr("ArrivalDate")} : ${e.transits![inex].endDate!}",
                                                    style: const TextStyle(color: Colors.black,
                                                        fontSize: 14, fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),

                                                ],
                                              );
                                            },
                                            itemCount: e.transits!.length,
                                          ),
                                        )
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${tr("From")} : ${e.startPlace!}",
                                              style: GoogleFonts.tajawal(color: Colors.black,
                                                  fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${tr("To")} : ${e.endPlace!}",
                                              style: const TextStyle(color: Colors.black,
                                                  fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${tr("DepartuareDate")} : ${e.startDate!}",
                                              style: const TextStyle(color: Colors.black,
                                                  fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${tr("ArrivalDate")} : ${e.endDate!}",
                                              style: GoogleFonts.tajawal(color: Colors.black,
                                                  fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                          ],
                                        )
                                      ],
                                    )
                                ,
                              )

                            ]) ,
                                      ),
                                    ),
                        const SizedBox(height: 10,)
                      ],
                    )

                  ,).toList(),),

                  const SizedBox(height: 120,),


                ]),
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
            child: Card( elevation: 5,shape: const RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(25)
                    ,topRight:Radius.circular(25) )),
              child: Container(height: 120,width: size.width,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)
                  ,topRight:Radius.circular(25) )),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(tr("RequestStatusChanged"),style: GoogleFonts.tajawal(color: Colors.black,
                      fontSize:15,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),

                      InkWell(onTap: () {

                      setState(() {
                        changeState=serviceDetails!.status!;
                      });
                        changeStatus();
                      },
                        child: Container(height: 40,width: size.width,
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                          decoration:  BoxDecoration(color: const Color(0xffe2e9ef),
                              borderRadius: BorderRadius.circular(10),),

                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  serviceDetails!.status=="pending"?
                                  tr("New")
                                      : serviceDetails!.status=="inReview"?
                                  tr("Underway")
                                      : serviceDetails!.status=="canceled"  ?
                                  tr("Canceled")
                                      : serviceDetails!.status=="completed"?
                                  tr("Complete")
                                      :tr("Underway")
                            ,style: GoogleFonts.tajawal(color: Colors.black,
                                    fontSize:15,fontWeight: FontWeight.w500),),

                                const Icon(Icons.keyboard_arrow_down,color: Color(0xff8e8e93),),





                              ]),
                        ),
                      ),



                ]),
              ),
            ),
          )





      ]),


    );
  }
}
