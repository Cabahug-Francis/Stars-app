import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'homePage.dart';

void main() => runApp(STARS());

class STARS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {'home': (context) => HomePage()});
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset(
            'assets/nsa.png',
            width: MediaQuery.of(context).size.width * 5,
          ),
        ));
  }
}
