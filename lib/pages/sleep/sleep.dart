import 'dart:async';

import 'package:appv1/pages/sleep/dbHelper.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';


class Sleep{
  String dateTime,target,score;
  String timeSlept,debt;
  int id,mood;
 
Sleep(this.timeSlept,this.score,this.debt,this.dateTime,this.mood,this.target);


@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is Sleep &&
dateTime == other.dateTime &&
timeSlept == other.timeSlept &&
score == other.score &&
debt == other.debt &&
mood == other.mood &&
target == other.target;


//Water({String id,String achieved ,String intake,String goalIntake ,String note})


 Sleep.map(dynamic obj) {
    this.dateTime = obj['dateTime'];
    this.timeSlept = obj['timeSlept'];
    this.score = obj['score'];
   this.debt = obj['debt'];
    this.mood=obj['mood'];
     this.target=obj['target'];

  }
static Sleep fromItem(SleepItem list) {
    return Sleep(
     list.timeSlept.hour.toString()+':'+list.timeSlept.minute.toString(), 
    list.score,
   list.debt.hour.toString()+':'+list.debt.minute.toString(),
      list.dateTime.year.toString()+'-'+list.dateTime.month.toString()+'-'+list.dateTime.day.toString()
      +' '+list.dateTime.hour.toString()+':'+list.dateTime.minute.toString(),
      list.mood,
      list.target
   );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['dateTime']=dateTime;
   map['timeSlept']=timeSlept;
    map['debt']=debt;
   map['score']=score;
  map['mood']=mood;
   map['target']=target;
   print('${map.values}');
return map;
  }

 Map<String, Object> toJson() {
    return {
     'dateTime': dateTime,
     'timeSlept':timeSlept,
     'score':score,
     'id':target,
     'mood':mood,
     'debt':debt
     
    };
  }
  static Sleep fromMap(Map<dynamic, Object> list) {
    return Sleep(
     list["timeSlept"] as String,
      list["score"] as String,
    list["debt"] as String,
    list["note"] as String,
    list["dateTime"] as int,
    list["target"] as String,
   //list["id"] as int,
  
   );
  }
}

class SleepItem{
  String target,score;
  DateTime  dateTime;
  TimeOfDay timeSlept,debt;
  int id,mood;
 
SleepItem(this.timeSlept,this.score,this.debt,this.dateTime,this.mood,this.target);


@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is SleepItem &&
dateTime == other.dateTime &&
timeSlept == other.timeSlept &&
score == other.score &&
debt == other.debt &&
mood == other.mood &&
target == other.target;


//Water({String id,String achieved ,String intake,String goalIntake ,String note})


 SleepItem.map(dynamic obj) {
    this.dateTime = obj['dateTime'];
    this.timeSlept = obj['timeSlept'];
    this.score = obj['score'];
   this.debt = obj['debt'];
    this.mood=obj['mood'];
     this.target=obj['target'];

  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['dateTime']=dateTime;
   map['timeSlept']=timeSlept;
    map['debt']=debt;
   map['score']=score;
  map['mood']=mood;
   map['target']=target;
   print('${map.values}');
return map;
  }

 Map<String, Object> toJson() {
    return {
     'dateTime': dateTime,
     'timeSlept':timeSlept,
     'score':score,
     'id':target,
     'mood':mood,
     'debt':debt
     
    };
  }
  static SleepItem fromMap(Map<dynamic, Object> list) {
    return SleepItem(
//TimeOfDay timeSlept, String score, TimeOfDay debt, DateTime dateTime, int mood, String ta
    list["timeSlept"] as TimeOfDay,
      list["score"] as String,
    list["debt"] as TimeOfDay,
    list["dateTime"] as DateTime,
    list["mood"] as int,
    list["target"] as String,
  
   );
  }
  
}

//final now = new DateTime.now();
//return new DateTime(now.year, now.month, now.day, t.hour, t.minute);

class SleepModel extends Model {
  List<SleepItem> _items = [];
  List<SleepItem> get items => _items.toList();
  TimeOfDay _max=TimeOfDay(hour: 8,minute: 0);
  TimeOfDay get max => _max;
  TimeOfDay _min=TimeOfDay(hour: 8,minute: 0);
   TimeOfDay get min => _min;
  TimeOfDay _average=TimeOfDay(hour: 4,minute: 0);
   TimeOfDay get average => _average;
   double _averageScore=0.0;
  double get averageScore => _averageScore;
  
   static SleepModel of(BuildContext context) =>
   ModelFinder<SleepModel>().of(context);
 
 void score(SleepItem item){
 if( item.timeSlept.hour<8){
item.score=((item.timeSlept.hour+item.timeSlept.minute)*100/8).toString();
 }
 else{
 item.score='100';
 }
 }
 
double burnedCal(int weight ,int hours){
  var cal= weight*(2.20462)*0.42* hours;;
  //2,20462 kg
  // 0.42 * pounds
return cal;
}
 double burned(SleepItem item,int weight){
slept(item);
return burnedCal(weight, item.timeSlept.hour);

 }
 void slept(SleepItem item){
  
   item.timeSlept = TimeOfDay(
  hour: (item.dateTime.hour-item.timeSlept.hour).abs(),
   minute: (item.dateTime.minute-item.timeSlept.minute).abs()
   );
  print('${item.timeSlept}');
  }
 void debt(SleepItem item){
 if( item.timeSlept.hour<8){
item.debt=TimeOfDay(hour:(item.timeSlept.hour-8).abs(),minute:(item.timeSlept.minute).abs() );

 }
 else{
 item.debt=TimeOfDay(hour: 0,minute: 0);
 }
 }
  void addItem(SleepItem item) {
    _items.add(item);
    if (item.timeSlept.hour>max.hour ) {
      _max=item.timeSlept;
    }
     if (item.timeSlept.hour<min.hour ) {
      _min=item.timeSlept;

    }
     notifyListeners();
    
  }

  void delete() {
   _items=[];
    notifyListeners();
    
  }
   /* Future loadTodos() {
  
    notifyListeners();
 var db = new SleepDatabase();
    return db.loadSleepList()
    .then((loadedTodos) {
      _items = loadedTodos;
     
      notifyListeners();
    }).catchError((err) {
     
      _items = [];
      notifyListeners();
    });
  }
   */

}
