

import 'package:appv1/daysdata/daysModifications/add.dart';
import 'package:appv1/daysdata/databaseHelper.dart';
import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/daysModifications/updateFoodList.dart';
import 'package:appv1/daysdata/daysModifications/updateWeight.dart';
import 'package:flutter/material.dart';

import 'dart:async';
/**Underweight = <18.5
Normal weight = 18.5 to 24.9
Overweight = 25 to 29.9
Obesity = BMI of 30 or greater */

Future<List<DayDiary>> fetchWeightsFromDatabase() async {
  var dbHelper = AppDatabase();
  Future<List<DayDiary>> weights = dbHelper.getDays();
  return weights;
}

class Mydays extends StatefulWidget {
  @override
  MyWeightListState createState() => new MyWeightListState();
}

class MyWeightListState extends State<Mydays> {
String bmi(String weight){
  const double height=1.66;
  double w=double.parse(weight);
  double bmi = w/(height*height);
  
 return bmi.toStringAsFixed(1);
}



  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
     
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.add),
             onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => AddDay()));
              },
          ),
     
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<DayDiary>>(
          future: fetchWeightsFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    
                    return new Column(
                      children: <Widget>[
                        Text(snapshot.data[index].id.toString()),
                        Text(snapshot.data[index].breakfastIds.toString()),
                        Text(snapshot.data[index].lunchIds.toString()),
                        Text(snapshot.data[index].dinnerIds.toString()),
                        Text(snapshot.data[index].snackIds.toString()),
                        Text(snapshot.data[index].waterIntake),
                        
                        RaisedButton(
                         child: Text(snapshot.data[index].id.toString()),
                           onPressed: () {
                             setState(() {
                                  //model id                          
                                                          });
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => Update()));
              },
                        ),
                        RaisedButton(
                          child: Text(snapshot.data[index].weight),
                           onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => UpdateWeight()));
              },
                        )
                        
                         ]);
                  });
            } else if (snapshot.data.length == 0) {
              return new Text("No Data found");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}