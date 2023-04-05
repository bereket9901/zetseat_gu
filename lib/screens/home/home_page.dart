import 'package:flutter/material.dart';
import 'package:zetseat_membership/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_membership/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(id: id),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: SizedBox(),
    centerTitle: true,
    title: Text(
      "Chores/ ድርጊቶች ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
