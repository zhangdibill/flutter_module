
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/detail/widget/car_head_pic.dart';
import 'package:event_bus/event_bus.dart';

class CarDetailTopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarDetailTopPageState();
  }

}

EventBus eventBus = EventBus();
StreamSubscription _streamSubscription;

class CarDetailTopPageState extends State<CarDetailTopPage> {
  static const messageChannel = const BasicMessageChannel('flutter_and_native_100', StandardMessageCodec());
  List<String> pics = null;

  @override
  void initState() {
    // TODO: implement initState
    _streamSubscription = eventBus.on<ClickEvent>().listen((event) {
      String type = event.type;
      String msg = event.msg;
      var map = new Map();
      map['type'] = type;
      map['msg'] = msg;
      messageChannel.send(map); // 往native发消息
    });

    // 接收native来的消息
    messageChannel.setMessageHandler((message) async {
      print('flutter message: $message');
        setState(() {
          pics = message.split("\|");
          print('flutter ${pics.length}');
        });
      return '返回Native端的数据001';//这是native端的响应 ，执行了
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: 270.0,
        child: ViewPageWidget(pics:pics, eventBus: eventBus),
      ),
    );
  }
}