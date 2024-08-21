
import 'dart:io';
import 'package:easy_localization/easy_localization.dart'; // For localization support
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For handling SVG images
import 'package:google_fonts/google_fonts.dart'; // Google Fonts package
import 'package:provider/provider.dart'; // For state management

// Import project-specific views and view models
import 'package:sama_officese/src/app.dart'; // Main app navigation
import 'package:sama_officese/src/app/screen/home/packages/packages_view.dart'; // Packages view screen
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_view.dart'; // Packages order view screen
import 'package:sama_officese/src/app/screen/home/services/sevices_view.dart'; // Services view screen
import 'package:sama_officese/src/app/screen/home/update_profile/update_profile_view.dart'; // Update profile view screen

// Import necessary utilities and data listeners
import '../../../listen/listen_message_data.dart'; // For listening to message data
import '../../core/values/colors.dart'; // Color definitions
import 'create_package/create_package_view.dart'; // Create package view screen
import 'home_viewmodel.dart'; // Home view model

// HomePage widget represents the main screen of the home page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// _HomePageState class handles the state management for the home page
class _HomePageState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get the size of the screen

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 5,),
              // Display user profile picture or placeholder
              HomeViewModel.profileModel == null
                  ? Container(
                height: 50, width: 50,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff8a8c8e),
                    border: Border.all(width: 1.5, color: Colors.white)
                ),
                child: Center(child: SvgPicture.asset("assets/images/user.svg")),
              )
                  : HomeViewModel.profileModel!.image != "" || HomeViewModel.profileModel!.image != null
                  ? Container(
                height: 50, width: 50,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff8a8c8e),
                    border: Border.all(width: 1.5, color: Colors.white),
                    image: DecorationImage(image: NetworkImage(HomeViewModel.profileModel!.image!))
                ),
              )
                  : Container(
                height: 50, width: 50,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff8a8c8e),
                    border: Border.all(width: 1.5, color: Colors.white)
                ),
                child: Center(child: SvgPicture.asset("assets/images/user.svg")),
              ),
              const SizedBox(width: 10,),

              // Display welcome message and user's name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("welcomeBack"),
                    style: GoogleFonts.tajawal(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10,),
                  HomeViewModel.profileModel != null
                      ? SizedBox(
                    width: 250,
                    child: Text(
                      "${HomeViewModel.profileModel!.firstName ?? ""} ${HomeViewModel.profileModel!.lastName ?? ""}",
                      style: GoogleFonts.tajawal(color: Colors.white, fontSize: Platform.isIOS ? 16 : 15, fontWeight: FontWeight.w500),
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          // Background of the AppBar with an image
          flexibleSpace: Stack(
              children: [
                Container(height: 30, color: const Color(0xff231f20),),
                Image(
                  image: const AssetImage('assets/images/signback.png'),
                  fit: BoxFit.cover, width: size.width,
                ),
              ]
          ),
          toolbarHeight: 130,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Consumer<MessageListenerService>(
            builder: (context, messageService, child) {
              return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      // Row of buttons for account settings and package orders
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Account settings button
                                            InkWell(
                                              onTap: () {
                                                SamaOfficeApp.navKey.currentState!.push(
                                                    MaterialPageRoute(builder: (context) => const UpDateProfileView())
                                                );
                                              },
                                              child: Container(
                                                  height: 165, width: size.width / 2.2,
                                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xffCAD7E5),
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Icon and notifications badge
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 53, width: 58,
                                                              padding: const EdgeInsets.all(15),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xff00417e)
                                                              ),
                                                              child: SvgPicture.asset("assets/images/userbottom.svg"),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        // Account settings text
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              tr("accountSettings"),
                                                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        )
                                                      ]
                                                  )
                                              ),
                                            ),
                                            // Package orders button
                                            InkWell(
                                              onTap: () {
                                                SamaOfficeApp.navKey.currentState!.push(
                                                    MaterialPageRoute(builder: (context) => const PackagesOrderView())
                                                );
                                              },
                                              child: Container(
                                                  height: 165, width: size.width / 2.2,
                                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xffCAEBED),
                                                  ),
                                                  child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Icon and notifications badge
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 53, width: 58,
                                                              padding: const EdgeInsets.all(14),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xff00a8a5)
                                                              ),
                                                              child: SvgPicture.asset("assets/images/planee.svg"),
                                                            ),

                                                            Container(
                                                              height: 27, width: 27,
                                                              padding: const EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xff8A8C8E)
                                                              ),
                                                              child: Center(
                                                                child:
                                                                packages.isNotEmpty ?
                                                                Text(
                                                                  packages.isNotEmpty ? pendingPackageNumber : "0",
                                                                  style: GoogleFonts.tajawal(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
                                                                )
                                                               : const SizedBox(
                                                                  height: 15.0, // Set the desired height
                                                                  width: 15.0,  // Set the desired width
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors.white,
                                                                    strokeWidth: 1,    // Adjust the thickness of the progress indicator
                                                                    strokeAlign: 0.2,  // Custom stroke alignment if supported by your Flutter version
                                                                  ),
                                                                ),

                                                              ),
                                                            )




                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        // Package requests text
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              tr("PackageRequests"),
                                                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                            ),

                                                            packagePending.isNotEmpty?
                                                            Text(
                                                              packagePending.isNotEmpty
                                                                  ? "${pendingPackageNumber} ${tr("newRequests")}"
                                                                  : tr("ThereAreCurrentlyNoRequests"),
                                                              style: TextStyle(color: Colors.grey, fontSize: packagePending.isNotEmpty ? 13 : 12, fontWeight: FontWeight.w400),
                                                            )
                                                            :Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15.0, // Set the desired height
                                                                  width: 15.0,  // Set the desired width
                                                                  child: CircularProgressIndicator(
                                                                    color: samaOfficeColor,
                                                                    strokeWidth: 1,    // Adjust the thickness of the progress indicator
                                                                    strokeAlign: 0.2,  // Custom stroke alignment if supported by your Flutter version
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 3,),
                                                                Text(
                                                                  tr("ThereAreCurrentlyNoRequests"),
                                                                  style: TextStyle(color: Colors.grey, fontSize: packagePending.isNotEmpty ? 13 : 12, fontWeight: FontWeight.w400),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ]
                                                  )







                                              ),
                                            ),
                                          ]
                                      ),
                                      const SizedBox(height: 20,),
                                      // Row of buttons for viewing packages and creating a new package
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // View packages button
                                            InkWell(
                                              onTap: () {
                                                SamaOfficeApp.navKey.currentState!.push(
                                                    MaterialPageRoute(builder: (context) => const PackagesView())
                                                );
                                              },
                                              child: Container(
                                                  height: 165, width: size.width / 2.2,
                                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xffF8E3D3),
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Icon and notifications badge
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 53, width: 58,
                                                              padding: const EdgeInsets.all(14),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xffea8024)
                                                              ),
                                                              child: SvgPicture.asset("assets/images/plancc.svg"),
                                                            ),
                                                            Container(
                                                              height: 27, width: 27,
                                                              padding: const EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xff5AC41A)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  offerPageModel!.isNotEmpty ? offerPageModel!.length.toString() : "0",
                                                                  style: GoogleFonts.tajawal(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        // Packages text
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              tr("Packages"),
                                                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                            ),
                                                            Text(
                                                              offerPageModel!.isNotEmpty
                                                                  ? " ${tr("Packages")} ${offerPageModel!.length}"
                                                                  : tr("ThereAreNoPackages"),
                                                              style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
                                                            ),
                                                          ],
                                                        )
                                                      ]
                                                  )
                                              ),
                                            ),
                                            // Create package button
                                            InkWell(
                                              onTap: () {
                                                SamaOfficeApp.navKey.currentState!.push(
                                                    MaterialPageRoute(builder: (context) => const CreatePackageView())
                                                );
                                              },
                                              child: Container(
                                                  height: 165, width: size.width / 2.2,
                                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xffE5E6E8),
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Icon for creating a package
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 53, width: 58,
                                                              padding: const EdgeInsets.all(14),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                  color: const Color(0xff8a8c8e)
                                                              ),
                                                              child: SvgPicture.asset("assets/images/add.svg"),
                                                            ),
                                                            const SizedBox(width: 27,),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 30,),
                                                        // Create package text
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              tr("CreatePackage"),
                                                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        )
                                                      ]
                                                  )
                                              ),
                                            ),
                                          ]
                                      ),
                                      const SizedBox(height: 50,),

                                      // Display unread messages count if there are any unread threads
                                      messageService.unreadThreadsCount != 0
                                          ? Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/conversations.png",
                                                  height: 80,
                                                  width: 80,
                                                  color: samaColor,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${messageService.unreadThreadsCount}",
                                                    style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]
                                      )
                                          : const SizedBox.shrink(),
                                    ]
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    // Show loading indicator if data is still being fetched
                    isLoading == true
                        ? SizedBox(
                        height: size.height / 1,
                        child: const Center(child: CircularProgressIndicator(color: samaOfficeColor))
                    )
                        : const SizedBox.shrink(),
                  ]
              );
            }
        )
    );
  }
}
