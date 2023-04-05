import 'package:flutter/material.dart';
import 'package:zetseat_membership/constants.dart';
import 'package:zetseat_membership/size_config.dart';

import 'login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight!* 0.04), // 4%
              Text("Membership Class", style: headingStyle),
              const Text(
                " New Chapter",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),
              const LogInForm(),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),

              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                'To see a generation suitable to \nGod risen globally',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
    ),
    ));
  }
}
