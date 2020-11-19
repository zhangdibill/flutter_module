
class CarBaseResponse<T> {

  T data;

  String status;
  String msg;
  CarBaseResponse({this.status, this.msg});

//  factory CarBaseResponse.fromJson(Map<String, dynamic> json) {
//    String status = json['status'];
//    String msg = json['msg'];
//    return new CarBaseResponse(status: status, msg: msg);
//  }
}