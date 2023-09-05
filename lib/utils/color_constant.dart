import 'package:flutter/material.dart';

class COLOR_CONST {
  static const primaryColor = Color(0xFF2CAE76);
  static const secondaryColor = Color(0xFF282D3C);
  static const backgroundColor = Color(0xffF6F7FB);
  static const cardShadowColor = Color(0xFFd3d1d1);
  static const unselectedTabColor = Color(0xFF999999);
  static const dividerColor = Colors.black12;
  static const primaryGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2CAE76), Colors.white],
  );

  static const textColor = Colors.black;

  ///Singleton factory
  static final COLOR_CONST _instance = COLOR_CONST._internal();

  factory COLOR_CONST() {
    return _instance;
  }

  COLOR_CONST._internal();
}

const mAnimationDuration = Duration(milliseconds: 200);
