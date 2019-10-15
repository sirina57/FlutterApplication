import 'dart:async';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/sleep/addSleepPageContract.dart';
import 'package:appv1/pages/sleep/dbHelper.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';


class HomePage extends StatefulWidget {
  static final String route = "Home-Page";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> implements AddSleepPageContract {
  _MyHomePageState(){
 _presenter = new AddSleepPresenter(this);
  }
   AddSleepPresenter _presenter;
 
  static String _date,_time;
  DateTime _dateTime;
  
  TimeOfDay _timeSlept;
  int _mood;

    DateTime _ndate=new DateTime.now();
  TimeOfDay _ntime =TimeOfDay.now();
 DateTime pickeddate ;
 TimeOfDay pickedTime;
  TextEditingController controller = TextEditingController();
TextEditingController subcontroller = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SleepModel>(
        model: SleepModel(),
        child: Scaffold(
      appBar: AppBar(
         leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
   "assets/lit.png",
     height: 15.0,
    width: 15.0,
   color: Colors.white,
   ),
        ),
        title: Text('Update Sleep'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
         child: IconButton(
    iconSize:110.0,
   icon: Icon(Icons.calendar_today),
   onPressed: () async{
       pickeddate = await showDatePicker(
      context: context,
      initialDate: _ndate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2019) );
      //_date=''+pickeddate.day.toString()+'/'+pickeddate.month.toString()+'/'+pickeddate.year.toString()+' ';

       // print('${_date} *'); 
        setState(() {
         
       _dateTime=pickeddate;
          print('$_dateTime');
         });},
    )),
   Card( margin: EdgeInsets.all(10.0),
    child: IconButton(
     iconSize: 110.0,
     icon: Icon(Icons.access_time),
     onPressed: () async{
     pickedTime = await showTimePicker(
      context: context,
      initialTime:_ntime, );
     // _time=''+pickedTime.hour.toString()+':'+ pickedTime.minute.toString()+'';
       // print('${_time} *');
        setState(() {
       _timeSlept=pickedTime;
       print('$_timeSlept');
        });}, ),
        ), ],
               ),
           Card(
             margin: EdgeInsets.all(30.0),
                        child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row( 
                 mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                   FlatButton(
                     child:Image.asset(
                'assets/smile.png',
                height: 60.0,
                width: 60.0,) ,
                     onPressed:(){
                       _mood=1;
                       print('$_mood');
                     } ,
                   ),
                   FlatButton(
                     child:Image.asset(
                'assets/sad.png',
                height: 60.0,
                width: 60.0,),
               onPressed:(){
                       _mood=0;
                          print('$_mood');
                     } ,)
                 ],
               ),
               
             ),
           ),
          
          ScopedModelDescendant<SleepModel>(
            builder: (context, child, model) => ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) => RaisedButton(
                 color: Colors.green,
                    child: Text('Add Item'),
                    onPressed: () {
                  SleepItem item = SleepItem(_timeSlept,'0',TimeOfDay(hour:0,minute: 0) , _dateTime, 0, '');
                  model.slept(item);
                  userModel.currentUser.sleep=item.timeSlept.hour.toString()+'  hours  '+item.timeSlept.minute.toString()+'  minutes ';
               print('${item.score}');
               model.score(item);
               print('${item.score}');
                     print('${item.debt}');
                      model.debt(item);
                      print('${item.debt}');
                      model.addItem(item);
                    // this.timeSlept,this.score,this.debt,this.dateTime,this.mood,this.target);

                      _presenter.doAdd(item.timeSlept,item.score,item.debt,item.dateTime,item.mood,item.target);
                     
                    },
                  ),
            ),
          ),
        ],
      ),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.done),
            onPressed: () {
            Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => SleepHome()));
            },
          ),
    ));
  }

  @override
  void onAddError(String error) {
    // TODO: implement onLoginError
  print('error: $error');
    
  }

  @override
  void onAddSuccess(SleepItem sleep) async {
   
    var db = new SleepDatabase();
    await db.saveSleep(sleep);
    await db.show();
   // Navigator.of(context).pushNamed("/weight");
  }
}
