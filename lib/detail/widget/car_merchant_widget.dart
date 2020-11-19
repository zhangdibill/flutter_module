import 'dart:math';
import 'package:event_bus/event_bus.dart';
import 'package:myapp/detail/car_detail_page.dart';
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:myapp/detail/entity/car_merchant_area.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/detail/widget/base_widget.dart';

class CarMerchantDescWidget extends BaseWidgetpage {
  CarDetailMerchantArea mCarInfoData;
  CarDetailData data;
  EventBus eventBus;

  CarMerchantDescWidget({this.data, this.eventBus}) {
    if (data.info.merchant_desc_area == null) return;
    mCarInfoData = data.info.merchant_desc_area;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    var infoWidgetState =
        CarMerchantDescWidgetState(mCarInfoData: mCarInfoData);
//    infoWidgetState.buildList(mCarInfoData);
    return infoWidgetState;
  }
}

class CarMerchantDescWidgetState extends State<CarMerchantDescWidget> {
  CarDetailMerchantArea mCarInfoData;
  CarMerchantDescWidgetState({this.mCarInfoData});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    int count = 0;
    count += (mCarInfoData.descInfo.tagList == null ? 0 : 1);
    count += (mCarInfoData.descInfo.contentList.length);
    List<Widget> _contentListWidget() => List.generate(count, (index) {
          if (index == 0 && mCarInfoData.descInfo.tagList != null) {
            return TagsWrapWidget(mCarInfoData);
          } else if (mCarInfoData.descInfo.tagList != null) {
            return Text(
              mCarInfoData.descInfo.contentList[index - 1].value,
            );
          } else {
            return Text(
              mCarInfoData.descInfo.contentList[index].value,
            );
          }
        }).toList();

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          mainTitleRow(mCarInfoData),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ClipPath(
              clipper: BackClipper(),
              child: Container(
                  padding:
                      EdgeInsets.only(top: 18, left: 10, bottom: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 30,
                  color: Colors.black12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _contentListWidget(),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// 介绍的标签
Widget TagsWrapWidget(CarDetailMerchantArea mCarInfoData) {
  return Wrap(spacing: 8, runSpacing: 4, children: TagsWidget(mCarInfoData));
}

List<Widget> TagsWidget(CarDetailMerchantArea mCarInfoData) =>
    List.generate(mCarInfoData.descInfo.tagList.length, (index) {
      TagModel tagM = mCarInfoData.descInfo.tagList[index];
      Widget text = Text(
        tagM.title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
      return Container(
          padding: EdgeInsets.only(top: 2, left: 10, bottom: 2, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(width: 0.5, color: Colors.black26)),
          child: text);
    });

// 头像信息等
Widget mainTitleRow(CarDetailMerchantArea mCarInfoData) {
  return Row(
    children: <Widget>[
      Center(
        child: Container(
          height: 40,
          width: 40,
          child: ClipOval(
            child: Image.network(mCarInfoData.userInfo.user_pic),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              mCarInfoData.userInfo.user_name,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            Text(
              mCarInfoData.userInfo.local_name,
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            )
          ],
        ),
      ),
      Spacer(),
      Container(
        height: 26,
        width: 80,
        child: RaisedButton(
          color: Colors.orange[400],
          onPressed: () {
            eventBus.fire(ClickEvent(type: "tel400", msg: "sjdh"));
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.call,
                color: Colors.white,
                size: 18,
              ),
              Text(
                '电话',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

class BackClipper extends CustomClipper<Path> {
  double _crop = 6;
  double _marginL = 0;
  double _marginT = 8;
  double _rW = 15;
  double _mW = 15;
  // 画圆的弧度大小
  double _angle = pi * 0.5;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(_marginL + _crop, _marginT);
    // 凸起的三角
    path.lineTo(_marginL + _mW, _marginT);
    path.lineTo(_marginL + _mW + _rW * 0.5, 0);
    path.lineTo(_marginL + _mW + _rW, _marginT);
    path.lineTo(size.width - _marginL - _crop, _marginT);

    // 右上圆角
    path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width - _crop, _marginT + _crop),
            radius: _crop),
        -pi * 0.5,
        _angle,
        false);
    path.lineTo(size.width - _marginL, size.height - _crop);
    // 又下圆角
    path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width - _crop, size.height - _crop),
            radius: _crop),
        0,
        _angle,
        false);
    path.lineTo(_marginL + _crop, size.height);
    // 左下圆角
    path.arcTo(
        Rect.fromCircle(
            center: Offset(_marginL + _crop, size.height - _crop),
            radius: _crop),
        pi * 0.5,
        _angle,
        false);
    path.lineTo(_marginL, _marginT + _crop);
    // 左上圆角
    path.arcTo(
        Rect.fromCircle(
            center: Offset(_marginL + _crop, _marginT + _crop), radius: _crop),
        pi,
        _angle,
        false);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
