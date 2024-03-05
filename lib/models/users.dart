import 'dart:convert';

class Users {
  final int? userId;
  final String? userName;
  final String userEmail;
  final String userPassword;
  final String userImage;

  Users(
      {this.userId,
      this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userImage});

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        userImage: json["userImage"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "userImage": userImage,
      };
}

class Posts {
  final int postId;
  final int userId;
  final List<int> post;
  final String postDate;
  final String postTime;
  final String postPlatform;

  Posts({
    required this.postId,
    required this.userId,
    required this.post,
    required this.postDate,
    required this.postTime,
    required this.postPlatform,
  });

  factory Posts.fromMap(Map<String, dynamic> json) => Posts(
        postId: json["postId"],
        userId: json["userId"],
        post: base64Decode(json["post"]),
        postDate: json["postDate"],
        postTime: json["postTime"],
        postPlatform: json["postPlatform"],
      );

  Map<String, dynamic> toMap() => {
        "postId": postId,
        "userId": userId,
        "post": base64Encode(post),
        "postDate": postDate,
        "postTime": postTime,
        "postPlatform": postPlatform,
      };
}