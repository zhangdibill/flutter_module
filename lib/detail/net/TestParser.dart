import 'package:myapp/detail/entity/FirstTest.dart';
import 'package:myapp/detail/net/BaseJsonParser.dart';
import 'package:myapp/detail/net/BaseResponse.dart';
import 'package:myapp/detail/entity/FirstTestResponse.dart';
import 'dart:convert';
import 'package:myapp/detail/utils/log.dart';

class TestParser extends BaseJsonParser {
  @override
  CarBaseResponse decodeJson(String content) {
    Map<String, dynamic> jsonMap = json.decode(content);
    int status = jsonMap['errorCode'];
    String msg = jsonMap['errorMsg'];
    FirstTestResponse res = new FirstTestResponse(String.fromCharCode(status), msg);
    res.data = FirstTest.fromJson(jsonMap['data']);
    LogUtils.w('status', status.toString());
    LogUtils.w('msg', res.data.toString());

  }
}
