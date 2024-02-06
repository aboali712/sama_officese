import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_viewmodel.dart';
import 'package:sama_officese/src/app/screen/home/packages/update_package/upDate_viewModel.dart';

import '../../../core/values/colors.dart';
import '../home_viewmodel.dart';

class PackagesView extends StatefulWidget {
  const PackagesView({Key? key}) : super(key: key);

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends PackagesViewModel {
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
                  tr("Packages"),
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
              Container(height: 30,color: const Color(0xffea8024),),
              Image(
                image: const AssetImage('assets/images/packages.png'),
                fit: BoxFit.cover,width: size.width,
              ),
            ] ),toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Flex(direction: Axis.horizontal,
              children: [ Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                     const SizedBox(height: 10,),

                     offerPageModel!.isNotEmpty?
                    Column(children:
                    offerPageModel!.isNotEmpty?
                    offerPageModel!.map((e) =>
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
                                   image:  DecorationImage(image: NetworkImage(e.image!),
                                                      fit: BoxFit.cover ) ),
                                            ),
                                            const SizedBox(width: 10,),

                                            SizedBox(height: 90,
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    HomeViewModel.lang=="ar"?
                                                    e.nameAr!
                                                    :e.nameEn!
                                                    ,style: GoogleFonts.tajawal(
                                                      color: Colors.black,
                                                      fontSize:15,fontWeight: FontWeight.w500),),

                                                  Row(children: [
                                                    SvgPicture.asset("assets/images/calender.svg") ,
                                                    const SizedBox(width: 10,),

                                           Text("${e.numOfDays} ${tr("Days")} ${e.num_of_nights} ${tr("Nights")}",
                                                      style: GoogleFonts.tajawal(color: Colors.black,
                                                        fontSize:14,fontWeight: FontWeight.w400),),


                                                  ],),



                                                  Row(
                                                    children: [
                                                      SvgPicture.asset("assets/images/money.svg") ,
                                                      const SizedBox(width: 10,),

                                                      Text("${e.priceAfter!} ${tr("Sar")}",style: GoogleFonts.tajawal(
                                                          color:const Color(0xff00A8A5),
                                                          fontSize:15,fontWeight: FontWeight.w400),),
                                                      const SizedBox(width: 10,),

                                                      Text("${e.priceBefore!} ${tr("Sar")}",
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              e.status=="active"?
                                              tr("نشط الأن")
                                              :tr("مغلق الأن")
                                              ,style: GoogleFonts.tajawal(color:
                                            e.status=="active"?
                                            const Color(0xff7DC11F)
                                                :Colors.red,
                                                fontSize:13,fontWeight: FontWeight.w400),),


                                            InkWell(onTap: () {
                                              UpDateViewModel.offerModel=e;
                                              PackagesDetailsVieModel.offerId=e.id.toString();
                                              SamaOfficeApp.navKey.currentState!.push(
                                                  MaterialPageRoute(builder: (context) =>const PackagesDetails() ,));
                                            },
                                              child: Row(children: [
                                                Text(tr("المزيد من المعلومات"),style: GoogleFonts.tajawal(color: Colors.blue,
                                                    fontSize:13,fontWeight: FontWeight.w400),),
                                                const SizedBox(width: 10,),

                                                const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,)

                                              ],),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ]) ,
                              ),
                            ),
                            const SizedBox(height: 10,)
                          ],
                        )

                      ,).toList() :[],)
                         :Container(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height / 5),
                       child: Column(
                         children: [
                           SvgPicture.asset("assets/images/empty_orders.svg"),
                           const SizedBox(
                             height: 20,
                           ),
                           Text(
                             tr("NoPackages"),
                             style: const TextStyle(
                                 fontSize: 17, fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           Text(textAlign: TextAlign.center,
                             tr("NoPackagesDes"),
                             style: const TextStyle(
                                 fontSize: 15, fontWeight: FontWeight.w500),
                           ),
                         ],
                       ),
                     ),





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



        ]),


    );
  }
}
