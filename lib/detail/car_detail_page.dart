import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/detail/utils/toast.dart';
import 'package:myapp/detail/widget/car_base_info.dart';
import 'package:myapp/detail/widget/car_info_widget.dart';
import 'package:myapp/detail/widget/car_mid_image_widget.dart';
import 'package:myapp/detail/widget/car_recom_widget.dart';
import 'package:myapp/detail/widget/car_title_info.dart';
import 'package:myapp/detail/widget/sliver_custom_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/detail/widget/car_head_pic.dart';
import 'package:myapp/res/color.dart';
import 'package:myapp/res/styles.dart';

import 'entity/car_detail_data.dart';
import 'net/CarHttpApi.dart';
import 'package:myapp/detail/widget/car_merchant_widget.dart';
//import 'package:dio/dio.dart';

/**
 * 详情页
 */
class CarDetailPage extends StatefulWidget {

  CarDetailPage({this.params, this.message});
  final Map params;
  final String message;

  @override
  State<StatefulWidget> createState() {
    return CarDetailPageState();
  }
}

EventBus eventBus = EventBus();
StreamSubscription _streamSubscription;

typedef Fun = Widget Function();
class Model{
  String type;
  Fun fun;
  Model({this.type, this.fun});
}

class CarDetailPageState extends State<CarDetailPage> {
  static CarDetailData data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // event bus 接受来自各个 widget的消息
    _streamSubscription = eventBus.on<ClickEvent>().listen((event) {
      String type = event.type;
      String msg = event.msg;
      if (type != null) {
        print("BBBB type  $type");
      }
      if (msg != null) {
        print("BBBB msg = $msg");
      }
      Toast.toast(context, "$type : $msg");
    });
//    Magpie.singleton.registerPageBuilders(({
//      'CarDetailPage':(pageName, params, _) => CarDetailPage(params: params)
//    }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }

  }

  // 控制模块的顺序的列表
  /**
   * "title_widget", // 标题、价格模块
      "base_info_widget", // 基本信息模块
      "car_info_widget", // 车辆配置模块
      "car_merchant_widget", // 商家信息模块
      "mid_image_widget", // 中间图片
      "recom_price_widget", // 同价位
      "recom_chexi_widget", // 同车系
      "recom_pinpai_widget", // 同品牌
   */

  var list = [];
  void listInitData(){
    list.clear();
    list
      ..add(Model(type: 'title_widget', fun: () => CarTitleWidget(data:data))) // 标题、价格模块
      ..add(Model(type: 'base_info_widget', fun: () => CarBaseInfoWidget(data:data))) // 基本信息模块
      ..add(Model(type: 'car_info_widget', fun: () => CarInfoWidgetPage(data:data)))// 车辆配置
      ..add(Model(type: 'car_merchant_widget', fun: () => CarMerchantDescWidget(data:data, eventBus:eventBus))) // 商家信息模块
      ..add(Model(type: 'mid_image_widget', fun: () => CarMidImageWidget(data:data, eventBus:eventBus))) // 中间图片
      ..add(Model(type: 'recom_price_widget', fun: () => CarRecomWidget(data:data, eventBus:eventBus))) // 同价位
      ..add(Model(type: 'recom_chexi_widget', fun: () => CarRecomWidget(data:data, eventBus:eventBus))) // 同车系
      ..add(Model(type: 'recom_pinpai_widget', fun: () => CarRecomWidget(data:data, eventBus:eventBus))); // 同品牌
  }
  // 各个模块
  Widget _buildItem(BuildContext context, Model model) {
    return model.fun();
  }

  @override
  Widget build(BuildContext context) {

    final double topPadding = MediaQuery.of(context).padding.top;

    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
          future: initData(),
          builder: (BuildContext context, AsyncSnapshot<CarDetailData> snapshot) {
            print(snapshot.data);
            if (snapshot.data != null) {
              print('加载结束');
              data = snapshot.data;
              listInitData();
              print(snapshot);
              var viewPagerStateFull = new ViewPageWidget(pics:data?.info?.car_image_area?.pic, eventBus: eventBus);
              return createBody(topPadding, viewPagerStateFull);
            } else {
              print('网络加载中');
              return Center(
                  child: Container(
                    child: Text('网络加载中...'),
                  )
              );

            }
      })
    );
  }

  Future<CarDetailData> initData() async {
    var _carHttpApi = new CarHttpApi();
    var pullDetail = _carHttpApi.pullDetail();
    print('==============');
    print(pullDetail);
    return pullDetail;
  }

  Widget createBody(double topPadding, ViewPageWidget viewPagerStateFull) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                // 实现appbar的效果
                SliverPersistentHeader(
                    pinned: true,
                    // 自定义 随着滑动，动态改变appbar的颜色，和里边widget的颜色
                    delegate: SliverCustomHeaderDelegate(
                      collapsedHeight: 50.0,
                      expandedHeight: MediaQuery.of(context).size.width * 3 / 4,
                      paddingTop: topPadding,
                      // 顶部轮播图
                      child: viewPagerStateFull,
                      title: data?.info?.car_tags_title_area?.title_info?.title,)
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context,
                        int index) {
                      print('$index');
                      if (index >= list.length) {
                        return null;
                      }
                      return _buildItem(context, list[index]);
                    })),

              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.share,
                      color: EColor.color_999,
                      size: 25,
                    ),
                    Text(
                      "分享",
                      style: TextStyles.infoStyle,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFACA1C), Color(0xFFF4A73A)]
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize:MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.local_phone,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            data?.info?.car_share_area?.phoneNum,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
