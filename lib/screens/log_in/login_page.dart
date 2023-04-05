import 'package:flutter/material.dart';
import 'components/body.dart';

class LogInPage extends StatelessWidget {
  static String routeName = "/log_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Body(),
    );
  }
}
