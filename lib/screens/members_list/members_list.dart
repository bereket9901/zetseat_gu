import 'package:flutter/material.dart';
import 'package:zetseat_membership/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_membership/enums.dart';
import '../../constants.dart';
import 'components/body.dart';

class MembersPage extends StatelessWidget {
  static String routeName = "/members_list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar:const CustomBottomNavBar(
        selectedMenu: MenuState.members,
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: const SizedBox(),
    centerTitle: true,
    title:const Text(
      "Members List",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
