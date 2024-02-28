import 'package:all_social_app/screens/create_posts/create_post_screen_step_1.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CreatePostScreenStep1()));
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
