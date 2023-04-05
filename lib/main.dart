// @dart=2.9
import 'package:flutter/material.dart';
import 'package:zetseat_gu/routes.dart';
import 'package:zetseat_gu/screens/splash/splash.dart';
import 'package:zetseat_gu/theme.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    theme: theme(),
    routes: routes,
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              // height: double.infinity,
              width: double.infinity,
              child: Image.asset("assets/images/Generation-unit.gif",
                  gaplessPlayback: true, fit: BoxFit.contain),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 40),
              child: const Text(
                  "                                    Version 1.0 \nPowered By Zetseat Tech © 2023, All rights reserved"),
            )
          ],
        ),
      ),
    );
  }
}
