import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MaterialApp(home: SignUpScreen()));
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Icons.home,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blue,
      nextScreen: const SignUpScreen(),
    );
  }
}
