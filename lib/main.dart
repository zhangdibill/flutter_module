import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/detail/utils/log.dart';
import 'detail/car_detail_page.dart';
import 'detailTop/CarDetailTopPage.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

// void main() {
//   FlutterError.onError = (FlutterErrorDetails details) {
//     LogUtils.uploadFlutterErrorLog(details.exception.toString(), details.stack.toString());
//   };
//   runZoned(
//     () => runApp(_widgetForRoute(window.defaultRouteName)),
//     zoneSpecification: ZoneSpecification(
//       print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//         parent.print(self, line);
//       },
//     ),
//     onError: (Object obj, StackTrace stack) {
//       LogUtils.uploadFlutterErrorLog(obj.toString(), stack.toString());
//     }
//   );
// }

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'detail':
      return MyApp();
    case 'top':
      return MyDetailTop();
    default:
      return MyApp();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarDetailPage(),
    );
  }
}

class MyDetailTop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: CarDetailTopPage(),
    );
  }
}
