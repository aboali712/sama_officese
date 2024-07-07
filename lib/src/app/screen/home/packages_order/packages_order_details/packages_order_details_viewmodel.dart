import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/core/values/colors.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../more/Installments/model/installment_model.dart';
import '../../more/Installments/model/installment_response.dart';
import '../../services/model/booking_servive_model.dart';
import 'model/cancel_reason_model.dart';
import 'model/cancel_response.dart';

abstract class PackagesOrderDetailsViewModel extends State<PackagesOrderDetailsView>{
  final Dio dio = NetworkService.instance.dio;

  String changeState="";
  static BookingsServiceModel? bookingsServiceModel;
   BookingsServiceModel? packageDetails;
   bool isLoading=false;
  List listStatues= ["pending","accepted","inReview","processing","waiting_for_pay","completed","canceled" ];

  String cancelReason="";
  String cancelIndex="";

   CancelModel?cancelModel;
  List<InstallmentModel>? installmentModel;

  @override
  void initState() {
  setState(() {
    packageDetails=bookingsServiceModel;
  });
  getReason();
  getReserveInstallment();
    super.initState();
  }
  Future<void> getReserveInstallment() async {
    setState(() {
      isLoading=true;
    });
    Map<String, String> mp = {};
    mp["reservation_id"] = packageDetails!.id.toString();
    final response = await dio.get("v1/office/ReservationInstallments", queryParameters: mp);
    var rs = InstallmentResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      installmentModel=rs.data;
    }
  }


  Future<void> getReason() async {

    var re=await dio.get("/v1/cancellationReasons");
    var response=CancelResponse(re.data).data;


    if (CancelResponse(re.data).status == 200) {
      setState(() {
        cancelModel=response;

      });
      setState(() {
      });
    }else{


    }
  }

  Future<void> changeStatusApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });
    mp["reservation_id"]=packageDetails!.id.toString();

    mp["status"] = changeState;
    if(changeState=="canceled"){
      mp["cancellation_reasons"]=cancelIndex;
    }


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
        packageDetails!.status=changeState;
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
              height: 500,
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

                    Column( children: listStatues.map((e) =>  Column(
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
                                  : e=="waiting_for_pay"?
                              tr("waiting_for_pay")
                                  : e=="completed"?
                              tr("Completed")
                                  :e=="canceled"?
                              tr("Cancelled")
                                  : tr("")

                              ,style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:14,fontWeight: FontWeight.w400),),

                            InkWell(onTap: () {
                              setState((){
                                changeState=e;
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
                        const SizedBox(height: 10,)
                      ],
                    ),).toList(),),




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
                        if(changeState=="canceled"){
                          showMyDialog(context);
                        }else{   changeStatusApi();}




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



  Future<void> showMyDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Stack(
            children: [ AlertDialog(backgroundColor: Colors.white,
              elevation: 5,
              contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              insetPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 50.0),



              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListBody(
                    children:  <Widget>[



                      SizedBox(width: size.width,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            Text(tr("ChooseTheReasonForCancellation"),style: GoogleFonts.tajawal(
                                fontSize: 15,fontWeight: FontWeight.w700),),
                            const SizedBox(height: 20,),


                            Container(height: 55,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: DropdownButtonFormField2(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 15.0, top: 10, left: 10, right: 10),
                                  filled: true,
                                  fillColor: const Color(0XFFF5F9F9),
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
                                  hintText: tr("ChooseTheReasonForCancellation"),
                                  hintStyle: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      color: const Color(0xffB2B3B6)),
                                ),
                                items: cancelModel != null
                                    ?   cancelModel!.data!.map((e) => e)
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
                                value: cancelReason!=""?
                                cancelReason:null,
                                onChanged: (value) {
                                  setState(() {

                                    cancelReason = value.toString();
                                    cancelIndex  = cancelModel!.data!.indexOf(cancelReason).toString();

                                  });
                                  print(cancelReason);
                                  print(cancelIndex);



                                },

                              ),
                            ),
                            const SizedBox(height: 30,),


                            TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: Size(size.width-100, 40),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: samaColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: samaColor),
                              onPressed: () async {


                                changeStatusApi();
                                Navigator.pop(context);


                              },
                              child:  Text(
                                tr("Apply"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),


                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),

            ),







            ]  );
      },
    );
  }





  Future<void> showBottomSheetInstallment(BuildContext context) async {
    Size size = MediaQuery.of(context).size;

    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height:installmentModel!.length>=4?550: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10, width: size.width),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        tr("Payments"),
                        style: const TextStyle(
                          color: Color(0xff043C7C),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.grey.shade400,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Column( children: installmentModel!.map((e) => Card(
                              elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width: size.width,
                                padding: const EdgeInsets.all(10),                             
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,

                                ),
                                child: Column(children: [
                              
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
                              
                              
                              
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
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
                                          ),
                              
                                        ],)
                                    ],),
                              
                              
                              
                              
                              
                              
                                ],),
                              ),
                            )).toList(),)


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



}