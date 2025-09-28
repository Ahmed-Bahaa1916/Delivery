import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
   // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE9FAFF),
      body: SizedBox.expand(
        child: Image.asset("assets/images/splash.png", fit: BoxFit.cover),
      ),
    );
  }
}
