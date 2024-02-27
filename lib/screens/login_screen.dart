import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _nameController = TextEditingController();
TextStyle txtstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16));

class _LoginScreenState extends State<LoginScreen> {
  void _onSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', _emailController.text);
    prefs.setString('password', _passwordController.text);
  }

  Future<String?> _onShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    print(email);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: Column(
            children: [
              // const Text(
              //   'Sign in!',
              //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: TextFormField(
              //     controller: _emailController,
              //     keyboardType: TextInputType.emailAddress,
              //     decoration: const InputDecoration(
              //       labelText: 'Email',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: TextFormField(
              //     controller: _passwordController,
              //     obscureText: true,
              //     decoration: const InputDecoration(
              //       labelText: 'Password',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //       onPressed: () {
              //         setState(() {
              //           _onSubmit();
              //           print(_emailController.text);
              //           print(_passwordController.text);
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => const HomeScreen()));
              //         });
              //       },
              //       child: const Text('Sign Up')),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //       onPressed: () {
              //         setState(() {
              //           _onShow();
              //         });
              //       },
              //       child: const Text('show')),
              // )

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

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 100),
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
