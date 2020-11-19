import 'package:myapp/detail/entity/car_config.dart';

import 'CarDetailBaseBean.dart';

class CarDetailNewCarArea extends CarDetailBaseBean{
  List<ItemBase> items_base;
  ItemExtend items_extend;
  CarConfig car_config;
  CarInfoJump carinfo_jump;
  CarDetailNewCarArea();

  @override
  String toString() {
    return 'CarDetailNewCarArea{items_base: $items_base, items_extend: $items_extend, car_config: $car_config, carinfo_jump: $carinfo_jump}';
  }

  factory CarDetailNewCarArea.fromJson(Map<String, dynamic> json) {
    var newCarArea = CarDetailNewCarArea();
    newCarArea.car_config = CarConfig.fromJson(json['car_config']);
    var itemsJson = json["items_base"] as List;
    newCarArea.items_base = itemsJson.map((m) => ItemBase.fromJson(m)).toList();
    newCarArea.items_extend = ItemExtend.fromJson(json['items_extend']);
    newCarArea.carinfo_jump = CarInfoJump.fromJson(json['carinfo_jump']);
    return newCarArea;
  }
}



class ItemBase {
  String title;
  String content;

  ItemBase();

  factory ItemBase.fromJson(Map<String, dynamic> json) {
    ItemBase item = new ItemBase();
    item.title = json['title'];
    item.content = json['content'];
    return item;
  }
}



class ItemExtend {
  String dingqibaoyang;
  String diya;
  String yingzhuanfei;
  ItemExtend();
  factory ItemExtend.fromJson(Map<String, dynamic> json) {
    ItemExtend itemExtend = new ItemExtend();
    itemExtend.dingqibaoyang = json['dingqibaoyang'];
    itemExtend.diya = json['diya'];
    itemExtend.yingzhuanfei = json['yingzhuanfei'];
    return itemExtend;
  }
}

class CarInfoJump {
  String title;
  Action actions;

  CarInfoJump();
  factory CarInfoJump.fromJson(Map<String, dynamic> json) {
    CarInfoJump infoJump = new CarInfoJump();

    if (json.length == 0) {
      return infoJump;
    }
    infoJump.title = json['title'];
    infoJump.actions = Action.fromJson(json['actions']);
    
    return infoJump;
  }
}

class Action {
  String tradeline;
  String action;
  ActionContent content;

  Action();
  factory Action.fromJson(Map<String, dynamic> json) {
    Action action = new Action();
    action.tradeline = json['tradeline'];
    action.action = json['action'];
    action.content = ActionContent.fromJson(json['content']);

    return action;
  }
}

class ActionContent {
  String pagetype;
  String carinfo_jump_url;
  String action;
  String title;
  ActionContent();
  factory ActionContent.fromJson(Map<String, dynamic> json) {
    ActionContent actionContent = new ActionContent();
    actionContent.pagetype = json['pagetype'];
    actionContent.carinfo_jump_url = json['carinfo_jump_url'];
    actionContent.action = json['action'];
    actionContent.title = json['title'];
    return actionContent;
  }
}