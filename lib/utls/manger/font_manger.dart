import 'package:flutter/material.dart';

class FontsManger{
  static TextStyle? smallFont(context)=>Theme.of(context).textTheme.displaySmall;
  static TextStyle? mediumFont(context)=>Theme.of(context).textTheme.displayMedium;
  static TextStyle? largeFont(context)=>Theme.of(context).textTheme.displayLarge;
  static TextStyle? blackFont(context)=>Theme.of(context).textTheme.titleLarge;
}

class  WeightManger{
  static const FontWeight bold=FontWeight.bold;
  static const FontWeight regular=FontWeight.w100;
  static const FontWeight medium=FontWeight.w400;
  static const FontWeight black=FontWeight.w900;
}