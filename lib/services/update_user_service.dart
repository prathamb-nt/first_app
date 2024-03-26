import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storageerial.dart';

Future updateUser(String name, String password, String email, String docId,
    String pickedImage, String image) async {
  final String imageUrl = await uploadImage(pickedImage, image);
  final docUser = FirebaseFirestore.instance.collection('users').doc(docId);

  await docUser.update({
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'userName': name,
    'profileImage': imageUrl,
    'password': password,
    'email': email
  });
}

Future<String> uploadImage(String pickedImage, String image) async {
  Reference ref = FirebaseStorage.instance.refFromURL(image);

  UploadTask uploadTask = ref.putFile(
    File(pickedImage),
  );

  try {
    await uploadTask;
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  } on FirebaseException catch (e) {
    return "";
  }
}
