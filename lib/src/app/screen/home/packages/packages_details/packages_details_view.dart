import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/home_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/values/colors.dart';
import '../update_package/upDate_viewModel.dart';

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

             offer!=null?
              CarouselSlider(
                items: offer!.images
                    !.map(
                      (e) => GestureDetector(
                      onTap: () {


                        MultiImageProvider multiImageProvider =
                        MultiImageProvider(offer!.images!.map((e) =>
                        Image.network(e.image!).image).toList());
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
                                  e.image!),
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
              )
                 :const SizedBox.shrink(),



               offer!=null?
              Positioned(bottom: 20,left: 210,right: 210,
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: offer!.images!.length,
                  effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey.shade400,
                      activeDotColor: const Color(0xffea8024)),
                ),
              )
              :const SizedBox.shrink(),

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
      body:
      offer!=null?
      Stack(
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
                            Text(
                              HomeViewModel.lang=="ar"?
                              offer!.nameAr!
                              :offer!.nameEn!
                              ,style: GoogleFonts.tajawal(color: Colors.black,
                                fontSize:15,fontWeight: FontWeight.w500),),

                            Row(children: [
                              SvgPicture.asset("assets/images/calender.svg") ,
                              const SizedBox(width: 10,),

                              Text("${offer!.numOfDays} ${tr("Days")} ${offer!.num_of_nights} ${tr("Nights")}",
                                style: GoogleFonts.tajawal(color: Colors.black,
                                    fontSize:14,fontWeight: FontWeight.w400),),

                              const SizedBox(width: 10,),

                              Text("${offer!.startDate} - ${offer!.endDate}",style: GoogleFonts.tajawal(color: Colors.grey,
                                  fontSize:12,fontWeight: FontWeight.w400),),
                            ],),



                            Row(
                              children: [
                                SvgPicture.asset("assets/images/money.svg") ,
                                const SizedBox(width: 10,),

                                Text("${offer!.priceAfter!} ${tr("Sar")}",style: GoogleFonts.tajawal(
                                    color:const Color(0xff00A8A5),
                                    fontSize:15,fontWeight: FontWeight.w400),),
                                const SizedBox(width: 10,),

                                Text("${offer!.priceBefore!} ${tr("Sar")}",
                                  style: GoogleFonts.tajawal(color:Colors.grey,
                                      fontSize:15,fontWeight: FontWeight.w400),),


                              ],),




                            Row(
                              children: [
                                SvgPicture.asset("assets/images/packplan.svg") ,
                                const SizedBox(width: 10,),

                                Text(tr("${tr("TripType")} :"),style: GoogleFonts.tajawal(
                                    color:Colors.black,
                                    fontSize:15,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 10,),

                                Text(
                                  offer!.type=="normal"?
                                  tr("Normal")
                                 :tr("Weekend")

                                  ,style: GoogleFonts.tajawal(color:Colors.black,
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
                                Text(offer!.num_of_persons!.toString(),
                                  style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                    fontSize:17,fontWeight: FontWeight.w500),),

                                Text(tr("TotalNumberOfPeople"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:10,fontWeight: FontWeight.w500),),
                              ],),


                              SizedBox(height: 50,
                                child: VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),



                              Column(children: [
                                Text(offer!.num_of_reserved_persons.toString(),
                                  style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                    fontSize:17,fontWeight: FontWeight.w500),),

                                Text(tr("numOfReservedPersons"),style: GoogleFonts.tajawal(color:Colors.grey,
                                    fontSize:10,fontWeight: FontWeight.w500),),
                              ],),


                              SizedBox(height: 50,
                                child: VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),



                              Column(children: [
                                Builder(
                                  builder: (context) {
                                    var result= offer!.num_of_persons!-
                                        int.parse(offer!.num_of_reserved_persons.toString()??"");
                                    return Text(result.toString(),style: GoogleFonts.tajawal(color: const Color(0xff00A8A5),
                                        fontSize:17,fontWeight: FontWeight.w500),);
                                  }
                                ),

                                SizedBox(width: 75,
                                  child: Text(tr("TheRemainingNumber"),style: GoogleFonts.tajawal(color:Colors.grey,
                                      fontSize:10,fontWeight: FontWeight.w500),),
                                ),
                              ],),




                            ],),
                        ),
                      ),

                      Divider(height: 10,thickness: 1,color: Colors.grey.shade300,),
                          const SizedBox(height: 10,),

                      Text(tr("Details"),style: GoogleFonts.tajawal(color: Colors.black,
                          fontSize:17,fontWeight: FontWeight.w500),),

                          const SizedBox(height: 15,),


                          Text(
                            HomeViewModel.lang=="ar"?
                            offer!.descriptionAr!
                            :offer!.descriptionEn!,
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
          isLoading==true?
          SizedBox(
              height: size.height/1.5,
              child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
              )))
              :const SizedBox.shrink(),



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
                    Text(tr("PackageCondition"),style: GoogleFonts.tajawal(color: Colors.black,
                        fontSize:15,fontWeight: FontWeight.w500),),
                    const SizedBox(width: 8,),
                    Text(
                      offer!.status=="active"?
                      tr("ActiveNow")
                      :tr("ClosedNow"),style: GoogleFonts.tajawal(
                        color: offer!.status=="active"?
                          const Color(0xff7DC11F)
                        :Colors.red,
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
                               changeOfferApi( offer!.status=="active" ? "inactive":"active");
                             });
                              print(val);
                            },
                          ),



                        ],
                      ),
                      const SizedBox(height: 20,),

                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                            fixedSize:  Size(size.width-20, 50),
                            shape: RoundedRectangleBorder(

                                side: const BorderSide(
                                    color: Color(0xff00A8A5)),
                                borderRadius:
                                BorderRadius.circular(15)),
                            backgroundColor: const Color(0xff00A8A5)),
                        onPressed: () {
                          UpDateViewModel.offerModel=offer;
                          SamaOfficeApp.navKey.currentState!.pushReplacement(
                              MaterialPageRoute(builder: (context) => const UpDateView(),));

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



      ])
      : SizedBox(
          height: size.height/1.5,
          child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
          ))),


    );
  }
}
