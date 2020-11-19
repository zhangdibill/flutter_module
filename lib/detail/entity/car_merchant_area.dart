import 'package:myapp/detail/entity/car_config.dart';
import 'dart:convert';
import 'CarDetailBaseBean.dart';


// 分类模型
class CarDetailMerchantArea extends CarDetailBaseBean{
  UserInfoModel userInfo; // 用户信息
  DescInfoModel descInfo; // 描述信息
  String kanchedizhi; // 看车地址
  CarDetailMerchantArea({
    this.userInfo,
    this.descInfo,
    this.kanchedizhi,
  });
  //工厂模式-用这种模式可以省略New关键字
  factory CarDetailMerchantArea.fromJson(Map<String, dynamic> json) {
    return CarDetailMerchantArea(
      userInfo: UserInfoModel.fromJson(json['user_info']),
      descInfo: DescInfoModel.formJson(json['desc_info']),
      kanchedizhi: json['kanchedizhi'],
    );
  }
}

class UserInfoModel {
  String user_name;
  String local_name_color;
  String more;
  String local_name;
  String user_pic;
  UserInfoModel(
      {this.user_name,
        this.local_name,
        this.local_name_color,
        this.more,
        this.user_pic});
  factory UserInfoModel.fromJson(dynamic json) {
    return UserInfoModel(
      user_name: json['user_name'],
      local_name_color: json['local_name_color'],
      more: json['more'],
      local_name: json['local_name'],
      user_pic: json['user_pic'],
    );
  }
}

class DescInfoModel {
  List<dynamic> tagList;
  List<dynamic> contentList;
  DescInfoModel({this.tagList, this.contentList});
  factory DescInfoModel.formJson(dynamic json) {
    print(json);
    return DescInfoModel(
      tagList: TagModel().createTagList(json),//json['tags'].map((item) => TagModel.formJson(item)).toList(),
      contentList: json['new_content']
          .map((item) => ContentModel.formJson(item))
          .toList(),
    );
  }
}

class TagModel {
  String title;
  String bg_color;
  String border_color;
  String text_color;
  List createTagList(dynamic json){
    if(json['tags'] != null){
      return json['tags'].map((item) => TagModel.formJson(item)).toList();
    }else{
      return null;
    }
  }
  TagModel({
    this.title,
    this.bg_color,
    this.border_color,
    this.text_color,
  });
  factory TagModel.formJson(dynamic json) {
    return TagModel(
      title: json['title'],
      bg_color: json['bg_color'],
      border_color: json['border_color'],
      text_color: json['text_color'],
    );
  }
}

class ContentModel {
  String key;
  String value;

  ContentModel({this.key, this.value});
  factory ContentModel.formJson(Map json) {
    return ContentModel(key: json.keys.last, value: json.values.last);
  }
}
