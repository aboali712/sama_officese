import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_viewmodel.dart';

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
                const Text(
                  "الباكيدجات",
                  style: TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Flex(direction: Axis.horizontal,
            children: [ Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                   const SizedBox(height: 10,),


                  Column(children: [1,2,3,4,5].map((e) =>
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
                                                image: const DecorationImage(image: AssetImage("assets/images/packpic.png"),
                                                    fit: BoxFit.cover ) ),
                                          ),
                                          const SizedBox(width: 10,),

                                          SizedBox(height: 90,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(tr("رحلة سنغافورة السياحية"),style: GoogleFonts.tajawal(
                                                    color: Colors.black,
                                                    fontSize:15,fontWeight: FontWeight.w500),),

                                                Row(children: [
                                                  SvgPicture.asset("assets/images/calender.svg") ,
                                                  const SizedBox(width: 10,),

                                                  Text(tr("7أيام و 6ليالى"),style: GoogleFonts.tajawal(color: Colors.black,
                                                      fontSize:14,fontWeight: FontWeight.w400),),


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

                                          Text(tr("نشط الأن"),style: GoogleFonts.tajawal(color: const Color(0xff7DC11F),
                                              fontSize:13,fontWeight: FontWeight.w400),),


                                          InkWell(onTap: () {
                                      SamaOfficeApp.navKey.currentState!.push(
                                          MaterialPageRoute(builder: (context) => const PackagesDetails(),));
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

                    ,).toList(),),





                  const SizedBox(height: 30,),


                ]),
              ),
            ),
            ]),
      ),


    );
  }
}
