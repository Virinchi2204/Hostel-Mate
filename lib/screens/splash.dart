import 'package:flutter/material.dart';
import 'package:jahnavi/screens/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.jpg',
      splashIconSize: 300,
      backgroundColor: Colors.black,
      nextScreen: const MyLogin(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

