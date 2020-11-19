import 'package:event_bus/event_bus.dart';
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/widget/base_widget.dart';
import 'package:myapp/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 *  中间图片模块
 */
class CarMidImageWidget extends BaseWidgetpage {

  CarDetailImgArea mCarMidImageInfo;
  CarDetailData data;
  EventBus eventBus;

  CarMidImageWidget({this.data, this.eventBus});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    var widgetState = CarMidImageWidgetState();
    widgetState.init(mCarMidImageInfo);
    return widgetState;
  }
}

class CarMidImageWidgetState extends State<CarMidImageWidget> {

  void init(CarDetailImgArea mCarMidImageInfo) {}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
    );
  }

}