import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppStyles {
  static final mainTheme = ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: AppColors.blue,
    accentColor: AppColors.green_jdm_arrow,
    scaffoldBackgroundColor: AppColors.white,
    bottomAppBarColor: AppColors.white,
    canvasColor: AppColors.white,
    unselectedWidgetColor: AppColors.grey,
    errorColor: AppColors.red,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent
    ),
    iconTheme: IconThemeData(
      color: AppColors.grey,
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: AppColors.white,
      textTheme: TextTheme(
        headline4: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.green_jdm_arrow),
          //The color of the textStyle is typically not used directly, the foregroundColor is used instead.
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          elevation: MaterialStateProperty.all<double>(0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextTheme().button
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
        )
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red,
      splashColor: AppColors.blue,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black,
          fontSize: 24,
        fontWeight: FontWeight.w400
      ),
      headline2: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400
      ),
      headline3: TextStyle(
          color: Colors.black,
          fontSize: 16,
      ),
      //Appbar
      headline6: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      overline: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        fontSize: 14.0,
      ),
      button: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
        color: AppColors.white,
      ),
      subtitle1: TextStyle(
        color: AppColors.grey,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle:
      TextStyle(color: AppColors.green_jdm_arrow, fontWeight: FontWeight.bold, fontSize: 20),
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.5)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.green_jdm_arrow,  width: 1.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.red,  width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.red,  width: 1.5)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
    ),
  );



  static Border dropdownBorder = Border.fromBorderSide(
      BorderSide(
        color: AppColors.greyLight,
        width: 1.0,
        style: BorderStyle.solid,
      )
  );
}
