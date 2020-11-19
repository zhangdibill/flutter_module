import 'dart:convert' as json1;

class CarConfig {
  List<Config> configs;
  String text;
  List<ConfigItem> items;

  CarConfig();

  @override
  String toString() {
    return 'CarConfig{configs: $configs, text: $text, items: $items}';
  }

  factory CarConfig.fromJson(Map<String, dynamic> json) {
    CarConfig carConfig = new CarConfig();
    carConfig.text = json['text'];
    var itemsJson = json["items"] as List;
    carConfig.items = itemsJson.map((m) => new ConfigItem.fromJson(m)).toList();
    return carConfig;
  }
}

class Config {
  String title;
  String content;
}

class ConfigItem {
  String content;
  String clickLog;
  String confname;
  String imgurldesc;
  String imgurl;
  String clicklog;

  ConfigItem();
  factory ConfigItem.fromJson(Map<String, dynamic> json) {
    ConfigItem item = new ConfigItem();
    item.content = json['content'];
//    print('content');
//    print(item.content);
    item.clickLog = json['clickLog'];
//    item.confid = json['confid'];
//    if (null == item.confid) {
//      item.confid = json["confid"] + "";
//    }
    item.confname = json['confname'];
    item.imgurl = json['imgurl'];
    item.imgurldesc = json['imgurldesc'];
    item.clicklog = json["clicklog"];
    return item;
  }

  @override
  String toString() {
    return "content: " + content + ", confname: " + confname + ", imgurl: " + imgurldesc + ", clickLog: " + clickLog + ", imgurldesc: " + imgurldesc;
  }
}