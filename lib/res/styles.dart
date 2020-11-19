import 'package:myapp/res/color.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/res/dimens.dart';


class TextStyles {

  //详情页标题样式
  static TextStyle titleStyle = TextStyle(
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold,
    color: EColor.black,
  );

  //详情页 价格样式
  static TextStyle priceStyle = TextStyle(
    fontSize: Dimens.font_sp20,
    fontWeight: FontWeight.bold,
    color: EColor.red,
  );

  //详情页 价格样式
  static TextStyle unitStyle = TextStyle(
    fontSize: Dimens.font_sp14,
    color: EColor.red,
  );

  //基本信息 title
  static TextStyle infoTitleStyle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: EColor.black,
  );
  static TextStyle infoStyle = TextStyle(
    fontSize: Dimens.font_sp12,
    color: EColor.color_999,
  );

}