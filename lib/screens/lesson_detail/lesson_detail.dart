import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class LessonDetail extends StatelessWidget {
  int id;
  String smallid;
  String date;
  List checkedList;
  LessonDetail({this.id=0,this.checkedList=const [], this.date='', this.smallid=''});
  static String routeName = "/lessondetail";
  @override
  Widget build(BuildContext context) {
    // String id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
          child: Body(
        id: id,
        smallid: smallid,
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
      "Lesson Detail/ የትምህርት ዝርዝር",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
