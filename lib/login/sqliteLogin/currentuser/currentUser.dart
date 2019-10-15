

import 'dart:async';


import 'package:appv1/login/sqliteLogin/currentuser/UserDatabase.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
 // breakfastCalories, String lunchCalories, String dinnerCalories, String snackCalories) → User

  User _user = User.Account('_username', '_password', '_email', 0, 'sleep', 'weight',0,0,0,0);
 User get currentUser => _user;

   static UserModel of(BuildContext context) =>
      ModelFinder<UserModel>().of(context);
 Future loadUser() {
 
var db = new UserDatabase();
     return db.loadUser()
     .then((user ) {
       _user = user;
      notifyListeners();
     }).catchError((err) {
      
       _user = User.Account('_username', '_password', '_email', 0, 'sleep', 'weight', 0,0,0,0);
       notifyListeners();
     });
   }
  void addItem(User item) {
  //  _user=User(item.username, item.password, item.email);
   _user=item;
   var db = new UserDatabase();
   db.saveUser(item);
   db.addUser(item);
   db.show();
     notifyListeners();
     //add to DB 
  }
  int calories(){
    int cal=0;
    cal+=_user.breakfastCalories;
     cal+=_user.lunchCalories;
      cal+=_user.dinnerCalories;
       cal+=_user.snackCalories;
       notifyListeners();
       return cal;
       
  }
  void addCalories(String meal,int calories) {
   var db = new UserDatabase();
  if (meal== 'breakfast') {
 print('true');
    _user.breakfastCalories+=calories;

  }else  if (meal == 'lunch') {
 print('true');
    _user.lunchCalories+=calories;

  }else  if (meal== 'dinner') {
      print('true');  
    _user.dinnerCalories+=calories;

  }else  if (meal== 'snack') {
     print('true');
    _user.snackCalories+=calories;

  }
  
 db.addUser(_user);
   db.show();
     notifyListeners();
     //add to DB 
  }
 void deleteItem(User item) {
   _user=User('_username', '_password', '_email');
    notifyListeners();
    
 }
 void delete() {
   _user=User('_username', '_password', '_email');
    notifyListeners();
    
 }
   bool verifUser(User item) {
     var db = new UserDatabase();
   db.loadUser()
     .then((user) {
        if (item.password==user.password && item.username==user.username) {
         return true;
        }
      notifyListeners();
      } );
     return false;
   }
  }
