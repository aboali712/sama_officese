import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/services/services_details/service_details_view.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../model/booking_servive_model.dart';

abstract class ServiceDetailsViewModel extends State<ServiceDetails>{
  final Dio dio = NetworkService.instance.dio;

  String changeState="";
  List listStatues= ["pending","accepted","inReview","processing","completed","cancelled" ];

  static BookingsServiceModel?bookingsServiceModel;
   BookingsServiceModel?serviceDetails;
   bool isLoading=false;
  @override
  void initState() {
    setState(() {
      serviceDetails=bookingsServiceModel;

    });

    super.initState();
  }



  Future<void> changeStatusApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });
    mp["reservation_id"]=serviceDetails!.id.toString();

    mp["status"] = changeState;
    final response =
    await dio.post("v1/office/changeStatus", data: mp);
    setState(() {
      isLoading=false;
    });
    var rs = EmptyResponse(response.data!);
    if (rs.status == 200) {
      toastAppSuccess(rs.msg!, context);
      Navigator.pop(context);
      setState(() {
        serviceDetails!.status=changeState;
      });
    }else{
      toastApp(rs.msg!, context);

    }
  }




  void changeStatus() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor:Colors.grey.shade100,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return  SizedBox(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: () {
                         Navigator.pop(context);
                        },
                            child: Icon(Icons.arrow_circle_right,size: 35,color: Colors.grey.shade400,)),

                        Text(tr("RequestStatusChanged"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:16,fontWeight: FontWeight.w500),),
                        const SizedBox(width: 50,)
                      ],
                    ),
                    const SizedBox(height: 30,),


                    Column(children:listStatues.map((e) =>
                        Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                            Text(
                              e=="pending"?
                                  tr("Pending")
                             : e=="accepted"?
                                  tr("Accepted")
                                  : e=="inReview"?
                                  tr("Reviewing")
                                  : e=="processing"?
                                  tr("Processing")
                                  : e=="completed"?
                                  tr("Completed")
                                  :e=="cancelled"?
                                  tr("Cancelled")
                                 : tr("")

                              ,style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:14,fontWeight: FontWeight.w400),),

                            InkWell(onTap: () {
                              setState((){
                                changeState=e;
                                print(changeState);
                              });
                            },
                              child: Container(height: 30,width: 30,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                    color: changeState==e?const Color(0xff00A8A5) :Colors.transparent,
                                    border: Border.all(width: 1,color:const Color(0xff00A8A5) )

                                ),
                                child:  Center(child: Icon(Icons.done,size: 20,
                                  color: changeState==e? Colors.white:Colors.grey.shade200,
                                )),
                              ),
                            )
                                                  ],
                                                ),
                            const SizedBox(height: 10,),
                          ],
                        ),).toList() ,),






                    const SizedBox(height: 50,),


                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                          fixedSize:  Size(size.width, 50),
                          shape: RoundedRectangleBorder(

                              side: const BorderSide(
                                  color: Color(0xffea8024)),
                              borderRadius:
                              BorderRadius.circular(15)),
                          backgroundColor: const Color(0xffea8024)),
                      onPressed: () {

                        changeStatusApi();
                      },
                      child: Text(
                        tr('SaveChanges'),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),


                  ],
                ),
              ),
            );
          });
        });
  }

}