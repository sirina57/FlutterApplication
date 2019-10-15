import 'dart:async';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class DayDiary {
 DayDiary(this._date,this._breakfastIds,this._dinnerIds,this._lunchIds,this._snackIds,this._waterIntake,this._weight);
int _id;//date or 
//List<int> 
int _breakfastIds;
//List<int>
int _lunchIds;
//List<int>
int _dinnerIds;
//List<int>
int _snackIds;
 String _waterIntake;
 String _weight;
 String _date;


 
  int get id => _id;
  String get date => _date;
  int get breakfastIds => _breakfastIds;
  int get lunchIds => _lunchIds;
  int get dinnerIds => _dinnerIds;
  int get snackIds => _snackIds;
  String get waterIntake => _waterIntake;
  String get weight => _weight;



 DayDiary.map(dynamic obj) {
    this._breakfastIds = obj['breakfast'];
    this._lunchIds = obj['lunch'];
    this._dinnerIds = obj['dinner'];
    this._snackIds = obj['snack'];
    this._waterIntake = obj['water'];
    this._weight = obj['weight'];
    this._id = obj['id'];
     this._date = obj['date'];
  
  }
  static DayDiary fromMap(Map<String, Object> list) {
    return DayDiary(
        list["date"]  as String,
   //  list["id"]  as int,
    list["breakfast"] as int,
     list["lunch"]  as int,
    list["dinner"]  as int,
     list["snack"]  as int,
      list["water"]  as String,
       list["weight"]  as String,
      
    );
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
     map["id"]  =id;
    map["breakfast"] =_breakfastIds;
     map["lunch"] =_lunchIds;
    map["dinner"] =_dinnerIds; 
     map["snack"] =_snackIds;
   map["water"] = _waterIntake;
    map["weight"]=_weight;
    map["date"]=_date;
   
    return map;
}
}
class DayModel extends Model {
  List<DayDiary> _items = [];
  List<DayDiary> get items => _items.toList();
 
 
   static WeightModel of(BuildContext context) =>
      ModelFinder<WeightModel>().of(context);

  void addItem(DayDiary item) {
    _items.add(item);
     notifyListeners();
    
  }
 
  void delete() {
    _items=[];
    notifyListeners();
    
  }

  void deleteItem(DayDiary item) {
    _items.remove(item);
    notifyListeners();
    
  }
void addCalories(String meal,int calories,Key index) {
   
    var ind;
    if (index=='_0_') {
      ind=0;
    } else if (index=='_1_') {
     ind=1;
    }else if (index=='_2_') {
     ind=2;
    
    }
 if (meal== 'breakfast') {

    items[ind]._breakfastIds+=calories;

  }else  if (meal == 'lunch') {

    
    items[ind]._lunchIds+=calories;

  }else  if (meal== 'dinner') {
       
    items[ind]._dinnerIds+=calories;

  }else  if (meal== 'snack') {
   
    items[ind]._snackIds+=calories;

  } 
 var db = new AppDatabase();
  db.update(items[ind]);
   db.show();
     notifyListeners();
     //add to DB 
  }

    Future loadTodos() {
  
 var db = new AppDatabase();
    return db.loadDaysList()
    .then((loadedTodos) {
     // _items = loadedTodos;
     
      notifyListeners();
    }).catchError((err) {
     
      _items = [];
      notifyListeners();
    });
  }
  

}

//


class DaysModel extends Model {
  DaysModel({Future<List<DayDiary>>  stream}) {
    Stream.fromFuture(stream).listen((days) {
      this.counters = days;
      notifyListeners();
    });
  }

  List<DayDiary> counters;
}
