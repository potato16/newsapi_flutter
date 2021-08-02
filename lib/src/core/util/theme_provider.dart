import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
      scaffoldBackgroundColor: AppColor.background,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.secondColor,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            TextStyle(color: AppColor.grey, fontSize: 14, height: 20 / 14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: EdgeInsets.fromLTRB(16, 4, 0, 4),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusColor: AppColor.active,
      ),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24,
          height: 28 / 24,
          fontWeight: FontWeight.normal,
        ),
        headline6: TextStyle(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 19 / 16,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 17 / 14,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          height: 16 / 14,
          fontWeight: FontWeight.normal,
          color: AppColor.grey,
        ),
        caption: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 16 / 14,
            letterSpacing: 0.1),
      ));
});

class AppColor {
  AppColor._();
  static const Color grey = Color(0xFF717368);
  static const Color background = Color(0xFFFAF5ED);
  static const Color secondColor = Color(0xFFCCF7F3);
  static const Color hintBackground = Color(0xFFEDEFE4);
  static const Color active = Color(0xFFDBEA8D);
}
