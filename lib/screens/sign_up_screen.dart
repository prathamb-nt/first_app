import 'dart:io';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

bool isIncorrect = true;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

File? pickedImage;
bool isPicked = false;

bool passwordVisible = true;
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _nameController = TextEditingController();
TextStyle textstyle = GoogleFonts.montserrat(
  textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: isIncorrect ? const Color(0xff353535) : Colors.red),
);

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 41),
                child: Text(
                  "Sign up",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 32),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    pickedImage = File(image.path);
                    setState(() {
                      isPicked = true;
                      print(pickedImage);
                    });
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: isPicked
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: Image.file(
                            pickedImage!,
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                          ),
                        )
                      : Image.asset(
                          "assets/profile_default.png",
                          fit: BoxFit.fill,
                          height: 100,
                          width: 100,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                child: Text(
                  "Add your photo",
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
                        contentPadding: const EdgeInsetsDirectional.all(10),
                        isDense: true,
                        hintText: 'Enter Your Name',
                        hintStyle: textstyle,
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
                        contentPadding: const EdgeInsetsDirectional.all(10),
                        isDense: true,
                        hintText: 'Enter Your Email',
                        hintStyle: textstyle,
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
                      obscureText: passwordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIconColor: passwordVisible
                            ? Colors.grey
                            : const Color(0xffED4D86),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsetsDirectional.all(10),
                        hintText: 'Enter Your Password',
                        hintStyle: textstyle,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 46, 0, 60),
                child: GestureDetector(
                  onTap: () {
                    if (_nameController.text.isEmpty) {
                      setState(() {
                        isIncorrect = !isIncorrect;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Name is Empty!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (_emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email is Empty!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (_passwordController.text.isEmpty) {
                      setState(() {
                        isIncorrect = !isIncorrect;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password is Empty!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      SignUp(context);
                    }
                  },
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
                        'Sign Up',
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff1C1C1C),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' Login',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xffED4D86),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void SignUp(BuildContext context) {
    print('pressed');
    final db = DatabaseHelper();
    db
        .signUp(
      Users(
        userEmail: _emailController.text,
        userPassword: _passwordController.text,
        userName: _nameController.text,
        userImage: pickedImage!.path,
      ),
    )
        .whenComplete(
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }
}
