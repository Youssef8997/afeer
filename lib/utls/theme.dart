import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'manger/color_manger.dart';
import 'manger/font_manger.dart';

const String fontFamily = "Cairo";

ThemeData lightTheme() => ThemeData(
      scaffoldBackgroundColor: ColorsManger.scaffoldBackGround,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffFCFCFE),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark),
        toolbarHeight: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              alignment: Alignment.center,
              backgroundColor: MaterialStatePropertyAll(ColorsManger.pColor),
              textStyle: const MaterialStatePropertyAll(TextStyle(
                  color: ColorsManger.white,
                  fontWeight: WeightManger.bold,
                  fontSize: 17,
                  fontFamily: fontFamily)),
              foregroundColor:
                  const MaterialStatePropertyAll(ColorsManger.white),
              fixedSize: const MaterialStatePropertyAll(
                Size(342, 64),
              ),
              elevation: const MaterialStatePropertyAll(0),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
              enableFeedback: true,
              // backgroundColor: const MaterialStatePropertyAll(ColorsManger.primaryColors),
              padding: const MaterialStatePropertyAll(EdgeInsets.zero))),
      primaryColor: ColorsManger.pColor,
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              color: ColorsManger.black,
              fontWeight: WeightManger.regular,
              fontSize: 12,
              fontFamily: fontFamily),
          displayLarge: TextStyle(
            color: ColorsManger.black,
            fontSize: 16,
            fontWeight: WeightManger.bold,
            fontFamily: fontFamily,
          ),
          displayMedium: TextStyle(
              color: ColorsManger.black,
              fontSize: 14,
              fontFamily: fontFamily,
              fontWeight: WeightManger.medium),
          titleLarge: TextStyle(
            color: ColorsManger.black,
            fontSize: 24,
            fontFamily: fontFamily,
            fontWeight: WeightManger.black,
          )),
    );
