import 'dart:io';

import 'package:all_social_app/app.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AccountWidget extends StatefulWidget {
  final String currentUser;

  const AccountWidget({
    super.key,
    required this.currentUser,
  });

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  void initState() {
    super.initState();
  }

  late int currentUserId = int.parse(widget.currentUser);

  late String pickedImage = image;

  late final _emailController = TextEditingController(text: email);
  late final _passwordController = TextEditingController(text: password);
  late final _nameController = TextEditingController(text: name);

  Users? users;
  late String name;
  late String email;
  late String password;
  late String image;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: isIncorrect ? const Color(0xff353535) : Colors.red),
  );
  late String docId = "docSnapshot.id";
  Future<UserFire?> readUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          docId = docSnapshot.id;
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );

    final docUser = FirebaseFirestore.instance.collection('users').doc(docId);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserFire.fromJson(snapshot.data()!);
    }
  }

  changeCred({oldEmail, newEmail, oldPassword, newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: oldEmail, password: oldPassword);

    await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(cred)
        .then((value) {
      FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
    }).catchError((error) {
      debugPrint(
        error.toString(),
      );
    });

    await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(cred)
        .then((value) {
      FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
    }).catchError((error) {
      debugPrint(
        error.toString(),
      );
    });
    debugPrint("updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              name = snapshot.data!.userName;
              email = snapshot.data!.email;
              password = snapshot.data!.password;
              image = snapshot.data!.profileImage;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 41),
                        child: Text(
                          "Profile",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 32),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            pickedImage = image.path;
                            setState(() {
                              isPicked = true;
                            });
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300.0),
                            child: Image.file(
                              File(pickedImage),
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                        child: Text(
                          "Change your photo",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 24, 8),
                            child: Text(
                              "Name",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsetsDirectional.all(10),
                                isDense: true,
                                labelText: 'Enter Your Name',
                                labelStyle: textstyle,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 24, 8),
                            child: Text(
                              "Email",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsetsDirectional.all(10),
                                isDense: true,
                                labelText: 'Enter Your Email',
                                labelStyle: textstyle,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 24, 8),
                            child: Text(
                              "Password",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                alignLabelWithHint: false,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsetsDirectional.all(10),
                                labelText: 'Enter Your Password',
                                labelStyle: textstyle,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          updateUser();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 46, 0, 0),
                          child: Container(
                            height: 40,
                            width: 342,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: Color(0xffED4D86),
                            ),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xffFFFFFC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: 40,
                            width: 342,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: Color(0xffFFFFFC),
                            ),
                            child: Center(
                              child: Text(
                                'Logout',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xffED4D86),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('nodata'),
              );
            }
          }),
    );
  }

  // void update(BuildContext context) {
  //   debugPrint('pressed');
  //   final db = DatabaseHelper();
  //   db
  //       .updateUser(
  //     Users(
  //       userEmail: _emailController.text,
  //       userPassword: _passwordController.text,
  //       userName: _nameController.text,
  //     ),
  //   )
  //       .whenComplete(() {
  //     debugPrint('UPDATED');
  //   });
  // }
  Future updateUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(docId);

    // await FirebaseAuth.instance.currentUser?.updateEmail(_emailController.text);
    // await FirebaseAuth.instance.currentUser
    //     ?.updatePassword(_passwordController.text);

    await docUser.update({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userName': _nameController.text,
      'profileImage': pickedImage,
      'password': _passwordController.text,
      'email': email
    });
    await changeCred(
        oldEmail: email,
        newEmail: _emailController.text,
        newPassword: _passwordController.text,
        oldPassword: password);
    debugPrint("updated user");
  }
}
