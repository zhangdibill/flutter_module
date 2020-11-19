import 'package:myapp/detail/entity/FirstTest.dart';
import 'package:myapp/detail/net/BaseResponse.dart';
import 'car_detail_data.dart';

class CarDetailResponse<CarDetailData> extends CarBaseResponse {

  CarDetailResponse(String status, String msg) {
    this.status = status;
    this.msg = msg;
  }

}