import 'dart:async';

import 'package:appv1/pages/weight/sqliteweight/dbHelper.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/largerExemple.dart';
import 'package:appv1/screens/moadingIndic.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scoped_model/scoped_model.dart';

Future<List<Weight>> fetchWeightsFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Weight>> weights = dbHelper.getWeights();
  return weights;
}
class TrendsPage extends StatefulWidget {
@override
  TrendsPageState createState() => new TrendsPageState();
}

class TrendsPageState extends State<TrendsPage> {
  @override
  Widget build(BuildContext context) {
    List<double> data =[63.0,60.0];
    return  ScopedModelDescendant<AppModel>(
    builder: (context, child, model) => 
     Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.add),
             onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
          ),
        body:
  Center(
      child: Container( 
      child:new FutureBuilder<List<Weight>>(
            future: fetchWeightsFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                     child: new ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < snapshot.data.length; i++) {
                          print('${snapshot.data[i].newweight}');
                          data.add(double.parse(snapshot.data[i].newweight));
                           print('${snapshot.data[i].newweight}');
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
