import 'package:all_social_app/SQLLite/sqlite.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uuid/uuid.dart';

import 'intro_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();



TextStyle txtstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16));

class _LoginScreenState extends State<LoginScreen> {


  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async {
    var response = await db.login(Users(userPassword: _passwordController.text, userEmail: _emailController.text));
    if(response == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const OnBoardingScreen()),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Login!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        print("invalid login");
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 120, 0, 80),
                child: Text("Login",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 32),
                    )),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsetsDirectional.all(10),
                        isDense: true,
                        labelText: 'Enter Your Email',
                        labelStyle: txtstyle,
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
                      controller: _passwordController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsetsDirectional.all(10),
                        labelText: 'Enter Your Password',
                        labelStyle: txtstyle,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

               Padding(
                padding: const EdgeInsets.fromLTRB(212, 12, 0, 0),
                child: Text('Forgot Password?',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),),
              ),

              GestureDetector(
                onTap: () {
                  login();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 95),
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
                      child: Text('Login',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xffFFFFFC)),
                          )),
                    ),
                  ),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff1C1C1C)),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: Text(' SignUp',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffED4D86)),
                        )),
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
