import 'dart:io';

import 'package:appv1/pages/water/water.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WaterDatabase {
  static final WaterDatabase _instance = new WaterDatabase.internal();
  factory WaterDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  WaterDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "water.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE water(id INTEGER PRIMARY KEY, id, achieved TEXT, intake INTEGER, goalIntake INTEGER , note TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveWater(Water water) async {
    var dbClient = await db;
    int res = await dbClient.insert("water", water.toMap());
    return res;
  }
 Future<int> saveIntake(Water water ) async {
    var dbClient = await db;
    int res = await dbClient.rawUpdate('UPDATE water SET intake = ? WHERE id = ?',[water.intake,water.id]);
   
    return res;
  }
Future<int> achieved(Water water ) async {
    var dbClient = await db;
    int res = await dbClient.rawUpdate('UPDATE water SET achieved = ? WHERE id = ?',[water.achieved,water.id]);
   
    return res;
  }

// Retrieving 
  Future<List<Water>> getWaters() async {
    var dbClient = await db;
   
    List<Map> list = await dbClient.rawQuery('SELECT * FROM water');
    List<Water> waterList = new List();
    for (int i = 0; i < list.length; i++) {
      waterList.add(new Water(  list[i]['intake'] ,  list[i]["goalIntake"], list[i]["achieved"],  list[i]["note"]));
    }
    print(waterList.length);
    return waterList;
  }
  //deletion
  Future<int> deleteWater(Water water) async {
    var dbClient = await db;
    int res = await dbClient.delete("water");
    return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM water');

print(list);}

Future<List<Water>> loadWaterList() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM water');
  final water = list
        .map<Water>((weight) => Water.fromMap(weight))
        .toList();

    return water;
  }



}