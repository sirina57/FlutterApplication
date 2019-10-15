
import 'dart:async';

import 'package:appv1/pages/sleep/sleep.dart';
import 'package:flutter/material.dart';


class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";
//this.timeSlept,this.score,this.debt,this.dateTime,this.mood,this.target);

  Future<SleepItem> add(TimeOfDay timeSlept, String score, TimeOfDay debt, DateTime dateTime, int mood, String target) {
    return new Future.value(new SleepItem(timeSlept,score,debt,dateTime, mood,target ));
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