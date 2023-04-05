import 'package:flutter/material.dart';
import 'package:zetseat_membership/constants.dart';
import 'package:zetseat_membership/screens/home/home_page.dart';
import 'package:zetseat_membership/screens/log_in/login_page.dart';

import 'package:zetseat_membership/size_config.dart';

// import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Text(
                      " New Chapter\n New Horizon",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(36),
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    DefaultButton(
                      text: "Let's Begin!",
                      press: () {
                        Navigator.pushReplacementNamed(
                            context, LogInPage.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
