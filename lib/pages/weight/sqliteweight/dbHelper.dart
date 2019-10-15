import 'dart:io';

import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, " other.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE weight(id INTEGER PRIMARY KEY, prevweight TEXT, newweight TEXT, date TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveWeight(Weight weight) async {
    var dbClient = await db;
    int res = await dbClient.insert("Weight", weight.toMap());
    return res;
  }


// Retrieving 
  Future<List<Weight>> getWeights() async {
    var dbClient = await db;
   
    List<Map> list = await dbClient.rawQuery('SELECT * FROM weight');
    List<Weight> weights = new List();
    for (int i = 0; i < list.length; i++) {
      weights.add(new Weight( list[i]["prevweight"], list[i]["newweight"],list[i]["date"]));
    }
    print(weights.length);
    return weights;
  }
  //deletion
  Future<int> deleteWeight(Weight weight) async {
    var dbClient = await db;
    int res = await dbClient.delete("Weight");
    return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM weight');

print(list);}

Future<List<Weight>> loadWeightList() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM weight');
  final weights = list
        .map<Weight>((weight) => Weight.fromMap(weight))
        .toList();

    return weights;
  }



}