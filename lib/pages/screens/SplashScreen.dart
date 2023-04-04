import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wingman/pages/Onboarding/LoginPage.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
  }

  play() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      isZoom = true;
    });
    await Future.delayed(Duration(milliseconds: 1700));

    Navigator.of(context).push(PageTransition(
        duration: const Duration(milliseconds: 200),
        child: const LoginPage(),
        type: PageTransitionType.fade));
  }

  bool isZoom = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 90, 73, 248),
            Color.fromARGB(237, 101, 86, 240),
          ]),
        ),
        child: Center(
            child: AnimatedContainer(
          curve: Curves.elasticOut,
          height: isZoom ? 200 : 0,
          width: isZoom ? w * .5 : 0,
          duration: Duration(milliseconds: 2000),
          child: Image.asset(
            "assets/images/wlogo.png",
            height: 200,
            width: w * .5,
          ),
        )),
      ),
    );
  }
}
