
//for adding days
//import 'package:appv1/daysdata/sqlitedays/pages/addDaysDb.dart';
import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';


import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/google_sign_in/homepage.dart';
import 'package:appv1/loadJson/loadFood.dart';
import 'package:appv1/loadJson/mealsModel.dart';

import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/login/sqliteLogin/loginModel.dart';
import 'package:appv1/login/sqliteLogin/loginexisting.dart';
import 'package:appv1/login/sqliteLogin/pages/loginaddUser.dart';

import 'package:appv1/pages/diary/diary.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';

import 'package:appv1/pages/water/waterHome.dart';

import 'package:appv1/pages/weight/sqliteweight/pages/weightHome.dart';

//login + add to DB


import 'package:appv1/pages/goal/inheritGoalWeight.dart';
import 'package:appv1/pages/searchActiv.dart';

import 'package:appv1/searchFood.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/heartRate.dart';
import 'pages/track.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( 
    ScopedModel<LoginModel>(
      model: LoginModel(),
      child: ScopedModel<UserModel>(
      model: UserModel(),
      child:ScopedModel<DaysModel>(
      model: DaysModel(stream:  AppDatabase().loadDaysList()),
       child:ScopedModel<DayModel>(
      model: DayModel(),
      child: ScopedModel<MealsModel>(
      model: MealsModel(),
      child: MaterialApp(
             debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home:LoginPage(),//
             routes:
                  {"/diary" : (BuildContext context )=> new Diary(),
                 "/overview" : (BuildContext context )=> new  Home(),
                  "/weight" : (BuildContext context )=> new WeightHome(),
                  "/sleep" :(BuildContext context)=> new SleepHome (),
                 "/goals"  :(BuildContext context)=> new GoalApp(),
                  // "/water" :(BuildContext context)=> new WaterHome (),
                 "/track"  :(BuildContext context)=> new Tracker(),
                  "/heart": (BuildContext context) => new Heart(),
                 "/searchActiv"  :(BuildContext context)=> new SearchActivity(),
                 
                 
                  }
    
  
    ),
      ),
       ),
      ),
     )) );
}
class Scoped extends StatelessWidget{
   static var database = AppDatabase();
    var stream = database.loadDaysList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<DayModel>(
          model: DayModel(),
         // child: ScopedModelPage(database: database),
        )
    );
  }

} 