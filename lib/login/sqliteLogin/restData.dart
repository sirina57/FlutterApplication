// users model
import 'dart:async';
import 'package:appv1/login/sqliteLogin/networkUtil.dart';
import 'package:appv1/login/sqliteLogin/user.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password,String email) {
    return new Future.value(new User(username, password,email));
  }
}