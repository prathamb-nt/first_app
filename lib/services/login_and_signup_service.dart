import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:all_social_app/screens/onboard_screen.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future loginService(String email, String password, BuildContext context) async {
  final user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  if (user != null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}

Future signupService(
    String email, String password, String name, BuildContext context) async {
  final newUser = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  if (newUser != null) {
    createUser(email, password, name);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnBoardingScreen(),
      ),
    );
  }
}

Future createUser(
  String email,
  String password,
  String name,
) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();

  final user = UserFire(
      userId: FirebaseAuth.instance.currentUser!.uid,
      userName: name,
      profileImage: pickedImage!.path,
      password: password,
      email: email);
  final json = user.toJson();
  await docUser.set(json);
}
