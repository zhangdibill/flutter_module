import 'package:myapp/detail/entity/CarDetailResponse.dart';
import 'package:myapp/detail/net/CarBaseResponse.java';
import 'package:myapp/detail/net/BaseJsonParser.dart';
import 'dart:convert';
import 'package:myapp/detail/entity/car_detail_data.dart';


class DetailParser extends BaseJsonParser {
  @override
  CarDetailData decodeJson(String content) {
    Map<String, dynamic> jsonMap = json.decode(content);
    return CarDetailData.fromJson(jsonMap);
  }
}