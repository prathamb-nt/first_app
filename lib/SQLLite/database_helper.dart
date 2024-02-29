import 'package:all_social_app/models/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "app.db";
  String users =
      "CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userEmail TEXT NOT NULL, userPassword TEXT)";
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  Future<bool> login(Users users) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select * from users where userEmail = '${users.userEmail}' AND userPassword = '${users.userPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> signUp(Users users) async {
    final Database db = await initDB();

    return db.insert('users', users.toMap());
  }
}
