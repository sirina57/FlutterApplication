
import 'dart:async';

import 'package:appv1/pages/water/water.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<Water> add(bool achieved ,int intake,int goalIntake ,String note) {
    return new Future.value(new Water(intake, goalIntake, achieved, note));
  }
}

class NetworkUtil {

  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;


  Future<dynamic> get(){
    return null;
  }

}