
//  db for handling all my users 
import 'dart:io';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LoginDatabase {
  static final LoginDatabase _instance = new LoginDatabase.internal();
  factory LoginDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  LoginDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "user.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE userTable (id INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("userTable", user.toMap());
    return res;
  }

  //delete
  Future<int> delete() async {
    var dbClient = await db;
    int res = await dbClient.delete("userTable");
    return res;
  }
 // retrieve 
show() async {
  var dbClient = await db;
 List<Map> list = await dbClient.rawQuery('SELECT * FROM userTable');
print(list);
}

Future<List<User>> loadUsers() async {
    var dbClient = await db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM userTable');
  final users = list
        .map<User>((user) => User.fromMap(user))
        .toList();
  return users;
  }
  
// Retrieving 
  Future<List<User>> getUsers() async {
    var dbClient = await db;
   
    List<Map> list = await dbClient.rawQuery('SELECT * FROM userTable');
    List<User> weights = new List();
    for (int i = 0; i < list.length; i++) {// username TEXT, password TEXT, email
      weights.add(new User( list[i]["username"], list[i]["password"],list[i]["email"]));
    }
    print(weights.length);
    return weights;
  }
Future<List<User>> getUser(String email) async {
    var dbClient = await db;
    //int res = await dbClient.rawUpdate('UPDATE water SET achieved = ? WHERE id = ?',[water.achieved,water.id]);
   
   var list = await dbClient.rawQuery('SELECT * FROM userTable WHERE email = ?',[email]);
  final users = list
        .map<User>((user) => User.fromMap(user))
        .toList();

    return users;
  }

}