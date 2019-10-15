import 'dart:io';

import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class Counter {
  Counter(this.id, this.value);
  int id;
  int value;
  
  static Counter fromMap(Map<String, Object> list) {
    return Counter(
     list["id"]  as int,
    list["value"] as int);
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["key"] = id;
    map["value"] = value;
    return map;
}
}

class AppDatabase {
  static final AppDatabase _instance = new AppDatabase.internal();
  factory AppDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  AppDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, " counter.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE counter(id INTEGER PRIMARY KEY, key INTEGER, value INTEGER)");
    print("Table is created");
  }
   Future<void> createCounter() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    Counter counter = Counter(now,0);
    await save(counter);
  }
   Future<int> update(Counter weight) async {
    var dbClient = await db;
    
    int res = await dbClient.update("counter", weight.toMap(), where: "id = ?", whereArgs: [weight.id]);
    return res;
  }

//insertion
  Future<int> save(Counter weight) async {
    var dbClient = await db;
    int res = await dbClient.insert("counter", weight.toMap());
    return res;
  }


// Retrieving 
  Future<List<Counter>> getWeights() async {
    var dbClient = await db;
  
    List<Map> list = await dbClient.rawQuery('SELECT * FROM counter');
    List<Counter> weights = new List();
    for (int i = 0; i < list.length; i++) {
      weights.add(new Counter( list[i]["key"], list[i]["value"]));
    }
    print(weights.length);
    return weights;
  }
  //deletion
  Future<int> deleteWeight(Counter weight) async {
    var dbClient = await db;
    int res = await dbClient.delete("counter");
    return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM counter');

print(list);}

Future<List<Counter>> loadWeightList() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM counter');
  final weights = list
        .map<Counter>((weight) => Counter.fromMap(weight))
        .toList();

    return weights;
  }

}


class CountersModel extends Model {
  CountersModel({Future<List<Counter>>  stream}) {
    Stream.fromFuture(stream).listen((counters) {
      this.counters = counters;
      notifyListeners();
    });
  }

  List<Counter> counters;
}
