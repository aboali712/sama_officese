
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sama_officese/src/app.dart';

import '../../../../listen/listen_message_data.dart';
import '../../../core/values/colors.dart';
import '../../../home_core.dart';
import '../home_viewmodel.dart';
import 'Installments/Installments_view.dart';
import 'about_us/about_us_view.dart';
import 'contact_us/contact_us_view.dart';
import 'convesations_page/conversations_view.dart';
import 'more_viewModel.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends MoreViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      Consumer<MessageListenerService>(
        builder: (context, messageService, child) {


      return Scaffold(
        backgroundColor: Colors.white,
        appBar:  _buildAppBar(size),
        body:

        Stack(
            children: [ Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Flex(
                  direction: Axis.horizontal,
                  children: [ Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        _buildLanguageSelector(size),
                        const SizedBox(height: 20,),
                        _buildConversation( messageService,size),
                        const SizedBox(height: 20,),
                        _buildInstallment(size),
                        const SizedBox(height: 20,),
                        _buildConnectUs(size),
                        const SizedBox(height: 20,),
                        _buildAboutUs(size),
                        const SizedBox(height: 20,),
                        _buildUsageInstructions(size),
                        const SizedBox(height: 20,),
                        _buildPrivacy(size),
                        const SizedBox(height: 20,),
                        _buildDeleteAccount(size),
                        const SizedBox(height: 20,),
                        _buildLogout(size),
                        const SizedBox(height: 20,),
                        _buildInfo(size),
                        const SizedBox(height: 20,),





                      ]),
                    ),
                  ),
                  ]),
            ),

              _buildLoading(size),



            ]),


      );

    });



  }

  /// AppBar with a dynamic profile image and name
  AppBar _buildAppBar(Size size) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title:
      HomeViewModel.profileModel!.office!=null?
      Row(
        children: [
          const SizedBox(width: 5,),
          HomeViewModel.profileModel==null?
          Container(
            height: 50,width: 50,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xff8a8c8e),
                border: Border.all(width: 1.5,color: Colors.white)
            ),
            child:Center(child: SvgPicture.asset("assets/images/user.svg",)) ,)

              :  HomeViewModel.profileModel!.office!.image!=""|| HomeViewModel.profileModel!.office!.image !=null?
          Container(
            height: 70,width: 70,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff8a8c8e),
                border: Border.all(width: 1.5,color: Colors.white)
                ,image: DecorationImage(image:
                NetworkImage( HomeViewModel.profileModel!.office!.image!),fit: BoxFit.cover)
            ),
          )
              : Container(
            height: 50,width: 50,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xff8a8c8e),
                border: Border.all(width: 1.5,color: Colors.white)
            ),
            child:Center(child: SvgPicture.asset("assets/images/user.svg",)) ,),
          const SizedBox(width: 10,),


          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HomeViewModel.lang=="ar"?
                HomeViewModel.profileModel!.office!.name!
                    :  HomeViewModel.profileModel!.office!.nameEn!
                ,style: GoogleFonts.tajawal(color: Colors.white,
                  fontSize:15,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              HomeViewModel.profileModel!=null?
              Text(HomeViewModel.profileModel!.phone??"",
                style: GoogleFonts.tajawal(color: Colors.white,
                    fontSize:14,fontWeight: FontWeight.w400),)
                  :const SizedBox.shrink(),
            ],
          ),
        ],
      ):const SizedBox.shrink(),
      flexibleSpace:  Stack(
          children: [
            Container(height: 30,color: const Color(0xff231f20),),

            Image(
              image: const AssetImage('assets/images/signback.png'),
              fit: BoxFit.cover,width: size.width,
            ),
          ]),toolbarHeight: 130,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }


  /// Builds the language selector with buttons for Arabic and English
  Widget _buildLanguageSelector(Size size) {
    return   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          SvgPicture.asset("assets/images/local.svg",),
          const SizedBox(width: 15,),

          Text(tr("Language"),style: GoogleFonts.tajawal(color: Colors.black,
              fontSize:15,fontWeight: FontWeight.w500),),
        ],),

        Row(children: [
          SizedBox(height: 30,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                  fixedSize:  const Size(80, 35),
                  shape: RoundedRectangleBorder(

                      side:  BorderSide(
                          color: HomeViewModel.lang=="ar" ?const Color(0xff00A8A5)
                              :Colors.grey),
                      borderRadius:
                      BorderRadius.circular(50)),
                  backgroundColor:Colors.white70),
              onPressed: () {
                setState(() async {
                  HomeViewModel.lang="ar";
                  await context.setLocale(Locale(HomeViewModel.lang));
                  await saveLang(HomeViewModel.lang);
                  SamaOfficeApp.navKey.currentState!.pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeCore()));
                });

              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/flag.svg",),
                  const SizedBox(width: 5,),

                  Text(
                    tr('العربية'),
                    style:  TextStyle(
                        fontSize: 12,
                        color: HomeViewModel.lang=="ar"?Colors.black :Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5,),
          SizedBox(height: 30,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                  fixedSize:  const Size(80, 35),
                  shape: RoundedRectangleBorder(

                      side:  BorderSide(
                          color: HomeViewModel.lang=="en" ?const Color(0xff00A8A5)
                              :Colors.grey),
                      borderRadius:
                      BorderRadius.circular(50)),
                  backgroundColor: Colors.white70),
              onPressed: () {
                setState(() async {
                  HomeViewModel.lang="en";
                  await context.setLocale(Locale(HomeViewModel.lang));
                  await saveLang(HomeViewModel.lang);
                  SamaOfficeApp.navKey.currentState!.pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeCore()));
                });

              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/flagus.svg",),
                  const SizedBox(width: 5,),

                  Text(
                    tr('English'),
                    style:  TextStyle(
                        fontSize: 12,
                        color: HomeViewModel.lang=="en"?Colors.black :Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],)


      ],);
  }

  /// Builds the Conversation
  Widget _buildConversation(messageService,Size size,) {
    return   InkWell(
      onTap: (){

        SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const ConversationsView()),
        );
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Image.asset(
              "assets/images/conversations.png",height: 40,width: 40,),
            const SizedBox(width: 15,),

            Text(tr("Conversations"),style: GoogleFonts.tajawal(color: Colors.black,
                fontSize:15,fontWeight: FontWeight.w500),),
          ],),


          messageService.unreadThreadsCount!=0?
          Container(width: 25,height: 25,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius:  BorderRadius.circular(50),
                color: Colors.red
            ),
            child: Center(
              child: Text(
                "${messageService.unreadThreadsCount}",
                style: GoogleFonts.tajawal(
                    fontSize: 14, fontWeight: FontWeight.bold
                    ,color: Colors.white),
              ),
            ),
          ):const SizedBox.shrink(),
        ],
      ),





    );
  }

  /// Builds the installment
  Widget _buildInstallment(Size size,) {
    return    InkWell(
      onTap: (){

        SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const InstallmentsView()),
        );
      },
      child: Row(children: [
        Image.asset(
          "assets/images/installment.png",height: 35,width: 35,),
        const SizedBox(width: 15,),

        Text(tr("Installments"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),





    );
  }

  /// Builds the ConnectUs
  Widget _buildConnectUs(Size size,) {
    return    InkWell(onTap:
    MoreViewModel.settingsModel==null?(){}
        :() {
      SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const ContactUsView(),));
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/call.svg",),
        const SizedBox(width: 15,),

        Text(tr("ConnectUs"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the AboutUs
  Widget _buildAboutUs(Size size,) {
    return     InkWell(onTap: () {
      MoreViewModel.typePage="0";
      SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const AboutUs()));
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/whoare.svg",),
        const SizedBox(width: 15,),

        Text(tr("AboutUs"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the UsageInstructions
  Widget _buildUsageInstructions(Size size,) {
    return     InkWell(onTap: () {
      MoreViewModel.typePage="1";
      SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const AboutUs()));
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/uage.svg",),
        const SizedBox(width: 15,),

        Text(tr('UsageInstructions'),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the Privacy
  Widget _buildPrivacy(Size size,) {
    return InkWell(onTap: () {
      MoreViewModel.typePage="2";
      SamaOfficeApp.navKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const AboutUs()));
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/priv.svg",),
        const SizedBox(width: 15,),

        Text(tr("Privacy"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the DeleteAccount
  Widget _buildDeleteAccount(Size size,) {
    return InkWell(onTap: () {
      logoutApp();
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/dele.svg",),
        const SizedBox(width: 15,),

        Text(tr("DeleteAccount"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the Logout
  Widget _buildLogout(Size size,) {
    return  InkWell(onTap: () {
      logoutApp();
    },
      child: Row(children: [
        SvgPicture.asset("assets/images/exit.svg",),
        const SizedBox(width: 15,),

        Text(tr("Logout"),style: GoogleFonts.tajawal(color: Colors.black,
            fontSize:15,fontWeight: FontWeight.w500),),
      ],),
    );
  }

  /// Builds the Info
  Widget _buildInfo(Size size,) {
    return   SizedBox(
      width: 300,
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 0,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "© ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              Text(
                currentYear.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: samaColor),
              ),
              const SizedBox(width: 3,),
              Text(
                tr("AllRightsReservedLicenseNo"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],),
          Text(
            tr("AllRightsReserved"),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr("licenseNumber"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black),
              ),
              const Text(
                "73100173",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: samaColor),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr("CommercialRegistration"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black),
              ),
              const Text(
                "7015746378",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: samaColor),
              ),
            ],)
        ],
      ),
    );
  }

  /// Builds the Info
  Widget _buildLoading(Size size,) {
    return    isLoading==true?
    SizedBox(
        height: size.height/1,
        child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,
        )))
        :const SizedBox.shrink();
  }

}
