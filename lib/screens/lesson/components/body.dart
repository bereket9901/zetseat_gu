import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:zetseat_gu/components/default_button.dart';
import 'package:zetseat_gu/models/check_box.dart';
import 'package:zetseat_gu/screens/lesson_detail/lesson_detail.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  String id;
  String date;
  List checkedList;

  Body({required this.id, required this.date,required this.checkedList});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SharedPreferences? preferences;
  var body;
  var body2;

  var response;

  var response2;
  String id='';
  String url='';
  var lessons;

  var lessonsDetail;

  var checkedlist = [];
  @override
  void initState() {
    // TODO: implement initState
    getLesson();
    super.initState();
  }

  void getLesson() async {
    url = "$apiUrl/api/Teaching";
    preferences = await SharedPreferences.getInstance();
    id = preferences!.getString("id")!;
    String? token = preferences!.getString("token");

    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
      );
      body = json.decode(response.body);

      setState(() {
        lessons = body;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.56,
            child: lessons == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          strokeWidth: 3),
                      Text("Please wait while loading lessons")
                    ],
                  )
                : ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CheckBox(
                              title: lessons[index]["title"],
                              icon: Icon(Icons.pages),
                              checked:
                                  checkedlist.contains(lessons[index]["id"])
                                      ? true
                                      : false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkedlist.clear();
                                  checkedlist.add(lessons[index]["id"]);
                                });
                              })
                        ],
                      );
                    }),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: DefaultButton(
              press: checkedlist.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LessonDetail(
                                    id: checkedlist.first,
                                    smallid: widget.id,
                                    date: widget.date,
                                    checkedList: widget.checkedList,
                                  )));
                    },
              text: "Next",
            ),
          )
        ],
      
    );
  }
}
