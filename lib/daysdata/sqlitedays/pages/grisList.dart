
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/diary/diary.dart';
import 'package:appv1/pages/heartRate.dart';
import 'package:appv1/pages/sleep/addSleep.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';
import 'package:appv1/pages/track.dart';
import 'package:appv1/pages/water/addWaterContract.dart';
import 'package:appv1/pages/water/dbHelper.dart';
import 'package:appv1/pages/water/water.dart';
import 'package:appv1/pages/water/waterHome.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/weightHome.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
/**Underweight = <18.5
Normal weight = 18.5 to 24.9
Overweight = 25 to 29.9
Obesity = BMI of 30 or greater */

Future<List<DayDiary>> fetchDaysFromDatabase() async {
  var dbHelper = AppDatabase();
  Future<List<DayDiary>> days = dbHelper.getDays();
  return days;
}



 class MyDaysList extends StatelessWidget implements AddWaterPageContract
//  implements AddDayPageContract
{
 final Key index;
 DayDiary day;
 AddWaterPagePresenter _presenter;
  MyDaysList({ @required this.day, this.index}) {
   
    _presenter = new AddWaterPagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
   
    return 
    ScopedModel<DayModel>(
        model: DayModel(),
        child: ScopedModel<WaterModel>(
        model: WaterModel(),
        child: ScopedModel<SleepModel>(
        model: SleepModel(),
        child:
        Scaffold(
       appBar: AppBar(
              title: Text(day.date),
               leading:  Icon(Icons.home),
               backgroundColor: Colors.red,),
    
      body:ListView(
 children: <Widget>[
// water update page 
 ScopedModelDescendant<WaterModel>(
 builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) =>Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [
     new Image.asset(
     "assets/water.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
       Column(
   
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             
             new Text(''+userModel.currentUser.intake.toString()+"  mL",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),
       
       new Text("                         "+" 2500  mL",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),
       
            ],
          ),
        ),
               
        Padding(
          padding: const EdgeInsets.only(left:30.0,top: 5.0),
          child: SizedBox(
            height: 4.0,
            width: 230.0,
             child: LinearProgressIndicator(
              value: userModel.currentUser.intake==0?0.0001:userModel.currentUser.intake/2500 ,
            ),
          ),
        )
       ] )
    ]),
    onPressed:(){
     Water value =Water(0, 2500, false, 'note');
    model.addItem(value);
     _presenter.doAdd( false, 0, 2500, 'note');
     WaterDatabase().show();
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => WaterHome(mywater: value,)));
    } ) ),
 ),
),

//diary / gained calories
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [
     new Image.asset(
   "assets/plate.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
      Column(
       
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Text((userModel.calories().toString() ??" 0" )+"   Kcal",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),
        ),
         Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Text("                         "+' 1350 Kcal',textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),
        ),  
          ],
        ),
             
       Padding(
          padding: const EdgeInsets.only(left:30.0,top: 5.0),
          child: SizedBox(
            height: 4.0,
            width: 230.0,
             child: LinearProgressIndicator(
              
              value: userModel.calories()==0?0.0001:userModel.calories()/1350 ,
            ),
          ),
        )
       ] )
         ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Diary(index: index,)));
    } ) ),
 ),
 // sleeping history page 

 ScopedModelDescendant<SleepModel>(
 builder: (context, child, model) =>
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [// field("       ,,"/sleep"),
     new Image.asset(
    "assets/lit.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
    Column(
   
      children: <Widget>[
         new Text("           "+userModel.currentUser.sleep,textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),
           
   ],
    )
       ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } ) ),
 ),
),

//weight page 
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(

     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [// field("       ,,"/sleep"),
     new Image.asset(
   "assets/weight.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
      new Text("           "+userModel.currentUser.weight+"    Kg",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),        
    ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => WeightHome()));
    } ) ),
 ),

// burned calories 
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [
     new Image.asset(
  "assets/cal.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
      new Text("           "+" 0    Kcal",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),        
    ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Diary()));
    } ) ),
 ),
 // heart rate page
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [
     new Image.asset(
 "assets/heart.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
      new Text("            No measurement",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),        
    ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Heart()));
    } ) ),
 ),

 // track page      
 ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => Card(
     margin: EdgeInsets.all(10.0),
    color: Colors.grey[800],    
     child:new FlatButton(
       padding: EdgeInsets.all(20.0),
     child:Row(
    mainAxisSize: MainAxisSize.max,
    children: [// field("       ,,"/sleep"),
     new Image.asset(
 "assets/track.png",
     height: 25.0,
    width: 25.0,
    color: Colors.white,),
      new Text("            0    Km",textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),        
    ]),
    onPressed:(){
     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Tracker()));
    } ) ),
 ),
  new Divider()
                          ]
                          )
          ),
      )  ));
      
  }

  @override
  void onAddError(String error) {
  print('$error');
  }

  @override
  void onAddSuccess(Water day) {
   
  }
}