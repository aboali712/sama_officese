import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_officese/src/app.dart';

import '../../../auth/login/loginPage.dart';
import '../../../core/local/storagehelper.dart';
import '../../../core/values/colors.dart';



class ChooseLang extends StatefulWidget {
  const ChooseLang({Key? key}) : super(key: key);

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> with StorageHelper {

  String lang="ar";
  @override
  void initState() {
    getLangApp();
    super.initState();
  }
  Future<void> getLangApp()  async {

       getLang().then((value) =>
       {
         setState((){
           lang=value??"ar";

         })
       });


  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
             Center(
               child: SvgPicture.asset("assets/images/Group.svg",
                   height: 200,width: size.width,fit: BoxFit.cover,),
             ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                tr("Select_Preferred_Language"),
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                InkWell(onTap: () {
                  setState(() {
                    lang="ar";
                  });

                },
                  child: Container( height: 140,width: 155,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(20) ,
                    color: lang=="ar"? const Color(0xffFCF9F9): Colors.white,
                    border: Border.all( width:lang=="ar"?1.5: .6,
                        color:lang=="ar" ?Colors.green: Colors.grey)
                  ),child: Column(children: [
                    const SizedBox(height: 10,),
                    Image.asset("assets/images/flag.png",height: 35,width: 45,fit: BoxFit.cover,),
                      const SizedBox(height: 20,),
                    Text(
                      "العربية",
                      style: TextStyle(
                          color: lang=="ar" ?Colors.green : Colors.grey,
                          fontSize: 19, fontWeight: FontWeight.w500),
                    )
                  ]),),
                ),


                InkWell(onTap: () {
                  setState(() {
                    lang="en";
                  });
                },
                  child: Container( height: 140,width: 155,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(20) ,
                        color:lang=="en"? const Color(0xffFCF9F9): Colors.white,
                        border: Border.all( width:lang=="en"?1.5: .6,
                            color:lang=="en" ?Colors.green: Colors.grey)
                    ),child: Column(children: [
                      const SizedBox(height: 10,),
                      Image.asset("assets/images/flagusa.png",height: 35,width: 45,fit: BoxFit.cover,),
                      const SizedBox(height: 20,),
                      Text(
                        "English",
                        style: TextStyle(
                            color: lang=="en" ?Colors.green : Colors.black,
                            fontSize: 19, fontWeight: FontWeight.w500),
                      )
                    ]),),
                ),


              ],
            ),

            const SizedBox(height: 70,),
            Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0ffea8024),
                      fixedSize: const Size(110, 45),
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(color: samaColor),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                  onPressed: () async {
                    print(lang);
                    await context.setLocale(Locale(lang));
                    await saveLang(lang);
                    await setFirst(false);
                    SamaOfficeApp.navKey.currentState!.pushReplacement(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                
                  },
                  child:  Text(
                    tr("Accept"),
                    style: const TextStyle(
                        color:Colors.white,
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )),
            ),


          ],
        ),
      ),
    );
  }
}
