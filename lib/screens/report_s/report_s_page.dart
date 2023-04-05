import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class ReportPage extends StatelessWidget {
  static String routeName = "/report";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.report,
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: SizedBox(),
    centerTitle: true,
    title: Text(
      "Report ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
