import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class LibraryPage extends StatelessWidget {
  static String routeName = "/library";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.library,
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
      "Library ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
