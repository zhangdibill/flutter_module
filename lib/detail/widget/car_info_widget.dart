
import 'package:myapp/detail/car_detail_page.dart';
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/entity/car_detail_new_car_area.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/res/color.dart';
import 'package:myapp/res/styles.dart';
import 'package:flutter/material.dart';

import 'base_widget.dart';

/**
 * 车辆配置
 */
class CarInfoWidgetPage extends BaseWidgetpage {
  CarDetailNewCarArea mCarInfoData;
  CarDetailData data;

//  CarInfoWidgetPage(listener) : super(listener);
  CarInfoWidgetPage({this.data}) {
    if (data == null) return;
    if (data.info == null) return;
    if (data.info.new_carinfo_area == null) return;
    mCarInfoData = data.info.new_carinfo_area;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    var infoWidgetState = CarInfoWidgetState();
    infoWidgetState.buildList(mCarInfoData);
    return infoWidgetState;
  }

}


// 配置实体类
class Model{
  String imgurl; // 图标
  String confname; // 描述

  Model(this.imgurl, this.confname);
}

class CarInfoWidgetState extends State<CarInfoWidgetPage> {

  void buildList(CarDetailNewCarArea new_carinfo_area) {
    //车辆配置
    print(new_carinfo_area);
    if (new_carinfo_area == null) return;
    carinfo_jump = new_carinfo_area.carinfo_jump;
    if (new_carinfo_area.car_config == null) return;
    if (new_carinfo_area.car_config.items == null) return;
    for (var item in new_carinfo_area.car_config.items) {
      list.add(Model(item.imgurl, item.confname));
    }
  }

  var list = [
  ];
  CarInfoJump carinfo_jump;

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
          buildTitleWidget(),
          // 配置列表
          buildItemsWidget(),
          // 底部按钮
          buildBottomWidget(),
        ],
      ),
    );
  }

  // title
  Widget buildTitleWidget() {
    return Container(
      child: Text(
        '车辆配置',
        style: TextStyles.titleStyle,
      ),
    );
  }

  // 配置items
  Widget buildItemsWidget() {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        // 水平排列
        scrollDirection: Axis.horizontal,
//        shrinkWrap: true, //为true可以解决子控件必须设置高度的问题，竖直排列时需要设置高度时
        // 回弹效果
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          // 配置item
          return buildConfigItemWidget(index);
        },
      ),
    );
  }

  // 底部button
  Widget buildBottomWidget() {
    if (carinfo_jump == null || carinfo_jump.title == null || carinfo_jump.title.isEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 20),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: 40,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        //设置四周边框
        border: new Border.all(width: 0.5, color: const Color(0xFFF39100)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              eventBus.fire(ClickEvent(type: 'jump', msg: carinfo_jump?.actions?.content?.carinfo_jump_url));
            },
            child: Text("${carinfo_jump.title}",
              style: TextStyle(
                color: EColor.color_F39100,
                fontSize: 13,
              ),
            ),
          ),
          Icon(
            Icons.arrow_right,
            color: EColor.color_F39100,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget buildConfigItemWidget(int index) {
    if (index >= list.length) {
      return null;
    }
    Model model = list[index];
    return Container(
      width: 80,
      child: Column(
        children: <Widget>[
          // 图片
          Image.network(
            model.imgurl,
            width: 30.0,
            height: 30.0,
            fit: BoxFit.fill,
          ),
          // padding
          Padding(
              padding: const EdgeInsets.only(top: 7.5)),
          // 描述
          Text(
            model.confname,
            style: TextStyle(
              color: const Color(0xFF999999),
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}