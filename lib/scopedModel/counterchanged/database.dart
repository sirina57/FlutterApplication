import 'dart:io';

import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';


class DayDiary {
 DayDiary(this.id,this.breakfastIds,this.dinnerIds,this.lunchIds,this.snackIds,this.waterIntake,this.weight);
int id;//date or 
//List<int> 
String breakfastIds;
//List<int>
String lunchIds;
//List<int>
String dinnerIds;
//List<int>
String snackIds;
 String waterIntake;

 String weight;
  
  static DayDiary fromMap(Map<String, Object> list) {
    return DayDiary(
     list["id"]  as int,
    list["breakfast"] as String,
     list["lunch"]  as String,
    list["dinner"]  as String,
     list["snack"]  as String,
      list["water"]  as String,
       list["weight"]  as String,
    );
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
     map["id"]  =id;
    map["breakfast"] =breakfastIds;
     map["lunch"] =lunchIds;
    map["dinner"] =dinnerIds; 
     map["snack"] =snackIds;
   map["water"] = waterIntake;
    map["weight"]=weight;
   
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
    String path = join(documentDirectory.path, " mop.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
    "CREATE TABLE days (id INTEGER PRIMARY KEY, breakfast TEXT, lunch TEXT, dinner TEXT ,snack TEXT, water TEXT, weight TEXT )");//!!!!!!!!!!!!!!!!!!!!!!!
    print("Table is created");
      }

   Future<void> createCounter() async {
    int now = DateTime.now().millisecondsSinceEpoch;
     DayDiary day = DayDiary(now,'','','','','','');
    await save(day);
  }
   Future<int> update(DayDiary day) async {
    var dbClient = await db;
    
    int res = await dbClient.update("days", day.toMap(), where: "id = ?", whereArgs: [day.id]);
    return res;
  }
   Future<int> updateId(int id) async {
    var dbClient = await db;
    DayDiary day;
    var val;
     var  oldVal= await dbClient.rawQuery('SELECT * FROM days WHERE id=?',[id])
      .then((onValue)=> onValue.forEach((map)=> val=map
       // print('${map.values}')
        ));
        day =DayDiary.fromMap(val);
   // var  res=  Future.value(db.getDay(id)).then((day)=>oldDay=day).then((onValu)=>DayDiary( oldDay.id,oldDay.breakfastIds, oldDay.lunchIds, oldDay.dinnerIds, oldDay.snackIds, oldDay.waterIntake, oldDay.weight +'*'+val)) ;
 
    
   int res = await dbClient.update("days", day.toMap(), where: "id = ?", whereArgs: [day.id]);
    return res;
  }

//insertion
  Future<int> save(DayDiary weight) async {
    var dbClient = await db;
    int res = await dbClient.insert("days", weight.toMap());
    return res;
  }


// Retrieving 
  Future<List<DayDiary>> getDays() async {
    var dbClient = await db;
  
    List<Map> list = await dbClient.rawQuery('SELECT * FROM days');
    List<DayDiary> days = new List();
    for (int i = 0; i < list.length; i++) {
      days.add(new DayDiary( list[i]["id"], list[i]["breakfast"], list[i]["lunch"], list[i]["dinner"],
       list[i]["snack"], list[i]["water"], list[i]["weight"]));
    }
    print(days.length);
    return days;
  }
  //deletion
  Future<int> deleteDay(DayDiary weight) async {
    var dbClient = await db;
    int res = await dbClient.delete("days");
      return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM days');

print(list);}
Future<List<DayDiary>> loadDaysList() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM days');
  final days = list
        .map<DayDiary>((day) => DayDiary.fromMap(day))
        .toList();

    return days;
  }

}


class DaysModel extends Model {
  DaysModel({Future<List<DayDiary>>  stream}) {
    Stream.fromFuture(stream).listen((days) {
      this.counters = days;
      notifyListeners();
    });
  }

  List<DayDiary> counters;
}
