import 'dart:async';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/loadJson/food.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MealsModel extends Model {
  List<Food> _breakfast = [];
  List<Food> get breakfast => _breakfast.toList();
 List<Food> _lunch = [];
  List<Food> get lunch => _lunch.toList();
 List<Food> _dinner = [];
  List<Food> get dinner => _dinner.toList();
 List<Food> _snack = [];
  List<Food> get snack => _snack.toList();
 
 
   static MealsModel of(BuildContext context) =>
      ModelFinder<MealsModel>().of(context);
void addItem(Food item,String meal){
  if (meal== 'breakfast') {
    addItemBreakfast(item);
    print('${breakfast.length}');
  }else  if (meal == 'lunch') {
    addItemLunch(item);
     print('${lunch.length}');
  }else  if (meal== 'dinner') {
    addItemDinner(item);
     print('${dinner.length}');
  }else  if (meal== 'snack') {
    addItemSnack(item);
     print('${snack.length}');
  }
  notifyListeners();
}
 int addCalories(String meal) {
   int calories;
   var item;
    if (meal== 'breakfast') {
   item=breakfast;
  }else  if (meal == 'lunch') {
  item=lunch;
  }else  if (meal== 'dinner') {
   item=dinner;
  }else  if (meal== 'snack') {
    item=snack;
  }
  for (var i = 0; i < item.length; i++) {
    calories+=item[i].calories;
  }
  notifyListeners();
  return calories;
  
    
  }
  void addItemBreakfast(Food item) {
    _breakfast.add(item);
     notifyListeners();
    
  }
   void addItemLunch(Food item) {
    _breakfast.add(item);
     notifyListeners();
    
  }
   void addItemDinner(Food item) {
    _breakfast.add(item);
     notifyListeners();
    
  }
   void addItemSnack(Food item) {
    _breakfast.add(item);
     notifyListeners();
    
  }
 

  void deleteItem(Food item) {
    _breakfast.remove(item);
    notifyListeners();
    
  }
    Future loadTodos() {
  
    notifyListeners();
 var db = new AppDatabase();
    /**return db.loadDaysList()
    .then((loadedTodos) {
      _items = loadedTodos;
     
      notifyListeners();
    }).catchError((err) {
     
      _items = [];
      notifyListeners();
    }); */
  }
  

}

//
