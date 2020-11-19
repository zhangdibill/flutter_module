import 'dart:ffi';

import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/entity/tag.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/detail/widget/base_widget.dart';
import 'package:myapp/res/color.dart';
import 'package:myapp/res/dimens.dart';
import 'package:myapp/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../car_detail_page.dart';

/**
 * 标题模块
 */
class CarTitleWidget extends BaseWidgetpage {

  CarDetailData data;
  CarDetialTitleArea mCarTitleInfo;

  CarTitleWidget({this.data}) {
    if (data == null) return;
    if (data.info == null) return;
    if (data.info.new_carinfo_area == null) return;
    mCarTitleInfo = data.info.car_tags_title_area;
  }

  @override
  State<StatefulWidget> createState() {
    var widgetState = CarTitleWidgetState();
    widgetState.init(mCarTitleInfo);
    return widgetState;
  }
}

class CarTitleWidgetState extends State<CarTitleWidget> {
  CarDetialTitleArea info;
  List<Tag> title_tags;
  CarGujia guchejia;
  void init(CarDetialTitleArea mCarTitleInfo) {
    this.info = mCarTitleInfo;
    this.title_tags = info?.title_info?.title_tags;
    this.guchejia = info?.guchejia;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
      child: Column(
        // 排列方式
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          buildTitleWidget(info?.title_info),
          buildTagWidget(),
          Row (
            children: <Widget>[
              buildPriceWidget(info?.price),
              Spacer(),
              Container(
                height: 35,
                width: 80,
                decoration: new BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFACA1C), Color(0xFFF4A73A)]
                  ),
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                child: Center(
                  child: GestureDetector(
                    child: Text(
                      '来电砍价',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      eventBus.fire(ClickEvent(type: "tel400"));
                      print("BBBB  fire clickevent tel400");
                    },
                  ),
                ),
              ),
            ],
          ),
          buildGujiaWidget(),
        ],
      ),
    );
  }

  // 估价
  Widget buildGujiaWidget() {
    if (guchejia == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              eventBus.fire(ClickEvent(type: "jump", msg: guchejia.gujiaUrl));
            },
            child: Text(guchejia.gujiaText,
              style: TextStyle(
                  fontSize: 12,
                  color: EColor.color_999
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: EColor.color_999,
            size: 12,
          ),
        ],
      ),
    );
  }
  // tags
  Widget buildTagWidget() {
    if (title_tags == null || title_tags.length == 0) {
      return null;
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return buildTagItemWidget(index);
          }
      ),
    );
  }

  Widget buildTagItemWidget(int index) {
    if (index >= title_tags.length) {
      return null;
    }
    Tag tag = title_tags[index];
    if (tag.img_url != null && tag.img_url.length > 0) {
      return null;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
      alignment: Alignment(0, 0),
      height: 20,
      decoration: new BoxDecoration(
        //背景
        color: EColor.getColorFromString(tag.bgcolor),
        border: Border.all(color: EColor.getColorFromString((null != tag.bdcolor && "" != tag.bdcolor) ? tag.bdcolor : tag.bgcolor), width: 1),//边框,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Text(tag.text,
        style: TextStyle(
          color: EColor.getColorFromString(tag.color),
          fontSize: Dimens.font_sp11,
        ),
      ),
    );
  }


  // title
  Widget buildTitleWidget(CarTitleInfo title_info) {
    return Container(
      child: Text(
        title_info?.title,
        style: TextStyles.titleStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // 价格
  Widget buildPriceWidget(CarPrice price) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        // 排列方式
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            price?.jiage,
            style: TextStyles.priceStyle,
          ),
          Text(
            price?.jageUnit,
            style: TextStyles.unitStyle,
          ),

        ],
      ),
    );
  }
}