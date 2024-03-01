import 'package:all_social_app/models/usersbar.dart';
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
      final currentUserId = users.userId;
      return true;
    } else {
      return false;
    }
  }

  Future<int> signUp(Users users) async {
    final Database db = await initDB();

    return db.insert('users', users.toMap());
  }

  Future<int> updateUser(Users users) async {
    final Database db = await initDB();

    return await db.update('users', users.toMap(),
        where: 'userId = ?',
        whereArgs: [users.userId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Users>> fetchData() async {
    final Database db = await initDB();
    final res = await db.query('users');
    // inspect(res);
    return res.map((e) => Users.fromMap(e)).toList();
  }

  Future<Users> getUserById(int id) async {
    final Database db = await initDB();
    var res = await db.query('users', where: 'userId = ?', whereArgs: [id]);
    return Users.fromMap(res.first);
  }
}
