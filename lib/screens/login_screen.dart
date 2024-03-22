import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:all_social_app/services/login_and_signup_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginTrue = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMsg = '';
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
                      // height: 40,
                      child:
                          // CustomTextField(
                          //   controller: _emailController,
                          //   hintText: 'Enter Email',
                          //   keyboardType: TextInputType.emailAddress,
                          //   obscureText: false,
                          // ),
                          TextFormField(
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
                      "Password",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      // height: 40,
                      child:
                          // CustomTextField(
                          //     controller: _passwordController,
                          //     hintText: 'Enter Password',
                          //     obscureText: true),
                          TextFormField(
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
                          hintText: 'Enter Password',
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
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(height: 174.h),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                      errorMsg = '';
                    });
                    if (_key.currentState!.validate()) {
                      try {
                        await loginService(_emailController.text,
                            _passwordController.text, context);
                      } on FirebaseAuthException catch (error) {
                        errorMsg = error.message!;
                      }
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMsg),
                        ),
                      );
                    }
                    print(errorMsg);
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
      ),
    );
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Invalid Email format';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    String pattern = "(?=.*[0-9a-zA-Z]).{6,}";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      'Password must be at least 6 characters';
    }
    return null;
  }
}
