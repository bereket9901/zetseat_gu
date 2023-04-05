import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetseat_membership/components/default_button.dart';
import 'package:zetseat_membership/models/check_box.dart';
import 'package:zetseat_membership/screens/home/home_page.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  bool isLessonChecked = false;
  String id;
  String date;
  List checkedList = [];
  bool containsZero;
  List lessonList = [];
  Body(
      {required this.isLessonChecked,
        required this.lessonList,
        required this.id,
        required this.date,
        required this.checkedList,
        required this.containsZero});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMember();
    // addMembers();
  }

  bool success = false;

  List memberIds = [];

  var members;
  var url = "$apiUrl/api/SmallGroup";
  SharedPreferences? preferences;
  var body;

  var response;
   String id='';
  void getMember() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences!.getString("id")!;
    String? token = preferences!.getString("token");

    try {
      response = await http.get(
        Uri.parse(url+"/" +id),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
      );

      body = json.decode(response.body);
      print(body);

      setState(() {
        print(body['members'][0]['member']['name']);
        members = body;
      });
      for (int i = 0; i < 14; i++) {
        memberIds.add(members['members'][i]['memberID']);
      }
      print(memberIds);
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, dynamic>> attendancelist = [];

  List<Map<String, dynamic>> lessonListToBackend = [];

  Future<bool> takeAttendance() async {
    String? token = preferences!.getString("token");
    // print(memberIds[0]);
    for (int i = 0; i < members['members'].length; i++) {
      setState(() {
        attendancelist.add({
          "memberID": memberIds[i],
          "present": attendance.contains(memberIds[i])
        });
      });
    }
    int lessonlistLength =
        widget.lessonList == null ? 0 : widget.lessonList.length;

    for (int i = 0; i < lessonlistLength; i++) {
      setState(() {
        lessonListToBackend.add({"teachingContentId": widget.lessonList[i]});
      });
    }

    widget.containsZero != null ? widget.checkedList.add(0) : print(" ");

    print(widget.lessonList);
    //List newList = widget.checkedList.add(0);
    Map<String, dynamic> body = {
      "takenOn": widget.date,
      "smallGroupID": id,
      "session": widget.checkedList.toString(),
      "attendanceDetails": attendancelist,
      "lessonDetails": widget.lessonList == null ? [] : lessonListToBackend
    };

    print(members['members'].length);
    var bodyJson = jsonEncode(body);

    var reponse = await http.post(
      Uri.parse("$apiUrl/api/Attendance"),
      body: bodyJson,
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      },
    );
    print(response.statusCode);
    print(bodyJson);
    if (reponse.statusCode == 200) {
      return true;
    } else if (reponse.statusCode != 200) {
      return false;
    }

    return false;
  }


  List attendance = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: members == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    strokeWidth: 3),
                SizedBox(
                  height: 10,
                ),
                Text("Please wait while loading your members")
              ],
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: ListView.builder(
                          itemCount: members['members'].length,
                          itemBuilder: (context, index) {
                            return CheckBox(
                                title: members['members'][index]['member']
                                    ['name'],
                                checked: attendance.contains(
                                        members['members'][index]['memberID'])
                                    ? true
                                    : false,
                                subtitle: members['members'][index]['member']
                                    ['gender']['name'],
                                icon: Icon(Icons.person),
                                onChanged: (value) {
                                  setState(() {
                                    attendance.contains(members['members']
                                            [index]['memberID'])
                                        ? attendance.remove(members['members']
                                            [index]['memberID'])
                                        : attendance.add(members['members']
                                            [index]['memberID']);
                                  });

                                  // setState(() {
                                  //   isCheck = value;
                                  // });
                                });
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                            strokeWidth: 3)
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: DefaultButton(
                              // textsize: 13,
                              text: "Take Attendance",
                              press: attendance.isEmpty
                                  ? null
                                  : () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      bool success = await takeAttendance();
                                      setState(() {
                                        loading = false;
                                      });
                                      if (success) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Success"),
                                              content: Text(
                                                  "You have Successfully taken attendance"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage()));
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Failed"),
                                              content: Text(
                                                  "Something went wrong, Please try again!"),
                                              actions: [
                                                TextButton(
                                                  child: Text("ok"),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage()));
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      setState(() {
                                        memberIds.clear();
                                        attendance.clear();
                                        // attendancelist.clear();
                                      });
                                      // Get.snackbar("Successful",
                                      //     "You have successfully taken your attendance!");
                                    },
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
