import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class AnnouncementPage extends StatelessWidget {
  static String routeName = "/announcement";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.announcement,
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
      "Announcement ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
