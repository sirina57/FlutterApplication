
import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/weight/sqliteweight/dbHelper.dart';

import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/largerExemple.dart';
import 'package:appv1/screens/moadingIndic.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
/**Underweight = <18.5
Normal weight = 18.5 to 24.9
Overweight = 25 to 29.9
Obesity = BMI of 30 or greater */

Future<List<Weight>> fetchWeightsFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Weight>> weights = dbHelper.getWeights();
  return weights;
}
void _delete(Weight weight) async{
   var db = new DatabaseHelper();
    await db.deleteWeight(weight);

}



class MyWeightList extends StatefulWidget {
  @override
  MyWeightListState createState() => new MyWeightListState();
}

class MyWeightListState extends State<MyWeightList> {
String bmi(String weight){
  const double height=1.66;
  double w=double.parse(weight);
  double bmi = w/(height*height);
  
 return bmi.toStringAsFixed(1);
}

List<double> data(){
    List<double> content;
   FutureBuilder<List<Weight>>(
        future: fetchWeightsFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot<List<Weight>> snapshot) {
          if (!snapshot.hasData){
        for (var i = 0; i < snapshot.data.length; i++) {
             content.add(double.parse(snapshot.data[i].newweight));
        }} else{
              return LoadingIndicator();
            }
            });
            print(content);
            return content;
}


  @override
  Widget build(BuildContext context) {
   
    return 
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
     
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child:  ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => 
           FutureBuilder<List<Weight>>(
          future: fetchWeightsFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    
                    return new Column(
                      children: <Widget>[
                        new Divider(),
                           /**Dismissible(
                             key: Key('_${snapshot.data[index].date}'),
                             onDismissed: (horizontal) {
                              _delete(snapshot.data[index]);
                               Item item= Item(snapshot.data[index].newweight,snapshot.data[index].prevweight,snapshot.data[index].date);
                                 model.deleteItem(item);}, child: */
                         ListTile(
                         onLongPress: () {
                                 _delete(snapshot.data[index]);
                               Item item= Item(snapshot.data[index].newweight,snapshot.data[index].prevweight,snapshot.data[index].date);
                                 model.deleteItem(item);
                             

                             },        
                         contentPadding:EdgeInsets.all(10.0),
                          title: 
                          new Text(snapshot.data[index].date,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15.0)),
                                    subtitle: 
                          new Text('BMI : '+bmi(snapshot.data[index].newweight),
                                style: new TextStyle(
                                    fontSize: 13.0)),
                        trailing:  new Text(snapshot.data[index].newweight,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30.0))),
                           
                          new Divider()
                        ]);
                  });
            }else
             {
                
              return LoadingIndicator();
             }
            } 
        ),
      ),
     ) );
  }
}