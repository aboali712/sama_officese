import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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




              Positioned(bottom: 20,
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: productImage.length,
                  effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey.shade400,
                      activeDotColor: Colors.black),
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Flex(direction: Axis.horizontal,
            children: [ Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10,),




                   Text("data"),



                  const SizedBox(height: 30,),


                ]),
              ),
            ),
            ]),
      ),


    );
  }
}
