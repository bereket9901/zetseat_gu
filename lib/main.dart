// @dart=2.9
import 'package:flutter/material.dart';
import 'package:zetseat_membership/routes.dart';
import 'package:zetseat_membership/screens/splash/splash.dart';
import 'package:zetseat_membership/theme.dart';
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
      backgroundColor: const Color(0xFFFFFEFF),
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
              child: Image.asset("assets/images/zetseat.gif",
                  gaplessPlayback: true, fit: BoxFit.fill),
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
