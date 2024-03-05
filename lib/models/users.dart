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
