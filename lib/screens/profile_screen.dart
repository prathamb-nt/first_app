import 'package:all_social_app/app.dart';
import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/custom%20widgets/custom_text_field.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

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
                            child: Image.network(
                              pickedImage,
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
                            child: CustomTextField(
                              obscureText: false,
                              controller: _nameController,
                              keyboardType: TextInputType.name,
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
                            child: CustomTextField(
                              controller: _emailController,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          updateUser();
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 130, 0, 0),
                          child: CustomPrimaryBtn(
                            label: 'Update',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: CustomSecondaryBtn(
                            label: 'Logout',
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