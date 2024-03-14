// import 'dart:developer';
//
// import 'package:all_social_app/models/users.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   final databaseName = "app.db";
//   String users =
//       "CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userEmail TEXT NOT NULL, userPassword TEXT, userImage TEXT)";
//   String posts =
//       "CREATE TABLE posts (postId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, post BLOB NOT NULL, postDate TEXT NOT NULL, postTime TEXT NOT NULL, postPlatform TEXT NOT NULL)";
//   Future<Database> initDB() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, databaseName);
//
//     return openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute(users);
//       await db.execute(posts);
//     });
//   }
//
//   Future<Object> login(Users users) async {
//     final Database db = await initDB();
//
//     var result = await db.rawQuery(
//         "select * from users where userEmail = '${users.userEmail}' AND userPassword = '${users.userPassword}'");
//     if (result.isNotEmpty) {
//       String currentUser = result.first['userId'].toString();
//       debugPrint(currentUser);
//       return currentUser;
//     } else {
//       return false;
//     }
//   }
//
//   Future<int> signUp(Users users) async {
//     final Database db = await initDB();
//
//     return db.insert(
//       'users',
//       users.toMap(),
//     );
//   }
//
//   Future<int> updateUser(Users users) async {
//     final Database db = await initDB();
//
//     return await db.update('users', users.toMap(),
//         where: 'userId = ?',
//         whereArgs: [users.userId],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<List<Users>> fetchData() async {
//     final Database db = await initDB();
//     final res = await db.query('users');
//     // inspect(res);
//     return res.map((e) => Users.fromMap(e)).toList();
//   }
//
//   Future<Users> getUserById(int id) async {
//     final Database db = await initDB();
//     var res = await db.query('users', where: 'userId = ?', whereArgs: [id]);
//     return Users.fromMap(res.first);
//   }
//
//   Future<int> savePost(Posts post) async {
//     final Database db = await initDB();
//
//     // Generate a new postId
//     final postId = await db.insert('posts', post.toMap());
//     debugPrint("Post Saved to database");
//     return postId;
//   }
//
//   Future<List<Posts>> retrievePosts(int userId) async {
//     final Database db = await initDB();
//     final List<Map<String, dynamic>> maps = await db.query(
//       'posts',
//       where: 'userId = ?',
//       whereArgs: [userId],
//     );
//     return maps.map((e) => Posts.fromMap(e)).toList();
//   }
//
//   // Future<List<Posts>> fetchPosts() async {
//   //   final Database db = await initDB();
//   //
//   //   final List<Map<String, dynamic>> maps = await db.query('posts');
//   //   inspect(maps);
//   //   return List.generate(
//   //     maps.length,
//   //     (i) {
//   //       // String base64Image = base64Encode(maps[i]['post']);
//   //       return Posts(
//   //         postId: maps[i]['postId'],
//   //         userId: maps[i]['userId'],
//   //         post: maps[i]['post'] as Uint8List,
//   //         postDate: maps[i]['postDate'],
//   //         postTime: maps[i]['postTime'],
//   //         postPlatform: maps[i]['postPlatform'],
//   //       );
//   //     },
//   //   );
//   // }
//
// // Future<List<Posts>> getPosts() async {
// //   final Database db = await initDB();
// //   final List<Map<String, dynamic>> maps = await db.query('posts');
// //   return maps.map((e) => Posts.fromMap(e)).toList();
// // }
//   Future<List<Posts>> getPosts(int currentUserId) async {
//     final Database db = await initDB();
//     final List<Map<String, dynamic>> maps = await db
//         .query('posts', where: 'userId = ?', whereArgs: [currentUserId]);
//     inspect(maps);
//     return maps.map((e) => Posts.fromMap(e)).toList();
//   }
//
//   Future<Posts> getPostById(int id, int currentUserId) async {
//     final Database db = await initDB();
//     var result = await db.query('posts',
//         where: 'postId = ? AND userId = ?', whereArgs: [id, currentUserId]);
//     // String editPostId = result.first['postId'].toString();
//
//     return Posts.fromMap(result.first);
//   }
//
//   Future<int> updatePost(Posts posts) async {
//     final Database db = await initDB();
//
//     return await db.update('posts', posts.toMap(),
//         where: 'postId = ?',
//         whereArgs: [posts.postId],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
// }
