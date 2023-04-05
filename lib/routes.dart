import 'package:flutter/widgets.dart';
import 'package:zetseat_gu/screens/announcement/announcement_page.dart';
import 'package:zetseat_gu/screens/check_list/check_page.dart';
import 'package:zetseat_gu/screens/forgot_password/forgot_password_screen.dart';
import 'package:zetseat_gu/screens/home/home_page.dart';
import 'package:zetseat_gu/screens/lesson/lesson.dart';
import 'package:zetseat_gu/screens/lesson_detail/lesson_detail.dart';
import 'package:zetseat_gu/screens/library_s/library_s_page.dart';
import 'package:zetseat_gu/screens/log_in/login_page.dart';
import 'package:zetseat_gu/screens/members_detail/members_details.dart';
import 'package:zetseat_gu/screens/members_list/members_list.dart';
import 'package:zetseat_gu/screens/report_s/report_s_page.dart';
import 'package:zetseat_gu/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  LogInPage.routeName: (context) => LogInPage(),
  SplashScreen.routeName: (context) => SplashScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomePage.routeName: (context) => HomePage(),
  ReportPage.routeName: (context) => ReportPage(),
  LibraryPage.routeName: (context) => LibraryPage(),
  AnnouncementPage.routeName: (context) => AnnouncementPage(),
  CheckList.routeName: (context) => CheckList(),
  Lesson.routeName: (context) => Lesson(),
  LessonDetail.routeName: (context) => LessonDetail(),
  MembersPage.routeName:(context)=>MembersPage(),
  MembersDetailsPage.routeName:(context)=>MembersDetailsPage(id:0,),

};
