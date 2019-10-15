



import 'package:appv1/pages/sleep/restData.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:flutter/material.dart';

abstract class AddSleepPageContract {
  void onAddSuccess(SleepItem sleep);
  void onAddError(String error);
}
//this.timeSlept,this.score,this.debt,this.dateTime,this.mood,this.target);

class AddSleepPresenter {
  AddSleepPageContract _view;
  List<double> data=[];
  RestData api = new RestData();
  AddSleepPresenter(this._view);
  
  doAdd(TimeOfDay timeSlept, String score,TimeOfDay debt,
  DateTime dateTime,int mood,String target,) {
    api
        .add(timeSlept,score,debt,dateTime, mood,target )
        .then((weight) => _view.onAddSuccess(weight))
        .catchError((onError) => _view.onAddError(onError.toString()));
  }
}