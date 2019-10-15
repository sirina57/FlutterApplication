
//for saving my user into a file 
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;


class UserList extends StatefulWidget {
  @override
  UserState createState() => UserState();
}

class UserState extends State<UserList> {
  StreamController<User> streamController;
  List<User> list = [];

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() => list.add(p)));

    load(streamController);
  }

  load(StreamController<User> sc) async {
    String url ="https://api.myjson.com/bins/8232w" ;
    //https://api.myjson.com/bins/uayvc :weight
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(UTF8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => User.fromJsonMap(map))
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
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>Home())),
            title: 
              Text(list[index].username,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
            //  leading: ,
              subtitle: 
              Text(list[index].email,
               style: TextStyle(
                color: Colors.grey[650],),
          ),
        )));
  }
}
