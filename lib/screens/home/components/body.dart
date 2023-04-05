import 'package:flutter/material.dart';
import 'package:zetseat_membership/components/custom_surfix_icon.dart';
import 'package:zetseat_membership/components/default_button.dart';
import 'package:zetseat_membership/models/check_box.dart';
import 'package:zetseat_membership/screens/check_list/check_page.dart';
import '../../../size_config.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  String id;
  Body({required this.id});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime date = DateTime.now();
  int id1 = 1;
  List checkedlist = [];

  Future<Null> selectDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
         );
    if (datePicker != null && datePicker != date) {
      setState(() {
        date = datePicker;
      });
    }
  }

  List title = [
    "Doctrine/Discipleship ትምህርት ",
    "Fellowship/ ኅብረት",
    "Prayer/ ጸሎት",
    "Worship/ ምስጋና",
    "Evangelism/ የሚድኑ ሰዎች መጨመር",
    "Sharing/ ማካፈል",
    "Gift/ የጸጋ ስጦታዎች መገለጥ"
  ];
  List subtitle = [
    "if you take a docterinal course",
    "if you had fellowship",
    "if you have been praying",
    "if you had a worship",
    "if you have evangelized",
    "if you have been sharing",
    "if you have excersized to reveal gift of Grace"
  ];
  List<Icon> icon = [
    Icon(Icons.archive),
    Icon(Icons.people),
    Icon(Icons.opacity),
    Icon(Icons.ac_unit),
    Icon(Icons.person_add),
    Icon(Icons.favorite),
    Icon(Icons.card_giftcard)
  ];
  bool isCheck = false;
  bool isLessonChecked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(height: getProportionateScreenHeight(11)),
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return CheckBox(
                    title: title[index],
                    checked: checkedlist.contains(index) ? true : false,
                    subtitle: subtitle[index],
                    icon: icon[index],
                    onChanged: (bool? value) {
                      setState(() {
                        checkedlist.contains(index)
                            ? checkedlist.remove(index)
                            : checkedlist.add(index);
                      });

                      // setState(() {
                      //   isCheck = value;
                      // });
                    });
              }),
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth! * 0.030,
              right: SizeConfig.screenWidth! * 0.030,

              // top: getProportionateScreenWidth(5),
            ),
            child: SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    selectDate(context);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Date",
                  hintText: date.toString().split(" ")[0],
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/clock.svg"),
                ),
              ),
            ),
          ),
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth! * 0.20,
              right: SizeConfig.screenWidth! * 0.20,
              // bottom: SizeConfig.screenHeight * 0.30,
            ),
            child: DefaultButton(
              text: "Next",
              press: checkedlist.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckList(
                                  ic: checkedlist.contains(0) ? true : false,
                                  checkedList: checkedlist,
                                  id: widget.id,
                                  date: date.toString(),
                              lessonList: [],)));
                      print(isCheck);
                    },
            ),
          ),
        ),
      ]),
    );
  }
}
