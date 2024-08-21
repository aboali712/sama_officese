import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_officese/src/app/core/values/colors.dart';





Future<void> showMyDialogUpDate(BuildContext context,Function()? onTap) async {
  Size size = MediaQuery.of(context).size;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user can tap outside to dismiss
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Exit the app if the back button is pressed
          SystemNavigator.pop();
          return false; // Prevent default back button behavior
        },
        child: AlertDialog(
          backgroundColor: Colors.white,
          elevation: 5,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        // Add your logo image here
                        SvgPicture.asset("assets/images/logo1.svg",height: 50,width:80,),
                        const SizedBox(height: 30),
                        // Add your update formula here
                        Text(
                          tr("ThereIsANew"),
                          style: GoogleFonts.tajawal(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),


                        const SizedBox(height: 20),
                        TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size(size.width - 100, 40),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: samaColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: samaColor,
                          ),
                          onPressed: () async {
                            onTap!();
                          },
                          child: Text(
                            tr("update"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

