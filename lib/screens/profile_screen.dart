import 'dart:io';

import 'package:all_social_app/app.dart';
import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:all_social_app/services/update_user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    isPicked = false;
    readUser();

    super.initState();
  }

  late String? pickedImage;

  late final _emailController = TextEditingController(text: email);
  late final _passwordController = TextEditingController(text: password);
  late final _nameController = TextEditingController(text: name!);

  Users? users;
  late String? name;
  late String email;
  late String password;
  late String image;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
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

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMsg = 'Updated!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: FutureBuilder(
            future: readUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                name = snapshot.data!.userName;
                email = snapshot.data!.email;
                password = snapshot.data!.password;
                image = snapshot.data!.profileImage;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48.h,
                        ),
                        Text(
                          "Profile",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 32.sp),
                          ),
                        ),
                        SizedBox(
                          height: 41.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 200,
                                  width: 400,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Choose photo from',
                                        style: textStyle,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (image != null) {
                                            pickedImage = image.path;
                                            setState(() {
                                              isPicked = true;
                                              debugPrint(pickedImage);
                                            });
                                          }
                                        },
                                        child: const CustomPrimaryButton(
                                          label: 'Gallery',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          if (image != null) {
                                            pickedImage = image.path;
                                            setState(() {
                                              isPicked = true;
                                              debugPrint(pickedImage);
                                            });
                                          }
                                        },
                                        child: const CustomSecondaryButton(
                                          label: 'Camera',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: isPicked
                                  ? Image.file(
                                      File(pickedImage!),
                                      fit: BoxFit.fill,
                                      height: 100.r,
                                      width: 100.r,
                                    )
                                  : Image.network(
                                      image,
                                      fit: BoxFit.fill,
                                      height: 100.r,
                                      width: 100.r,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Change your photo",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              "Name",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              child: TextFormField(
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                controller: _nameController,
                                validator: validateName,
                                decoration: InputDecoration(
                                  focusColor: const Color(0xffED4D86),
                                  contentPadding:
                                      const EdgeInsetsDirectional.all(10),
                                  isDense: true,
                                  hintText: 'Enter Name',
                                  hintStyle: textStyle,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffED4D86),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              "Email",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              child: TextFormField(
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                controller: _emailController,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusColor: const Color(0xffED4D86),
                                  contentPadding:
                                      const EdgeInsetsDirectional.all(10),
                                  isDense: true,
                                  hintText: 'Enter Email',
                                  hintStyle: textStyle,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffED4D86),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 130.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_key.currentState!.validate() ||
                                pickedImage != null) {
                              try {
                                await updateUser(
                                    _nameController.text,
                                    _passwordController.text,
                                    email,
                                    docId,
                                    pickedImage!,
                                    image,
                                );
                                errorMsg = 'Signed Up!';
                              } on FirebaseAuthException catch (error) {
                                errorMsg = error.message!;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMsg),
                                ),
                              );
                            }
                          },
                          child: const CustomPrimaryButton(
                            label: 'Update',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully logged out!'),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ),
                            );
                          },
                          child: const CustomSecondaryButton(
                            label: 'Logout',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('no data'),
                );
              }
            }),
      ),
    );
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'Name is required';
    return null;
  }
}
