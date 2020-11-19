import 'dart:convert';
import 'package:myapp/detail/net/BaseResponse.dart';

class BaseJsonParser<CarBaseResponse> {

  CarBaseResponse decodeJson(String content) {
    var decode = json.decode(content);
  }
}