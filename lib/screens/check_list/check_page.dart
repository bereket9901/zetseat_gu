import 'package:flutter/material.dart';
import 'package:zetseat_gu/components/custom_bottom_nav_bar.dart';
import 'package:zetseat_gu/screens/lesson/lesson.dart';

import '../../constants.dart';
import '../../enums.dart';
import 'components/body.dart';

class CheckList extends StatelessWidget {
  bool ic;
  bool containsZero;
  String date;
  List checkedList;
  List lessonList;
  String id;
  CheckList(
      {this.ic=false,
      this.id='',
      this.date='',
       this.checkedList=const [],
      this.containsZero=false,
       this.lessonList=const []});
  static String routeName = "/checklist";
  @override
  Widget build(BuildContext context) {
    return !checkedList.contains(0)
        ? Scaffold(
            appBar: buildAppBar(context),
            body: Body(
              id: id,
              lessonList: lessonList,
              containsZero: containsZero,
              date: date,
              checkedList: checkedList,
              isLessonChecked: true,
            ),
            bottomNavigationBar: CustomBottomNavBar(
              selectedMenu: MenuState.home,
            ),
          )
        : Lesson(
            id: id,
            date: date,
            checkedList: checkedList,
          );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: SizedBox(),
    centerTitle: true,
    title: Text(
      "Attendance List/ የስም ዝርዝር ",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
