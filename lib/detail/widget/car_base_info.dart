
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/entity/car_detail_new_car_area.dart';
import 'package:myapp/detail/widget/base_widget.dart';
import 'package:myapp/res/color.dart';
import 'package:myapp/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'base_widget.dart';

/**
 * 基本信息模块
 */
class CarBaseInfoWidget extends BaseWidgetpage {

  CarDetailData data;


  CarBaseInfoWidget({this.data}) {
    this.data = data;
  }

  @override
  State<StatefulWidget> createState() {
    return CarBaseInfoWidgetState(this.data);
  }
}

class CarBaseInfoWidgetState extends State<CarBaseInfoWidget> {
  List<ItemBase> items_base;
  ItemExtend items_extend;

  CarBaseInfoWidgetState(CarDetailData data) {
    this.items_base = data?.info?.new_carinfo_area?.items_base;
    this.items_extend = data?.info?.new_carinfo_area?.items_extend;
  }

  // var list = [
  //   {"content": "上牌时间", "title": "2017.03上牌"},
  //   {"content": "总公里数", "title": "3.94万公里"},
  //   {"content": "排放", "title": "国Ⅴ"},
  //   {"content": "排量/变速箱", "title": "1.5L/自动"},
  //   {"content": "车身颜色", "title": "灰"},
  //   {"content": "所在地", "title": "西北仓"}
  // ];

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
      child: Column(
        // 排列方式
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          buildTitleWidget(),
          buildGridView(this.items_base),
          // 底部按钮
          buildBottomWidget(this.items_extend)
        ],
      ),
    );
  }

  // title
  Widget buildTitleWidget() {
    return Container(
      child: Text(
        '基本信息',
        style: TextStyles.titleStyle,
      ),
    );
  }


  Widget buildItem(String top, String bottom) {
    return Column(
      children: <Widget>[
        Text(
          top,
          style: TextStyles.infoTitleStyle,
        ),
        Text(
          bottom,
          style: TextStyles.infoStyle,
        )
      ],
    );
  }

  Widget buildBottomWidget(ItemExtend items_extend) {
    String info = "";
    if (items_extend.dingqibaoyang != null) {
      info = items_extend.dingqibaoyang;
    }
    if (items_extend.yingzhuanfei != null) {
      info = info.isEmpty ? items_extend.yingzhuanfei : "$info | ${items_extend.yingzhuanfei}";
    }
    if (items_extend.diya != null) {
      info = info.isEmpty ? items_extend.diya : "$info | ${items_extend.diya}";
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: 40,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: EColor.color_eee,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Text(info,
        style: TextStyle(
          color: EColor.color_999,
          fontSize: 13,
        ),
      ),
    );
  }

  buildGridView(List<ItemBase> items_base) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),// 添加
          itemCount: items_base.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //一行多少个
            crossAxisCount: 3,
            // 上下间隔
            mainAxisSpacing: 10.0,
            // 左右间隔
            crossAxisSpacing: 10.0,
            //宽高比
            childAspectRatio: 5/2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {},
              child: buildItem(items_base[index].title, items_base[index].content),
            );
          }
      ),
    );
  }
}
