import 'package:myapp/detail/entity/FirstTest.dart';
import 'package:myapp/detail/net/BaseResponse.dart';

class FirstTestResponse<FirstTest> extends CarBaseResponse {

  FirstTestResponse(String status, String msg) {
    this.status = status;
    this.msg = msg;
  }
}