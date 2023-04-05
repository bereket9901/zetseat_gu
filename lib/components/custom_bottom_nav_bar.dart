import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zetseat_membership/screens/announcement/announcement_page.dart';
import 'package:zetseat_membership/screens/home/home_page.dart';
import 'package:zetseat_membership/screens/library_s/library_s_page.dart';
import 'package:zetseat_membership/screens/report_s/report_s_page.dart';
// import 'package:shop_app/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';
import '../screens/members_list/members_list.dart';
// import 'icon_btn_with_counter.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Home.svg",
                  color: MenuState.members == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, MembersPage.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomePage.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/List.svg",
                  color: MenuState.library == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, LibraryPage.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/bookmark.svg",
                  color: MenuState.report == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ReportPage.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Bell.svg",
                  color: MenuState.announcement == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AnnouncementPage.routeName),
              ),

              // IconBtnWithCounter(
              //   svgSrc: "assets/icons/Bell.svg",
              //   numOfitem: "3",
              //   press: () {},
              // ),
            ],
          )),
    );
  }
}
