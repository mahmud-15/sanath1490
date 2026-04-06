// import 'package:flutter/material.dart';
//
// class AppSize {
//   AppSize._(); // private constructor
//
//   static late Size size; // actual screen size
//
//   static const double _designWidth = 375;   // your design width
//   static const double _designHeight = 882;  // your design height
//
//   /// Initialize in main() after MediaQuery
//   static void init(BuildContext context) {
//     size = MediaQuery.of(context).size;
//   }
//
//   /// width scaling
//   static double width(double value) {
//     return (size.width / _designWidth) * value;
//   }
//
//   /// height scaling
//   static double height(double value) {
//     return (size.height / _designHeight) * value;
//   }
//
//   /// font scaling
//   static double fontSize(double value) {
//     // Average of width & height scaling for better cross-device font size
//     double scaleWidth = size.width / _designWidth;
//     double scaleHeight = size.height / _designHeight;
//     double scale = (scaleWidth + scaleHeight) / 2;
//     return value * scale;
//   }
// }
//
//



import 'package:flutter/material.dart';

class AppSize {
  AppSize._();
  static late Size size;

  static const double _xdHeight = 882;
  static const double _xdWidth = 375;

  static double height({required num value}) {
    double percentage = (value / _xdHeight * 100) / 100;
    // double percentage = (value / _xdHeight * 100).roundToDouble() / 100;
    return size.height * percentage;
  }

  static double width({required num value}) {
    double percentage = (value / _xdWidth * 100) / 100;
    // double percentage = (value / _xdWidth * 100).roundToDouble() / 100;
    return size.width * percentage;
  }
}
