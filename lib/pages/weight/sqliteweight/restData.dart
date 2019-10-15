import 'dart:async';

import 'package:appv1/pages/weight/sqliteweight/networkUtil.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';



class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<Weight> add(String prevweight, String newweight,String date) {
    return new Future.value(new Weight(prevweight, newweight,date));
  }
}