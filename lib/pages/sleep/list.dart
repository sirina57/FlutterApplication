
import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/sleep/dbHelper.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';
import 'package:appv1/screens/moadingIndic.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
/**Underweight = <18.5
Normal weight = 18.5 to 24.9
Overweight = 25 to 29.9
Obesity = BMI of 30 or greater */

Future<List<Sleep>> fetchsleepFromDatabase() async {
  var dbHelper = SleepDatabase();
  Future<List<Sleep>> weights = dbHelper.getSleeps();
  return weights;
}
void _delete() async{
   var db = new SleepDatabase();
    await db.delete();

}



class MySleepList extends StatefulWidget {
  @override
  MySleepListState createState() => new MySleepListState();
}

class MySleepListState extends State<MySleepList> {

 Image moodIcon( int mood){
  
  if(mood==1)  {return  Image.asset(
            'assets/smile.png',
            height: 30.0,
            width: 30.0,);}
 else  if(mood==0)  {
   return  Image.asset(
            'assets/sad.png',
            height: 30.0,
            width: 30.0,);
 }
 else{
   return
   Image.asset(
            'assets/red.png',
            height: 30.0,
            width: 30.0,);
 }
  
 }

  @override
  Widget build(BuildContext context) {
   
    return 
  ScopedModelDescendant<SleepModel>(
            builder: (context, child, model) => 
             Scaffold(
       
       
       
        body: new Container(
          padding: new EdgeInsets.all(4.0),
          child:  ScopedModelDescendant<SleepModel>(
              builder: (context, child, model) => 
             FutureBuilder<List<Sleep>>(
            future: fetchsleepFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      
 return new Column(
   
 children: <Widget>[
 /* Dismissible(
                             key: Key('_${snapshot.data[index].timeSlept}'),
                             onDismissed: (horizontal) {
                                 _delete();
                                   model.delete();
                             

                             },
      child:*/ Card(
      
    color: Colors.grey[750],    
       child:Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text(
     snapshot.data[index].dateTime,
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    moodIcon(snapshot.data[index].mood),
                 
                 ],
               ),
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text(
                        'Sleep score',        
                        style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
                    ),
                     Text(
                        'Sleep Debt',        
                        style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
                    ),
                     Text(
                   snapshot.data[index].timeSlept,        
                        style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                 ],
             ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 children: <Widget>[
                    Text(
                     '      '+  snapshot.data[index].score,     
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                   Text(
                      '                                           '+ snapshot.data[index].debt,        
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),

                 ],
               ),
             )
           ],
         ),
       ) 
  ),
                 ]);
                    });
              } else {
                 return LoadingIndicator();
              }    },
          ),
        ),
       ) ),
    );
  }
}