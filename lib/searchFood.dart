/**import 'package:appv1/loadJson/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;


class SearchFood extends StatefulWidget {
    final String meal;

  const SearchFood({Key key, this.meal}) : super(key: key);
  @override
  SearchFoodState createState() => SearchFoodState(meal);
}

class SearchFoodState extends State<SearchFood> {
    final String meal;
  StreamController<Food> streamController;
  List<Food> list = [];

  SearchFoodState(this.meal);

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() => list.add(p)));

    load(streamController);
  }

  load(StreamController<Food> sc) async {
    String url ="https://api.myjson.com/bins/8232w" ;
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
      appBar: AppBar(
        title: Text('My Food List :'),
        backgroundColor: Colors.red,
      ),
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
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)
               =>Details(index,meal,0))),
            title: 
              Text(list[index].title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              trailing: IconButton(
                onPressed: null,
                icon: Icon(Icons.add,)
              ),
              subtitle: 
              Text(list[index].calories,
               style: TextStyle(
                color: Colors.grey[650],),
          ),
        )));
  }
}

class Food {
  final String title;
  final String calories;
   final String fat;
  final String protein;
  final String carbohydrates;

  Food.fromJsonMap(Map map)
      : title = map['title'],
        calories = map['calories'],
         fat = map['fat'],
          protein = map['protein'],
        carbohydrates = map['carbohydrates'];
}
 */