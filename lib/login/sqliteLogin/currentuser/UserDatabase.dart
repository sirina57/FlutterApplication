import 'dart:io';

import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase _instance = new UserDatabase.internal();
  factory UserDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  UserDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "mycurrentUser.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }
// one user
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE currentUser (id INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT  intake INTEGER, sleep TEXT, weight TEXT,Bcalories TEXT,Lcalories TEXT,Dcalories TEXT,Scalories TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("currentUser", user.accountToMap());
    return res;
  }
  Future<int> addUser(User user) async {
    var dbClient = await db;
    deleteUser();
   print('update currentUser');
   return saveUser(user);
   // return await dbClient.rawUpdate('UPDATE currentUser SET username = ? ,password=? ,email= ? ,intake =?, sleep =?, weight =?,Bcalories =?,Lcalories =?, Dcalories = ?,Scalories WHERE id = ?',
    //[user.username,user.password,user.email,user.intake,user.sleep, user.weight, user.breakfastCalories, user.lunchCalories, user.dinnerCalories, user.snackCalories,1]);
   
   
  }

  //deletion
  Future<int> deleteUser() async {
    var dbClient = await db;
    int res = await dbClient.delete("currentUser");
    return res;
  }
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM currentUser');

print(list);
}

Future<User> loadUser() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM currentUser');
  final users = list
        .map<User>((user) => User.accountFromMap(user))
        .toList();

    return users[0];
  }
  
// Retrieving 
  Future<User> getUser() async {
    var dbClient = await db;
   
    List<Map> list = await dbClient.rawQuery('SELECT * FROM currentUser');
    List<User> users = new List();
                                    //User.Account('_username', '_password', '_email', 0, 'sleep', 'weight', 'calories');
      users.add(new User.Account( list[0]["username"], list[0]["password"],list[0]["email"],list[0]["intake"], list[0]["sleep"],list[0]["weight"],list[0]["Bcalories"],list[0]["Lcalories"],list[0]["Dcalories"],list[0]["Scalories"]));
    
  
   return users[0];
  }
Future<List<User>> getUserByemail(String email) async {
    var dbClient = await db;
    //int res = await dbClient.rawUpdate('UPDATE water SET achieved = ? WHERE id = ?',[water.achieved,water.id]);
   
   var list = await dbClient.rawQuery('SELECT * FROM currentUser WHERE email = ?',[email]);
  final users = list
        .map<User>((user) => User.accountFromJsonMap(user))
        .toList();

    return users;
  }




}