
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/loadJson/food.dart';
import 'package:appv1/loadJson/mealsModel.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
 GlobalKey<AnimatedCircularChartState> _foodKey =  GlobalKey<AnimatedCircularChartState>();
 
class Details extends StatefulWidget {
  final int indexFood;
  final Key indexPage;
   final String meal;

  const Details(this.indexFood,this.meal,this.indexPage);
  DetailsState createState() => DetailsState(indexFood,meal,indexPage);
}

class DetailsState extends State<Details> {
   final int indexFood;
   final Key indexPage;
    final String meal;
  StreamController<Food> streamController;
  List<Food> list = [];

  DetailsState(this.indexFood,this.meal,this.indexPage);

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() => list.add(p)));

    load(streamController);
  }

  load(StreamController<Food> sc) async {

    String url ="https://api.myjson.com/bins/rfol0" ;
    //https://api.myjson.com/bins/uayvc :weight
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(UTF8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Food.fromJsonMap(map))
        .pipe(sc);
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

 


   Widget _element(Food food) {


    return Center(
          child: SizedBox(
        height: 400.0,
        width: 350.0,
        
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card
            (
             margin: EdgeInsets.all(10.0),
             color: Colors.grey[750],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(food.serving),
              )),
             Card(
          margin: EdgeInsets.all(10.0),
          color: Colors.grey[750],
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('fat',
                   style: TextStyle(
                    fontSize: 13.0,
                     color: Colors.grey[900],
                   ),
              ),
                   Text(food.fat,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[650],
                  ),
                  ),
                  Text('protein',
                   style: TextStyle(
                    fontSize: 13.0,
                     color: Colors.grey[900],
                   ),
              ),
                  Text(food.protein,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[650],
                  ),
                  ),
                  Text('carbohydrates',
                   style: TextStyle(
                    fontSize: 13.0,
                     color: Colors.grey[900],
                   ),
              ),
                  Text(food.carbohydrates,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[650],
                  ),
                  ), ],
                 )

            )),
            //
             Card(
                 margin: EdgeInsets.all(10.0),
          color: Colors.grey[750],
            child: Padding(
              padding: EdgeInsets.all(20.0),
  child: AnimatedCircularChart(
  key: _foodKey,
  size:const Size(100.0,100.0),
  
  initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
               double.parse(food.carbohydrates),
                Colors.yellow,
                rankKey: 'completed',
            ),
             CircularSegmentEntry(
               double.parse(food.fat),
                Colors.red,
                rankKey: 'completed',
            ),
             CircularSegmentEntry(
             double.parse(food.protein),
                Colors.green,
                rankKey: 'completed',
            ),
            
          ],
          rankKey: 'progress',
        ),
  ],
  chartType: CircularChartType.Radial,
  percentageValues: true,
  holeLabel: food.calories.toString(),
  labelStyle: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
  ),
),
             ))
            ],
        ),
      ),
    );
   }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
         leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
   "assets/plate.png",
     height: 15.0,
    width: 15.0,
   color: Colors.white,
   ),
        ),
        title: Text('Details'),
      ),
floatingActionButton:
ScopedModelDescendant<DayModel>(
            builder: (context, child, daymodel) => 
 ScopedModelDescendant<MealsModel>(
            builder: (context, child, mealmodel) => 
    ScopedModelDescendant<UserModel>(
              builder: (context, child, usermodel) => 
   FloatingActionButton(
      
      backgroundColor: Colors.green,
      child:Icon(Icons.done),
       onPressed: () {
           print('*');
             usermodel.addCalories(meal, list[indexFood].calories); 
       // daymodel.addCalories(meal,  list[indexFood].calories, indexPage);
         print('1');
        mealmodel.addItem(list[indexFood], meal);
        print('${mealmodel.breakfast[0].title}');//add to list of food for meal
         print('2');
        //add calories to day model + usermodel
     print('3');
       Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => Diary()));
      },
      ),
   ),
 ),
),
      body:SafeArea(
child:list.isEmpty?Center(
  child:CircularProgressIndicator(
   ),
) : _element(list[indexFood]),

      
      )
       
      );
    
  }

}