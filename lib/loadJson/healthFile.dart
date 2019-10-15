
import 'package:appv1/model/healthart.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
// load from jsonfile

class ArticleList extends StatefulWidget {
  @override
  ArticleListState createState() => ArticleListState();
}

class ArticleListState extends State<ArticleList> {
  StreamController<Article> streamController;
  List<Article> list = [];

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() => list.add(p)));

    load(streamController);
  }

  load(StreamController<Article> sc) async {
    String url ="" ;
   
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(UTF8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Article.fromJsonMap(map))
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
          child: ExpansionTile(
           
             title:
             Row(
               children: <Widget>[
                  Text(list[index].title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
             Text(list[index].current,
               style: TextStyle(
                color: Colors.grey[650],),
          ),

               ],
             ) ,
             children: <Widget>[
               Text(list[index].description),
             ],
             
        )));
  }
}
