import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/custom%20widgets/custom_text_field.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:all_social_app/services/login_and_signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

TextStyle textStyle = GoogleFonts.montserrat(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  ),
);

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: [
              SizedBox(height: 120.h),
              Text(
                "Login",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 32.sp),
                ),
              ),
              SizedBox(height: 80.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
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
                      controller: _emailController,
                      hintText: 'Enter Email',
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Password",
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
                        controller: _passwordController,
                        hintText: 'Enter Password',
                        obscureText: true),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 174.h),
              GestureDetector(
                onTap: () {
                  loginService(
                      _emailController.text, _passwordController.text, context);
                },
                child: const CustomPrimaryBtn(
                  label: 'Login',
                ),
              ),
              SizedBox(height: 100.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
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
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' SignUp',
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
        ),
      ),
    );
  }
}
