import 'package:myapp/detail/entity/CarDetailBaseBean.dart';
import 'package:myapp/detail/entity/base_action.dart';
import 'package:myapp/detail/entity/car_detail_new_car_area.dart';
import 'package:myapp/detail/entity/car_list_bean.dart';
import 'package:myapp/detail/entity/tag.dart';
import 'package:myapp/detail/entity/car_merchant_area.dart';

class CarDetailData {
  String msg;
  String status;
  CarDetailInfo info;
  CarDetailRecommend recommend;

  CarDetailData();

  factory CarDetailData.fromJson(Map<String, dynamic> json) {
    var data = CarDetailData();
    data.status = json['status'];
    data.msg = json['msg'];
    data.info = CarDetailInfo.fromJson(json["info"]);
    return data;
  }
}

class CarDetailInfo {
  CarDetailTopImgArea car_image_area;//头部图片
  CarDetialTitleArea car_tags_title_area;
  CarDetailImgArea car_mid_image_area;
  CarDetailMerchantArea merchant_desc_area;
  CarDetailNewCarArea new_carinfo_area;
  CarDetailShareArea car_share_area;

  CarDetailInfo();

  @override
  String toString() {
    return 'CarDetailInfo{car_image_area: $car_image_area, car_tags_title_area: $car_tags_title_area, car_mid_image_area: $car_mid_image_area, merchant_desc_area: $merchant_desc_area, new_carinfo_area: $new_carinfo_area, car_share_area: $car_share_area}';
  }

  factory CarDetailInfo.fromJson(Map<String, dynamic> json) {
    var info = CarDetailInfo();
    info.car_image_area = CarDetailTopImgArea.fromJson(json["car_image_area"]);
    info.car_tags_title_area = CarDetialTitleArea.fromJson(json["car_tags_title_area"]);
    info.new_carinfo_area = CarDetailNewCarArea.fromJson(json["new_carinfo_area"]);
    info.merchant_desc_area = CarDetailMerchantArea.fromJson(json["merchant_desc_area"]);
    info.car_share_area = CarDetailShareArea.fromJson(json["car_share_area"]);
    print(info.toString());
//    info.car_tags_title_area =
    return info;
  }
}

class CarDetailRecommend {
  RecommendBean new_recom_pinpai_area;
  RecommendBean new_recom_price_area;
  RecommendBean new_recom_chexi_area;
}

class RecommendBean {
  String text;
  List<CarListBean> infoList;
  String targetUrl;
  BaseAction action;
}

class CarDetailShareArea {
  String pic1;
  String title;
  String url;
  String content;
  String phoneNum;

  CarDetailShareArea();

  factory CarDetailShareArea.fromJson(Map<String, dynamic> json) {
    var shareArea = CarDetailShareArea();
    shareArea.pic1 = json['pic1'];
    shareArea.title = json['title'];
    shareArea.url = json['url'];
    shareArea.content = json['content'];
    shareArea.phoneNum = json['phoneNum'];
    return shareArea;
  }
}

class CarDetailTopImgArea extends CarDetailBaseBean {
  List<String> pic;

  CarDetailTopImgArea();

  factory CarDetailTopImgArea.fromJson(Map<String, dynamic> json) {
    var topImgArea = CarDetailTopImgArea();
    topImgArea.pic = new List<String>.from(json['pic']);
    return topImgArea;
  }
}

class CarDetialTitleArea extends CarDetailBaseBean {
  CarTitleInfo title_info;
  CarPrice price;
  CarGujia guchejia;
  CarDetialTitleArea();

  factory CarDetialTitleArea.fromJson(Map<String, dynamic> json) {
    var titleArea = CarDetialTitleArea();
    titleArea.title_info = CarTitleInfo.fromJson(json['title_info']);
    titleArea.price = CarPrice.fromJson(json['price']);
    titleArea.guchejia = CarGujia.fromJson(json['guchejia']);
    return titleArea;
  }

}

class CarGujia {
  String gujiaText;
  String gujiaUrl;

  CarGujia();

  factory CarGujia.fromJson(Map<String, dynamic> json) {
    var titleInfo = CarGujia();
    if (json.length == 0) {
      return null;
    }
    titleInfo.gujiaText = json['gujiaText'];
    titleInfo.gujiaUrl = json['gujiaUrl'];
    return titleInfo;
  }
}

class CarTitleInfo {
  String title;
  List<Tag> title_tags;

  CarTitleInfo();

  factory CarTitleInfo.fromJson(Map<String, dynamic> json) {
    var titleInfo = CarTitleInfo();
    titleInfo.title = json['title'];
    var itemsJson = json["title_tags"] as List;
    titleInfo.title_tags = itemsJson.map((m) => Tag.fromjson(m)).toList();
    return titleInfo;
  }
}

class CarPrice {
  String jiage;
  String jageUnit;

  CarPrice();

  factory CarPrice.fromJson(Map<String, dynamic> json) {
    var priceInfo = CarPrice();
    priceInfo.jiage = json['jiage'];
    priceInfo.jageUnit = json['jiageUnit'];
    return priceInfo;
  }
}

class CarDetailImgArea {
  String mid_text;
  List<String> pic_list;
}

class CarDetailDescArea {
  String kanchedizhi;
  CarDetailDescBean desc;
}

class CarDetailDescBean {
  String more_text;
  String less_text;
  String content;
}