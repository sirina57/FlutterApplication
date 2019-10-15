
import 'dart:io';

import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';



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
    String path = join(documentDirectory.path, " threeDays.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
    "CREATE TABLE days (id INTEGER PRIMARY KEY, date TEXT,breakfast INTEGER, lunch INTEGER, dinner INTEGER ,snack INTEGER, water TEXT, weight TEXT )");//!!!!!!!!!!!!!!!!!!!!!!!
    print("Table is created");
  }
  // day
//insertion
  Future<int> save(DayDiary day) async {
    var dbClient = await db;
    int res = await dbClient.insert("days", day.toMap());
    return res;
  }
  
   Future<int> update(DayDiary day) async {
    var dbClient = await db;
    
    int res = await dbClient.update("days", day.toMap(), where: "id = ?", whereArgs: [day.id]);
    return res;
  }
 Future<int> saveWeight(DayDiary day, String weight) async {
    var dbClient = await db;
    //int res = await dbClient.insert("days", day.toMap());
    
     int res =await dbClient.rawUpdate('UPDATE days SET weight = ? WHERE id = ?',[weight,day.id]);
   
    return res;
  }

   Future<int> saveWater(DayDiary day, String intake) async {
    var dbClient = await db;
   int res =await dbClient.rawUpdate('UPDATE days SET water = ? WHERE id = ?',[intake,day.id]);
    return res;
  }
   Future<int> saveBreakfast(DayDiary day,String ids) async {
    var dbClient = await db;
    int res = await dbClient.rawUpdate('UPDATE days SET breakfast = ? WHERE id = ?',[ids,day.id]);  
      return res;
  }
   Future<int> savelunch(DayDiary day ,String ids) async {
    var dbClient = await db;
    int res = await dbClient.rawUpdate('UPDATE days SET lunch = ? WHERE id = ?',[ids,day.id]);
   return res;
  }
   Future<int> saveDinner(DayDiary day ,String ids) async {
    var dbClient = await db;
    int res =  await dbClient.rawUpdate('UPDATE days SET dinner = ? WHERE id = ?',[ids,day.id]);
  return res;
  }
   Future<int> saveSnack(DayDiary day,String ids) async {
    var dbClient = await db;
    int res =await dbClient.rawUpdate('UPDATE days SET snack = ? WHERE id = ?',[ids,day.id]);
   
    return res;
  }


// Retrieving 
  Future<List<DayDiary>> getDays() async {
    var dbClient = await db;
  
    List<Map> list = await dbClient.rawQuery('SELECT * FROM days');
    List<DayDiary> days = new List();
    for (int i = 0; i < list.length; i++) {
      days.add(new DayDiary(  list[i]["date"],  list[i]["breakfast"], list[i]["lunch"], list[i]["dinner"],
       list[i]["snack"], list[i]["water"], list[i]["weight"]));
    }
 
    return days;
  }
  //deletion
  Future<int> deleteDay() async {
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

   Future<void> create() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    DayDiary day = DayDiary('',0,0,0,0,'','');
    await save(day);
  }
  
 
 Future<DayDiary> getDay(int id) async {
    var dbClient = await db;
    DayDiary val;
    Map<String,dynamic> day;
      var  oldVal= await dbClient.rawQuery('SELECT * FROM days WHERE id=?',[id])
      .then((onValue)=> onValue.forEach((map)=> day=map
       // print('${map.values}')
        ));
        val=DayDiary.fromMap(day);
        print(' map : $day');
         print(' day : ${val.id}');

    return val;
  }



  Future<int> addFood(DayDiary day ,String meal ,int foodId) async {
    var dbClient = await db;
  
     if(meal == 'breakfast'){
  
    return await dbClient.rawUpdate('UPDATE days SET breakfast = ? WHERE id = ?',[day.breakfastIds+foodId,day.id]);
    }else if (meal == 'lunch'){
      return await dbClient.rawUpdate('UPDATE days SET lunch = ? WHERE id = ?',[day.lunchIds+foodId,day.id]);
    }else if (meal =='dinner'){
   return await dbClient.rawUpdate('UPDATE days SET dinner = ? WHERE id = ?',[day.dinnerIds +foodId,day.id]);
    }else if (meal=='snack'){
    return await dbClient.rawUpdate('UPDATE days SET snack = ? WHERE id = ?',[day.snackIds +foodId,day.id]);
    }else{
      return 0;
   
    }
  
  }
   Future<int> addWater(DayDiary day,String intake) async {
    var dbClient = await db;
   
    int re =await dbClient.rawUpdate('UPDATE days SET water = \'${intake}\''
  );
    return re;
  }
   Future<int> addWeight(DayDiary day,String weight) async {
    var dbClient = await db;
    String val;
      var  oldVal= await dbClient.rawQuery('SELECT weight FROM days WHERE id=?',[day.id])
      .then((onValue)=> onValue.forEach((map)=> val=map.values.toString()
       // print('${map.values}')
        ));
        print(' map : $val');
    
     int res =await dbClient.rawUpdate('UPDATE days SET weight = ? WHERE id = ?',[val +weight,day.id]);
    int re =await dbClient.rawUpdate('UPDATE days SET weight = \'${weight}\''
  );
    return res;
  }
}


