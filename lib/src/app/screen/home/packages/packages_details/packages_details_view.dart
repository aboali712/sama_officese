import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/values/colors.dart';

class PackagesDetails extends StatefulWidget {
  const PackagesDetails({Key? key}) : super(key: key);

  @override
  State<PackagesDetails> createState() => _PackagesDetailsState();
}

class _PackagesDetailsState extends PackagesDetailsVieModel {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFF),
      appBar: AppBar(

        flexibleSpace:  Stack(
            children: [


              CarouselSlider(
                items: productImage
                    .map(
                      (e) => GestureDetector(
                      onTap: () {


                        MultiImageProvider multiImageProvider =
                        MultiImageProvider(productImage.map((e) =>
                        Image.network(e.url).image).toList());
                        showImageViewerPager(context, multiImageProvider,
                            swipeDismissible: true, doubleTapZoomable: true);
                      },
                      child: Hero(
                        tag: 'imageHero',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                  e.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                )
                    .toList(),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {

                    setState(() {
                      activeIndex = index;
                    });
                  },
                  height: 350.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 1500),
                  viewportFraction: 1,
                ),
              ),




              Positioned(bottom: 20,left: 210,right: 210,
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: productImage.length,
                  effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey.shade400,
                      activeDotColor: const Color(0xffea8024)),
                ),
              ),

              InkWell( onTap: () {
                Navigator.pop(context);
              }
                  ,child: const Padding(
                    padding: EdgeInsets.only(left: 30,right: 30,top: 50),
                    child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  )),

            ] ),toolbarHeight: 255,
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
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const SizedBox(height: 10,),

                      SizedBox(height: 110,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr("رحلة سنغافورة السياحية"),style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:15,fontWeight: FontWeight.w500),),

                            Row(children: [
                              SvgPicture.asset("assets/images/calender.svg") ,
                              const SizedBox(width: 10,),

                              Text(tr("7أيام و 6ليالى"),style: GoogleFonts.tajawal(color: Colors.black,
                                  fontSize:14,fontWeight: FontWeight.w400),),

                              const SizedBox(width: 10,),

                              Text(tr("24نوفمبر - 30نوفمبر"),style: GoogleFonts.tajawal(color: Colors.grey,
                                  fontSize:12,fontWeight: FontWeight.w400),),
                            ],),



                            Row(
                              children: [
                                SvgPicture.asset("assets/images/money.svg") ,
                                const SizedBox(width: 10,),

                                Text(tr("3600 ر.س"),style: GoogleFonts.tajawal(
                                    color:const Color(0xff00A8A5),
                                    fontSize:15,fontWeight: FontWeight.w400),),
                                const SizedBox(width: 10,),

                                Text(tr("4000 ر.س"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:15,fontWeight: FontWeight.w400),),


                              ],),




                            Row(
                              children: [
                                SvgPicture.asset("assets/images/packplan.svg") ,
                                const SizedBox(width: 10,),

                                Text(tr("نوع الرحلة :"),style: GoogleFonts.tajawal(
                                    color:Colors.black,
                                    fontSize:15,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 10,),

                                Text(tr("جماعى"),style: GoogleFonts.tajawal(color:Colors.black,
                                    fontSize:15,fontWeight: FontWeight.w500),),


                              ],),

                          ],
                        ),
                      ),


                      const SizedBox(height: 10,),

                      Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),


                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child: SizedBox(height: 60,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Column(children: [
                                Text(tr("1"),style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                    fontSize:17,fontWeight: FontWeight.w500),),

                                Text(tr("أجمالى عدد الأشخاص"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:10,fontWeight: FontWeight.w500),),
                              ],),


                              SizedBox(height: 50,
                                child: VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),



                              Column(children: [
                                Text(tr("3"),style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                    fontSize:17,fontWeight: FontWeight.w500),),

                                Text(tr("عدد المحجوزين"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:10,fontWeight: FontWeight.w500),),
                              ],),


                              SizedBox(height: 50,
                                child: VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),



                              Column(children: [
                                Text(tr("2"),style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                    fontSize:17,fontWeight: FontWeight.w500),),

                                Text(tr("العدد المتبقى"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:10,fontWeight: FontWeight.w500),),
                              ],),




                            ],),
                        ),
                      ),

                      Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),
                          const SizedBox(height: 10,),

                      Text(tr("التفاصيل"),style: GoogleFonts.tajawal(color: Colors.black,
                          fontSize:17,fontWeight: FontWeight.w500),),

                          const SizedBox(height: 15,),


                          Text(tr("اكتشف اجمل المناطق السياحية في سنغافورة يشمل"
                              " النقل والتوصيل من والي المطار + رحلات يومية + فنادق ٤ و ٥ نجوم مع الافطار"),
                            style: GoogleFonts.tajawal(color: Colors.black,
                              fontSize:14,fontWeight: FontWeight.w400),),
                          const SizedBox(height: 10,),


                          Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),

                      const SizedBox(height: 30,),


                    ]),
                  ),
                ),
              ),
              ]),
        ),



          Positioned(bottom: -5,left: -5,right: -5,
            child: Card( elevation: 20,color: Colors.white,shape: const RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(25)
                    ,topRight:Radius.circular(25) )),
              child: Container(height: 135,width: size.width,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25)
                        ,topRight:Radius.circular(25) )),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                  Row(children: [
                    Text(tr("حالة الباكدج"),style: GoogleFonts.tajawal(color: Colors.black,
                        fontSize:15,fontWeight: FontWeight.w500),),
                    const SizedBox(width: 8,),
                    Text(tr("نشط الأن"),style: GoogleFonts.tajawal(color: const Color(0xff7DC11F),
                        fontSize:12,fontWeight: FontWeight.w500),),
                  ],),



                          FlutterSwitch(
                            inactiveColor: Colors.grey.shade300,
                            activeColor: const Color(0xff7DC11F),
                            width: 55,
                            height: 25.0,
                            valueFontSize: 25.0,
                            toggleSize: 25.0,
                            value: switchValue,
                            borderRadius: 30.0,
                            padding: 3.0,
                            showOnOff: false,
                            onToggle: (val) {
                             setState(() {
                               switchValue=val;
                             });
                              print(val);
                            },
                          ),



                        ],
                      ),
                      const SizedBox(height: 20,),

                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            padding: const EdgeInsets.all(0),
                            fixedSize:  Size(size.width-20, 50),
                            shape: RoundedRectangleBorder(

                                side: const BorderSide(
                                    color: Color(0xff00A8A5)),
                                borderRadius:
                                BorderRadius.circular(15)),
                            backgroundColor: const Color(0xff00A8A5)),
                        onPressed: () {


                        },
                        child: Text(
                         tr('تعديل الباكدج'),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
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
