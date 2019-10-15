import 'dart:async';

import 'package:appv1/pages/weight/sqliteweight/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Weight {
  String _prevweight;
  String _newweight;
  String _date;
  DateTime entryDate;
  int id;
  
  Weight(this._prevweight, this._newweight,this._date );
  
  Weight.Entry(this._prevweight, this._newweight,this.entryDate );
  Weight.withId(this._prevweight, this._newweight,this._date,this.id);
  Weight.map(dynamic obj) {
    this._prevweight = obj['prevweight'];
    this._newweight = obj['newweight'];
    this._date = obj['date'];
  }

  String get prevweight => _prevweight;
  String get newweight => _newweight;
  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["prevweight"] = _prevweight;
    map["newweight"] = _newweight;
    map["date"] = _date;
    return map;
  }

 Map<String, Object> toJson() {
    return {
      "prevweight": prevweight,
      "newweight": newweight,
      "date": date,
     
    };
  }
  static Weight fromMap(Map<String, Object> list) {
    return Weight.withId(
     list["prevweight"]  as String,
    list["newweight"] as String,
    list["date"]  as String,
    list["id"] as int
   );
  }
}
class WeightModel extends Model {
  List<Weight> _items = [];
  List<Weight> get items => _items.toList();
 
 
   static WeightModel of(BuildContext context) =>
      ModelFinder<WeightModel>().of(context);

  void addItem(Weight item) {
    _items.add(item);
     notifyListeners();
    
  }
  
 List<DateTime> data(DateTime item){
   List<DateTime> time=[] ;
   time.add(item);
   notifyListeners();
   return time;
  
 }
 

  void deleteItem(Weight item) {
    _items.remove(item);
    notifyListeners();
    
  }
    Future loadTodos() {
  
    notifyListeners();
 var db = new DatabaseHelper();
    return db.loadWeightList()
    .then((loadedTodos) {
      _items = loadedTodos;
     
      notifyListeners();
    }).catchError((err) {
     
      _items = [];
      notifyListeners();
    });
  }
  

}

//
