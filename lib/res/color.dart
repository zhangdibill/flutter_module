import 'package:flutter/material.dart';

/**
 * 颜色
 * create by Hankkin on 2020-01-15
 */
class EColor{
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFFF0000);
  static const Color theme = Color(0xFFEE9600);
  static const Color color_999 = Color(0xFF999999);
  static const Color color_333 = Color(0xFF333333);
  static const Color color_ddd = Color(0xFFdddddd);
  static const Color color_eee = Color(0xFFeeeeee);
  static const Color color_666 = Color(0xFF666666);
  static const Color color_F39100 = Color(0xFFF39100);

  static Color getColorFromString(String colorStr, {double alpha = 1.0}) {
    if (null == colorStr || "" == colorStr) {
      return Colors.white;
    }
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString为8位，如0x000000
    if(colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if(colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }
}