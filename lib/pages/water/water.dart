import 'dart:async';

import 'package:appv1/pages/water/dbHelper.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

class Water{
 
 bool achieved;
 int intake;
 int goalIntake;
 String note;
 int id;
Water(
this.intake,this.goalIntake,this.achieved ,this.note,
//this.id
);

@override
int get hashCode => achieved.hashCode^note.hashCode^intake.hashCode^goalIntake.hashCode;



@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is Water &&
intake == other.intake &&
goalIntake == other.goalIntake &&
achieved == other.achieved &&
//id == other.id &&
note == other.note;

@override
  String toString() {
    return 'Food{ recent:$achieved,name:$intake,goal intake:$goalIntake,note:$note,}';
  }


//Water({String id,String achieved ,String intake,String goalIntake ,String note})


 Water.map(dynamic obj) {
    this.intake = obj['intake'];
    this.goalIntake = obj['goalIntake'];
    this.note = obj['note'];
   // this.id = obj['id'];
    this.achieved=obj['achieved'];

  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['intake']=intake;
   map['goalIntake']=goalIntake;
    map['note']=note;
    //map['id']=id;
   map['achieved']=achieved;

    return map;
  }

 Map<String, Object> toJson() {
    return {
     'intake': intake,
     'goalIntake':goalIntake,
     'note':note,
     //'id':id,
     'achieved':achieved
     
    };
  }
  static Water fromMap(Map<dynamic, Object> list) {
    return Water(
     list['intake'] as int,
     list["goalIntake"]  as int,
    list["achieved"] as bool,
    list["note"] as String,
   //list["id"] as int,
  
   );
  }
}
class WaterModel extends Model {
  List<Water> _items = [];
  List<Water> get items => _items.toList();
 int intake ;
 
   static WaterModel of(BuildContext context) =>
      ModelFinder<WaterModel>().of(context);

  void addItem(Water item) {
    _items.add(item);
     notifyListeners();
    
  }
  void setIntake (int newintake) {
    intake= newintake;
    notifyListeners();
  }
 
    void increment(Water item,int intake) {
    item.intake+=intake;
     var db =WaterDatabase();
     db.saveIntake(item);
    notifyListeners();
  }
 
  void decrement(Water item,int intake) {
  item.intake-=intake;
    var db =WaterDatabase();
     db.saveIntake(item);
    notifyListeners();
  }
  void achieved(Water item) {
  ( item.intake==item.goalIntake)?
  item.achieved=true
  : item.achieved=false;
    var db =WaterDatabase();
     db.achieved(item);
     notifyListeners();
 }
 

  void deleteItem(Water item) {
    _items.remove(item);
    notifyListeners();
    
  }
    Future loadTodos() {
  
    notifyListeners();
 var db = new WaterDatabase();
    return db.loadWaterList()
    .then((loadedTodos) {
      _items = loadedTodos;
     
      notifyListeners();
    }).catchError((err) {
     
      _items = [];
      notifyListeners();
    });
  }
  

}
