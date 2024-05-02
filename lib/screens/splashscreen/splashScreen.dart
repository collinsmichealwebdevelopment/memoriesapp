import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/screens/LandingPage/landingPage.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ConstantColors constantColors = ConstantColors();
  @override
  void initState() {
    Timer(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context,
            PageTransition(
                child:  Landingpage(),
                type: PageTransitionType.leftToRight)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.darkColor,
        body: Center(
            child: Text(
              "Memories",
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            )));
  }
}
