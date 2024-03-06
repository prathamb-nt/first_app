import 'dart:io';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
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

  late String pickedImage = users!.userImage;

  late final _emailController = TextEditingController(text: users!.userEmail);
  late final _passwordController =
      TextEditingController(text: users!.userPassword);
  late final _nameController = TextEditingController(text: users!.userName);

  Users? users;
  late String name;
  late String email;
  late String password;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: isIncorrect ? const Color(0xff353535) : Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Users?>(
          future: DatabaseHelper().getUserById(currentUserId),
          builder: (BuildContext context, AsyncSnapshot<Users?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              users = snapshot.data!;
              name = users!.userName!;
              email = users!.userEmail;
              password = users!.userPassword;
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
                            pickedImage = File(image.path) as String;
                            setState(() {
                              isPicked = true;
                              debugPrint(pickedImage);
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
                          padding: const EdgeInsets.fromLTRB(0, 46, 0, 66),
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
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('nodata'));
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
  void updateUser() async {
    final db = DatabaseHelper();

    String updatedName = _nameController.text;
    String updatedEmail = _emailController.text;
    String updatedPassword = _passwordController.text;

    await db.updateUser(
      Users(
        userId: currentUserId,
        userName: updatedName,
        userEmail: updatedEmail,
        userPassword: updatedPassword,
        userImage: pickedImage,
      ),
    );

    debugPrint("$currentUserId to value $updatedName");
  }
}
