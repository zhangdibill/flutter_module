import 'package:flutter/services.dart';

/**
 * Log Bridge
 */
class LogUtils {
  static const native_log = const MethodChannel("log");
  static const error_log = const MethodChannel("error_log");

  static void w(String tag, String msg) {
    native_log.invokeMethod("logW", {'tag': tag, 'msg': msg});
  }

  static void d(String tag, String msg) {
    native_log.invokeMethod("logD", {'tag': tag, 'msg': msg});
  }

  static void i(String tag, String msg) {
    native_log.invokeMethod("logI", {'tag': tag, 'msg': msg});
  }

  static void e(String tag, String msg) {
    native_log.invokeMethod("logE", {'tag': tag, 'msg': msg});
  }

  static void uploadFlutterErrorLog(String tag, String msg) {
    error_log.invokeMethod("error", {'tag': tag, 'msg': msg});
  }
}