// users model 
import 'dart:async';
import 'package:appv1/login/sqliteLogin/dbHelper.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginModel extends Model {
 static List<User> _items = [];
  List<User> get items => _items.toList();
 

 static LoginModel of(BuildContext context) =>
      ModelFinder<LoginModel>().of(context);

//retrieve
  Future loadUsers() {
   var db = new LoginDatabase();
     return db.loadUsers()
     .then((loadedTodos) {
       _items = loadedTodos;
      notifyListeners();
     }).catchError((err) {
      
       _items = [];
       notifyListeners();
     });
   }

  // add user 
  void addItem(User item) {
  _items.add(item);
   var db = new LoginDatabase();
   db.show();
     notifyListeners();
     //add to DB ?
  }

  // delete  db 
 void delete() {
   var db = new LoginDatabase();
   db.delete();
    _items=[];
    notifyListeners();
    
  }
  //delete user 
 void deleteItem(User item) {
    _items.remove(item);
    notifyListeners();  
  }
  //verif user is in db ?
   bool verifUser(User item) {
     var db = new LoginDatabase();
   db.loadUsers()
     .then((users) {
        for (var i = 0; i < users.length; i++) {
        if (item.password==users[i].password && item.username==users[i].username) {
         return true;
        }
      notifyListeners();
      } });
      return  false;
   }
 }
