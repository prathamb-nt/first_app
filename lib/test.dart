import 'dart:io';

import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/custom%20widgets/custom_text_field.dart';
import 'package:all_social_app/screens/login_screen.dart';
import 'package:all_social_app/services/login_and_signup_service.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                                  });
                                }
                              },
                              child: const CustomPrimaryBtn(
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
                                  });
                                }
                              },
                              child: const CustomSecondaryBtn(
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
                    height: 40,
                    child: CustomTextField(
                      hintText: 'Enter Name',
                      obscureText: false,
                      controller: _nameController,
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
                    height: 40,
                    child: CustomTextField(
                      obscureText: false,
                      controller: _emailController,
                      hintText: 'Enter Email',
                      keyboardType: TextInputType.emailAddress,
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
                    height: 40,
                    child: CustomPasswordTextField(
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 46.h),
              GestureDetector(
                onTap: () {
                  uploadImage();
                  signupService(_emailController.text, _passwordController.text,
                      _nameController.text, context);
                },
                child: const CustomPrimaryBtn(
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
    );
  }
}
