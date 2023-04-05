import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class Lesson extends StatelessWidget {
  static String routeName = "/lesson";
  String id;
  String date;
  List checkedList;

  Lesson({this.id='', this.date='', this.checkedList=const []});

  @override
  Widget build(BuildContext context) {
    // String id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
          child: Body(
        id: id,
        date: date,
        checkedList: checkedList,
      )),
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
      "Lessons/ ትምህርት ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
