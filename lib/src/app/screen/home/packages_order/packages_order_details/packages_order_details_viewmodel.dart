import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_view.dart';

abstract class PackagesOrderDetailsViewModel extends State<PackagesOrderDetailsView>{
  int changeState=0;

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
              height: 400,
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

                        Text(tr("تغير حالة الطلب"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:16,fontWeight: FontWeight.w500),),
                        const SizedBox(width: 50,)
                      ],
                    ),
                    const SizedBox(height: 30,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(tr("قيد الأنتظار"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:14,fontWeight: FontWeight.w400),),

                        InkWell(onTap: () {
                          setState((){
                            changeState=0;
                          });
                        },
                          child: Container(height: 30,width: 30,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: changeState==0?const Color(0xff00A8A5) :Colors.transparent,
                                border: Border.all(width: 1,color:const Color(0xff00A8A5) )

                            ),
                            child:  Center(child: Icon(Icons.done,size: 20,
                              color: changeState==0? Colors.white:Colors.grey.shade200,
                            )),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(tr("تم الموافقة"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:14,fontWeight: FontWeight.w400),),
                        InkWell(onTap: () {
                          setState((){
                            changeState=1;
                          });
                        },
                          child: Container(height: 30,width: 30,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: changeState==1?const Color(0xff00A8A5) :Colors.transparent,
                                border: Border.all(width: 1,color:const Color(0xff00A8A5) )

                            ),
                            child:  Center(child: Icon(Icons.done,size: 20,
                              color: changeState==1? Colors.white:Colors.grey.shade200,
                            )),
                          ),
                        )
                      ],
                    ),





                    const SizedBox(height: 15,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(tr("قيد المراجعة"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:14,fontWeight: FontWeight.w400),),
                        InkWell(onTap: () {
                          setState((){
                            changeState=2;
                          });
                        },
                          child: Container(height: 30,width: 30,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: changeState==2?const Color(0xff00A8A5) :Colors.transparent,
                                border: Border.all(width: 1,color:const Color(0xff00A8A5) )

                            ),
                            child:  Center(child: Icon(Icons.done,size: 20,
                              color: changeState==2? Colors.white:Colors.grey.shade200,
                            )),
                          ),
                        )
                      ],
                    ),


                    const SizedBox(height: 15,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(tr("جارى التنفيذ"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:14,fontWeight: FontWeight.w400),),
                        InkWell(onTap: () {
                          setState((){
                            changeState=3;
                          });
                        },
                          child: Container(height: 30,width: 30,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: changeState==3?const Color(0xff00A8A5) :Colors.transparent,
                                border: Border.all(width: 1,color:const Color(0xff00A8A5) )

                            ),
                            child:  Center(child: Icon(Icons.done,size: 20,
                              color: changeState==3? Colors.white:Colors.grey.shade200,)),
                          ),
                        )
                      ],
                    ),


                    const SizedBox(height: 80,),


                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          padding: const EdgeInsets.all(0),
                          fixedSize:  Size(size.width, 50),
                          shape: RoundedRectangleBorder(

                              side: const BorderSide(
                                  color: Color(0xffea8024)),
                              borderRadius:
                              BorderRadius.circular(15)),
                          backgroundColor: const Color(0xffea8024)),
                      onPressed: () {


                      },
                      child: Text(
                        tr('حفظ التغيرات'),
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