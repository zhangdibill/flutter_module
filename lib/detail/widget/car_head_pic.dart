import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:myapp/detail/event/click_event.dart';
import 'package:myapp/res/color.dart';

class ViewPageWidget extends StatefulWidget {
  List<String> pics;
  EventBus eventBus;
  ViewPageWidget({this.pics, this.eventBus}) {
//    print('开始传递数据给Widget');
    if (pics == null) {
      print("flutter car_head_pic is null");
    } else {
      var size = pics.length;
      print("flutter car_head_pic size = $size");
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewPageState(pics, eventBus);
  }
}

class ViewPageState extends State<ViewPageWidget> {
  int _currentPage = 1;
  List<String> pics;
  EventBus eventBus;
  ViewPageState(List<String> pics, EventBus eventBus) {
    this.pics = pics;
    this.eventBus = eventBus;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("详情页")),
        body: Stack( // stack 相当于  安卓的FrameLayout
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            PageView(
              physics: new AlwaysScrollableScrollPhysics(),
              children:
              buildImg(),
              onPageChanged: onPageChanged,
            ),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment(0, 0),
              width: 45,
              height: 20,
              decoration: new BoxDecoration(
                //背景
                color: Color(0x66666666),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text(
                "$_currentPage/${pics.length}",
                style: TextStyle(
                  color: EColor.white,
                  fontSize: 12,
                ),
              ),
            )
          ],
        )
    );
  }

  buildImg() {
    var list = List<InkWell>();
    if (pics == null) return list;
    for(var pic in pics) {
      if(!pic.startsWith("http:")) {
        pic = "https:" + pic;
      }
      var image = InkWell(
        onTap: () {
          print("flutter click");
          eventBus.fire(ClickEvent(type: "goPhoto", msg: _currentPage.toString()));
        },
        child: Image.network(pic,
            fit: BoxFit.cover,
            width: 270,
            height: double.infinity),
      );
      list.add(image);
    }
    return list;
  }

  void onPageChanged(int value) {
    this.setState(() {
      _currentPage = value + 1;
    });

    eventBus.fire(ClickEvent(type: "pageChange", msg: value.toString()));
  }
}