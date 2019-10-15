import 'dart:async';
import 'package:appv1/pages/sleep/dbHelper.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';
import 'package:appv1/screens/moadingIndic.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scoped_model/scoped_model.dart';

Future<List<Sleep>> fetchWeightsFromDatabase() async {
  var dbHelper = SleepDatabase();
  Future<List<Sleep>> weights = dbHelper.getSleeps();
  return weights;
}

/**FutureBuilder<List<Weight>>(
          future: fetchWeightsFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {} */
class TrendsPage extends StatefulWidget {
@override
  TrendsPageState createState() => new TrendsPageState();
}

class TrendsPageState extends State<TrendsPage> {
 /**List<double> data(){
    List<double> content;
   FutureBuilder<List<Weight>>(
        future: fetchWeightsFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot<List<Weight>> snapshot) {
          if (!snapshot.hasData)
        for (var i = 0; i < snapshot.data.length; i++) {
             content.add(double.parse(snapshot.data[i].newweight));
        }
            });
            return content;
} */

  @override
  Widget build(BuildContext context) {
    List<double> data =[63.0,60.0];
    return  ScopedModelDescendant<SleepModel>(
            builder: (context, child, model) => 
     Scaffold(
      
        body:
  Center(
      child: Container( 
      child:new FutureBuilder<List<Sleep>>(
            future: fetchWeightsFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                                  child: new ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < snapshot.data.length; i++) {
                          data.add(double.parse(snapshot.data[i].score));
                        }
                        

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300.0,
          child: Card(
            margin: EdgeInsets.all(10.0),
          color: Colors.grey[750],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Sparkline(
          data:data,
          fillMode: FillMode.below,
          fillColor: Colors.redAccent,
          pointsMode: PointsMode.all,
          pointSize: 8.0,
          pointColor: Colors.amber,
),
            ),
),
      ),
    );}
    ),
                );
              }
               else{
              return LoadingIndicator();
            } } )
       ),
  ) ));
  }
}
