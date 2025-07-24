import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tick_done_app/theming/app_colors.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLightColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryLightColor,
        elevation: 0,
        centerTitle: true),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.brownColor,
      highlightElevation: 3,
      // shape: StadiumBorder(
      //     side: BorderSide(width: 3, color: AppColors.lightBeigeColor)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.brownColor,
        unselectedItemColor: AppColors.whiteColor,
        showUnselectedLabels: false),
/*    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.textButtonColor),
        overlayColor: MaterialStateProperty.all(AppColors.primaryLightColor.withOpacity(0.1)),
      ),
    ),*/
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.italiana(
        color: AppColors.whiteColor,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      bodySmall: TextStyle(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      titleLarge: TextStyle(
        color: AppColors.secondaryTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      titleSmall: TextStyle(
        color: AppColors.secondaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: 18,
      ),
      labelLarge:  TextStyle(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDarkColor,
    scaffoldBackgroundColor: AppColors.lightBlackColor,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDarkColor,
        elevation: 0,
        centerTitle: true),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.greyColor,
      highlightElevation: 3,
      // shape: StadiumBorder(
      //     side: BorderSide(width: 3, color: AppColors.lightBeigeColor)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.greyColor,
        unselectedItemColor: AppColors.whiteColor,
        showUnselectedLabels: false),
/*    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.textButtonColor),
        overlayColor: MaterialStateProperty.all(AppColors.primaryLightColor.withOpacity(0.1)),
      ),
    ),*/
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.italiana(
        color: AppColors.whiteColor,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      bodySmall: TextStyle(
        color: AppColors.lightWhiteColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      titleLarge: TextStyle(
        color: AppColors.beigeColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      titleSmall: TextStyle(
        color: AppColors.beigeColor,
        fontWeight: FontWeight.w300,
        fontSize: 18,
      ),
      labelLarge:  TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    ),
  );

}
