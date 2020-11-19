import 'package:event_bus/event_bus.dart';
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/widget/base_widget.dart';
import 'package:myapp/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/**
 * 同价位、同车系、同品牌
 */
class CarRecomWidget extends BaseWidgetpage {

  RecommendBean recommendBean;
  CarDetailData data;
  EventBus eventBus;

  CarRecomWidget({this.data, this.eventBus}) {
    recommendBean = data?.recommend?.new_recom_price_area;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    var widgetState = CarRecomWidgetState();
    widgetState.init(recommendBean);
    return widgetState;
  }
}

class CarRecomWidgetState extends State<CarRecomWidget> {

  void init(RecommendBean recommendBean) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(50.0),
      color: Colors.white,
    );
  }
}