import 'dart:io';

import 'package:appv1/pages/sleep/sleep.dart';

import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SleepDatabase {
  static final SleepDatabase _instance = new SleepDatabase.internal();
  factory SleepDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SleepDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "sleep.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE sleep (id INTEGER PRIMARY KEY,dateTime TEXT,timeSlept TEXT,target TEXT,score TEXT,debt TEXT,mood INTEGER)");
    print("Table is created");
  }

//insertion
  Future<int> saveSleep(SleepItem water) async {
    var dbClient = await db;
    
    int res = await dbClient.insert("sleep", Sleep.fromItem(water).toMap());
    return res;
  }

Future<int> achieved(Sleep sleep ) async {
    var dbClient = await db;
    int res = await dbClient.rawUpdate('UPDATE sleep SET score = ? WHERE id = ?',[sleep.score,sleep.id]);
   
    return res;
  }

// Retrieving 
  Future<List<Sleep>> getSleeps() async {
    var dbClient = await db;
   
    List<Map> list = await dbClient.rawQuery('SELECT * FROM sleep');
    List<Sleep> sleepList = new List();
    for (int i = 0; i < list.length; i++) {//String timeSlept, String score, String debt, String dateTime, bool mood, String target)
      sleepList.add(new Sleep(  list[i]['timeSlept'] ,  list[i]["score"], list[i]['debt'] ,  list[i]["dateTime"], list[i]["mood"],  list[i]["target"]));
    }
    print(sleepList.length);
    return sleepList;
  }
  //delete
  Future<int> delete() async {
    var dbClient = await db;
    int res = await dbClient.delete("sleep");
    return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM sleep');

print(list);}

Future<List<Sleep>> loadSleepList() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM sleep');
  final sleep = list
        .map<Sleep>((weight) => Sleep.fromMap(weight))
        .toList();

    return sleep;
  }



}