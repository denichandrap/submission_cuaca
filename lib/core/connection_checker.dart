import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionChecker {
  static Future<bool> isConnected() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      EasyLoading.showError('Please Check Your Connection Internet');

      debugPrint('No internet ');
    }
    return result;
  }
}
