import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/packages_order_details_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/values/colors.dart';
import '../../packages/packages_details/packages_details_view.dart';
import '../../packages/packages_details/packages_details_viewmodel.dart';

class PackagesOrderDetailsView extends StatefulWidget {
  const PackagesOrderDetailsView({Key? key}) : super(key: key);

  @override
  State<PackagesOrderDetailsView> createState() => _PackagesOrderDetailsViewState();
}

class _PackagesOrderDetailsViewState extends PackagesOrderDetailsViewModel {
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
                  "#${packageDetails!.id!}",
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
                      Text(tr("25Feb,2023"),style: GoogleFonts.tajawal(color: Colors.white,
                          fontSize:13,fontWeight: FontWeight.w400),),
                    ],
                  ),

                  Container(height: 25,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),
                        color:const Color(0xff5AC41A) ),
                    child: Center(
                      child: Text(
                        packageDetails!.status=="pending"?
                        tr("جديد")
                            : packageDetails!.status=="inReview"?
                        tr("قيد التنفيذ")
                            : packageDetails!.status=="canceled"  ?
                        tr("ملغى")
                            : packageDetails!.status=="completed"?
                        tr("مكتمل")
                            :tr("قيد التنفيذ")
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
          children: [
            SizedBox(height: size.height,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Flex(direction: Axis.horizontal,
                children: [ Expanded(
                  child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                          image: NetworkImage(packageDetails!.user!.image!),
                                            fit: BoxFit.cover )
                                    ),
                                  ),

                                  const SizedBox(width: 10,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${packageDetails!.user!.firstName!} ${packageDetails!.user!.lastName}",
                                        style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:15,fontWeight: FontWeight.w500),),
                                      Text(packageDetails!.user!.phone!,style: GoogleFonts.tajawal(color: Colors.black,
                                          fontSize:13,fontWeight: FontWeight.w400),),

                                    ],)
                                ],),

                                InkWell(onTap: () {
                                  launchUrl(Uri.parse(
                                      "tel://${packageDetails!.user!.phone!}"));

                                },child: SvgPicture.asset("assets/images/phone.svg"))


                              ],
                            ),
                          ) ,
                        ),
                      ),
                      const SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(tr("تفاصيل الحجز"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:17,fontWeight: FontWeight.w500),),
                      ),
                      const SizedBox(height: 5,),
                      Column(children: [1].map((e) =>
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
                                          child: Row(
                                            children: [


                                             Container(height: 90,width: 115,
                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                             image:  DecorationImage(image: NetworkImage(packageDetails!.offer!.image!),
                                             fit: BoxFit.cover ) ),
                                             ),
                                              const SizedBox(width: 10,),

                                              SizedBox(height: 90,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                           Text(
                                                  HomeViewModel.lang=="ar"?
                                                      packageDetails!.offer!.nameAr!
                                                      :packageDetails!.offer!.nameEn!
                                                  ,style: GoogleFonts.tajawal(color: Colors.black,
                                                        fontSize:15,fontWeight: FontWeight.w500),),

                                                    Row(children: [
                                                      SvgPicture.asset("assets/images/calender.svg") ,
                                                      const SizedBox(width: 10,),

                Text("${packageDetails!.offer!.numOfDays} ${tr("أيام")} -"
                    " ${packageDetails!.offer!.num_of_nights} ${tr("ليالى")}",
                              style: GoogleFonts.tajawal(color: Colors.black,
                                                          fontSize:14,fontWeight: FontWeight.w400),),


                                                    ],),



                                                    Row(
                                                      children: [
                                                      SvgPicture.asset("assets/images/money.svg") ,
                                                      const SizedBox(width: 10,),

                     Text("${packageDetails!.offer!.priceBefore!} ${tr("Sar")}",
                       style: GoogleFonts.tajawal(
                                                          color:const Color(0xff00A8A5),
                                                          fontSize:15,fontWeight: FontWeight.w400),),
                                                      const SizedBox(width: 10,),

                    Text("${packageDetails!.offer!.priceAfter!} ${tr("Sar")}",
                      style: GoogleFonts.tajawal(color:Colors.grey,
                                                          fontSize:15,fontWeight: FontWeight.w400),),


                                                    ],)




                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),




                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                          child: SizedBox(height: 80,
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [

                                              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                               Column(children: [
                                           Text(DateFormat.MMMd().format(DateTime.parse(packageDetails!.offer!.startDate!)),
                                                 style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                                     fontSize:17,fontWeight: FontWeight.w500),),

                                      Text(DateFormat.EEEE().format(DateTime.parse(packageDetails!.offer!.startDate!)),
                                                   style: GoogleFonts.tajawal(color:Colors.grey,
                                                     fontSize:11,fontWeight: FontWeight.w500),),
                                               ],),

                                                Text(tr("الفترة من"),style: GoogleFonts.tajawal(color:Colors.black,
                                                    fontSize:13,fontWeight: FontWeight.w500),),


                                              ],),


                                              SizedBox(height: 60,
                                                child: VerticalDivider(
                                                  color: Colors.grey.shade300,
                                                  thickness: 1,
                                                ),
                                              ),



                                              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(children: [
                                        Text(DateFormat.MMMd().format(DateTime.parse(packageDetails!.offer!.endDate!)),
                                                      style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                                          fontSize:17,fontWeight: FontWeight.w500),),

                                        Text(DateFormat.EEEE().format(DateTime.parse(packageDetails!.offer!.endDate!)),
                                                      style: GoogleFonts.tajawal(color:Colors.grey,
                                                          fontSize:11,fontWeight: FontWeight.w500),),
                                                  ],),

                                                  Text(tr("الفترة الى"),style: GoogleFonts.tajawal(color:Colors.black,
                                                      fontSize:13,fontWeight: FontWeight.w500),),


                                                ],),


                                              SizedBox(height: 60,
                                                child: VerticalDivider(
                                                  color: Colors.grey.shade300,
                                                  thickness: 1,
                                                ),
                                              ),



                                              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(children: [
                                           Text("${packageDetails!.offer!.num_of_persons!.toString()} ${tr("أفراد")}",
                                             style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                                        fontSize:17,fontWeight: FontWeight.w500),),

                                            Text("${packageDetails!.adultsCount!} ${tr("فرد")} -"
                                                " ${packageDetails!.childrenCount} ${tr("أطفال")}",
                                                      style: GoogleFonts.tajawal(color:Colors.grey,
                                                        fontSize:11,fontWeight: FontWeight.w500),),
                                                  ],),

                                                  Text(tr("عدد الضيوف"),style: GoogleFonts.tajawal(color:Colors.black,
                                                      fontSize:13,fontWeight: FontWeight.w500),),


                                                ],),




                                            ],),
                                          ),
                                        ),

                                        Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),


                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: InkWell(onTap: () {
                                          setState(() {
                                            PackagesDetailsVieModel.offerId=packageDetails!.offer!.id.toString();
                                          });
                                SamaOfficeApp.navKey.currentState!.push(
                                    MaterialPageRoute(builder: (context) => const PackagesDetails(),));
                                          },
                                            child: Row(children: [
                                              Text(tr("المزيد من المعلومات"),style: GoogleFonts.tajawal(color: Colors.blue,
                                                  fontSize:13,fontWeight: FontWeight.w400),),
                                              const SizedBox(width: 20,),

                                              const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)

                                            ],),
                                          ),
                                        ),

                                      ]) ,
                                ),
                              ),
                              const SizedBox(height: 10,)
                            ],
                          )

                        ,).toList(),),

                      const SizedBox(height: 30,),


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
              child: Card( elevation: 20,color: Colors.white,shape: const RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(25)
                      ,topRight:Radius.circular(25) )),
                child: Container(height: 120,width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25)
                          ,topRight:Radius.circular(25) )),

                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("تغير حالة الطلب"),style: GoogleFonts.tajawal(color: Colors.black,
                            fontSize:15,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 10,),

                        InkWell(onTap: () {
                          setState(() {
                            changeState=packageDetails!.status!;
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
                                    packageDetails!.status=="pending"?
                                    tr("جديد")
                                        : packageDetails!.status=="inReview"?
                                    tr("قيد التنفيذ")
                                        : packageDetails!.status=="canceled"  ?
                                    tr("ملغى")
                                        : packageDetails!.status=="completed"?
                                    tr("مكتمل")
                                        :tr("قيد التنفيذ")
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
