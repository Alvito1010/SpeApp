import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spe_project_app/screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainScreenShown())));
  }

  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
          child: Image(image: AssetImage('assets/sitegas_splash.png'), fit: BoxFit.fill,)),
    );
  }
}

Widget SplashtestWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(
      home: AspectRatio(aspectRatio: 16/9,child: new SplashScreen()),
      debugShowCheckedModeBanner: false,
    ));
