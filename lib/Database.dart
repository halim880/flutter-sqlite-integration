import 'package:learn_sqlite/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBprovider {
  DBprovider._();
  static final DBprovider db = DBprovider._();
  static Database? _database;

  Future<Database?> get database async {
    if(_database!=null){
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name CHAR(50),
            email CHAR(50),
            password CHAR(50)
          )
        ''');
      },
      version: 1
    );
  }

  Future<bool> storeUser(User user) async{
    final db = await database;
    try {
      await db!.rawInsert("INSERT INTO users (name, email, password) VALUES (?, ?, ?)", 
        [user.name, user.email, user.password]);
      return true;
    } catch (e) {
      print("Some this was wronge while inserting the data");
      return false;
    }
  }


  getUsers() async {
    final db = await database;
    var users = await db!.query('users', columns: ['id', 'name', 'email']);
    return users;
  }

  Future<bool> deleteUser(int? id) async{
    final db = await database;
    await db!.rawDelete("DELETE FROM users WHERE id == ?", [id]);
    return true;
  }

  Future<bool> updateUser(User user) async{
    final db = await database;
    await db!.rawUpdate("UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?",  
          [user.name, user.email, user.password, user.id]);
    return true;
  }

}