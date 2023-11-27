import 'package:flutter/material.dart';

class SizeConfig {
  static SizeConfig? _sizeConfig;
  late MediaQueryData _mediaQueryData;
  late double screenWidth;
  double? screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;

  static SizeConfig? getInstance(BuildContext context) {
    if (_sizeConfig == null) {
      _sizeConfig = SizeConfig._internal(context);
    }
    return _sizeConfig;
  }

  SizeConfig._internal(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;
double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;
