import 'dart:async';

import 'package:flutter/material.dart';



class Time extends StatefulWidget {

  @override
  _tState createState() => _tState();
}

class _tState extends State<Time> {
  DateTime _date=new DateTime.now();
  TimeOfDay _time =TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2016),
      lastDate: DateTime(2019)
    );
    if(picked!=null && picked!=_date){
      print('date selected :${_date.toString()}');
      setState(() {
     
              _date=picked;
            });
    }
  }
   Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime:_time, 
   );
    if(picked!=null && picked!=_time){
      print('time selected :${_time.toString()}');
      setState(() {
              _time=picked;
            });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text('date selected :${_date.toString()}'),
            RaisedButton(
              child: Text("select"),
              onPressed: (){
                _selectDate(context);
              },
            ),
            Text('time selected :${_time.toString()}'),
            RaisedButton(
              child: Text("select"),
              onPressed: (){
                _selectTime(context);
              },
            )
          ],
        ),
      ),
    );
  }}