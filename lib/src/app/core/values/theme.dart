import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData of(context) {
    return ThemeData(
        primaryColorLight: accentColor,
        dialogBackgroundColor: primaryColor,
        cardColor: primaryColor,
        fontFamily: "tajawal",
        dividerColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: textColor),
        ), bottomAppBarTheme: BottomAppBarTheme(color: accentColor), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(background: Colors.white));
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}
