import 'package:myapp/detail/entity/CarDetailResponse.dart';
import 'package:myapp/detail/entity/car_detail_data.dart';
import 'package:myapp/detail/utils/log.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/detail/constants/CarConstants.dart' as cons;
import 'BaseResponse.dart';
import 'TestParser.dart';
import 'detail_parser.dart';

class CarHttpApi {

  void test() {
    dynamic pwd = 123;
    Object pwd2 = 123;
    dynamic name = "123";
    Object name2 = "123";
    var name3 = 123;
  }

  void pullNet() {
    http.get(cons.CarConstants.detail_url)
        .then((http.Response response) {
      //解析json数据
      var string = response.body.toString();
      print("@@@");
      print(string);
      LogUtils.w('@@@-flutter-json', string);
      TestParser parser = new TestParser();
      parser.decodeJson(string);

    });
  }

  Future<CarDetailData> pullDetail() async {
    return await http.get(cons.CarConstants.detail_url)
        .then((http.Response response) {
      //解析json数据
      var string = response.body.toString();
      print("@@@");
      print(string);
//      LogUtils.w('@@@-flutter-json', string);
      DetailParser parser = new DetailParser();
      return parser.decodeJson(string);
    });
  }
}