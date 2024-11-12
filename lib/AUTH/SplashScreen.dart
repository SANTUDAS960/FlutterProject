import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internship1/AUTH/CardSlider.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CardSlider()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")
        ,backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/image/image1.png",
            //   height: 130,
            //   width: 200,
            // ),
            // const Text(
            //   "SplashScreen",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // ),
            SizedBox(height: 300,
            width: 300,
            child: Lottie.asset('assets/lottie/otp.json'),)
          ],
        ),
      ),
    );
  }
}


