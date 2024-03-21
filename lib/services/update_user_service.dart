import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future updateUser(String name, String password, String email, String docId,
    String pickedImage, String image) async {
  final String imageUrl = await uploadImage(pickedImage, image);
  final docUser = FirebaseFirestore.instance.collection('users').doc(docId);
  print(imageUrl);
  await docUser.update({
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'userName': name,
    'profileImage': imageUrl,
    'password': password,
    'email': email
  });

  debugPrint("updated user");
}

Future<String> uploadImage(String pickedImage, String image) async {
  print(pickedImage);
  Reference ref = FirebaseStorage.instance.refFromURL(image);

  UploadTask uploadTask = ref.putFile(
    File(pickedImage),
  );

  try {
    await uploadTask;
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  } on FirebaseException catch (e) {
    debugPrint("Error uploading image: $e");
    return "";
  }
}
