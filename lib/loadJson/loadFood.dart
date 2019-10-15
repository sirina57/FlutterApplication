import 'package:appv1/loadJson/detailsScreen.dart';
import 'package:appv1/loadJson/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;


class FoodList extends StatefulWidget {
   final String meal;
  
    final Key pageindex;

  const FoodList({Key key, this.meal,this.pageindex
  }) : super(key: key);
  @override
  FoodlistState createState() => FoodlistState(meal,pageindex);
}

class FoodlistState extends State<FoodList> {
   final String meal;
    //final int index;
     final Key pageindex;
  StreamController<Food> streamController;
  List<Food> list = [];

  FoodlistState(this.meal,this.pageindex);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
         
          itemBuilder: (BuildContext context, int index) => _makeElement(index),
        ),
      ),
    );
  }

  Widget _makeElement(int index) {
    if (index >= list.length) {
      return null;
    }

    return Card(
      margin: EdgeInsets.all(10.0),
      color: Colors.grey[750],
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListTile(
            onTap: ()=>
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>Details(index,meal,pageindex))),
            title: 
              Text(list[index].title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              subtitle: 
              Text(list[index].calories.toString(),
               style: TextStyle(
                color: Colors.grey[650],),
          ),
        )));
  }
}
