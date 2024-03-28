import 'dart:io';

import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:all_social_app/screens/login_screen.dart';
import 'package:all_social_app/services/login_and_signup_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

TextStyle textStyle = GoogleFonts.montserrat(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  ),
);

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMsg = 'Signed Up!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Text(
                  "Sign up",
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 32.sp),
                  ),
                ),
                SizedBox(height: 41.h),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 200,
                          width: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Choose photo from',
                                style: textStyle,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    pickedImage = File(image.path);
                                    setState(() {
                                      isPicked = true;
                                      debugPrint("$pickedImage");
                                    });
                                  }
                                },
                                child: const CustomPrimaryButton(
                                  label: 'Gallery',
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (image != null) {
                                    pickedImage = File(image.path);
                                    setState(() {
                                      isPicked = true;
                                      debugPrint("$pickedImage");
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
                    child: isPicked
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(300.0),
                            child: Image.file(
                              pickedImage!,
                              fit: BoxFit.fill,
                              height: 100.h,
                              width: 100.h,
                            ),
                          )
                        : Image.asset(
                            "assets/profile_default.png",
                            fit: BoxFit.fill,
                            height: 100.h,
                            width: 100.h,
                          ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Add your photo",
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      "Name",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _nameController,
                        validator: validateName,
                        decoration: InputDecoration(
                          focusColor: const Color(0xffED4D86),
                          contentPadding: const EdgeInsetsDirectional.all(10),
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
                    SizedBox(height: 16.h),
                    Text(
                      'Email',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _emailController,
                        validator: validateEmail,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusColor: const Color(0xffED4D86),
                          contentPadding: const EdgeInsetsDirectional.all(10),
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
                    SizedBox(height: 16.h),
                    Text(
                      'Password',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        validator: validatePassword,
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
                SizedBox(height: 46.h),
                GestureDetector(
                  onTap: () async {
                    setState(() {});
                    if (_key.currentState!.validate() && pickedImage != null) {
                      validateProfilePic(pickedImage!.path);
                      try {
                        uploadImage();
                        await signupService(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                            context);
                        errorMsg = '';
                      } on FirebaseAuthException catch (error) {
                        errorMsg = error.message!;
                      }
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMsg),
                        ),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add profile photo'),
                        ),
                      );
                    }
                    print(errorMsg);
                  },
                  child: const CustomPrimaryButton(
                    label: 'Signup',
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 100.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: const Color(0xff1C1C1C),
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
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: const Color(0xffED4D86),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'Name is required';

    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email format'),
        ),
      );
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required!';
    String pattern = "(?=.*[0-9a-zA-Z]).{6,}";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password must be at least 6 characters'),
          ),
        );
      });
    }
    return null;
  }

  String? validateProfilePic(String? profilePic) {
    if (profilePic == null || profilePic.isEmpty) return 'Photo is required!';
    return null;
  }
}
