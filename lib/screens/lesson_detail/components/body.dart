import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetseat_membership/components/default_button.dart';

import 'package:zetseat_membership/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zetseat_membership/models/check_box.dart';
import 'package:zetseat_membership/screens/check_list/check_page.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  int id;
  String? f;
  String smallid;
  String date;
  List checkedList;
  Body({required this.id,required this.checkedList,required this.date,required this.smallid});

  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<Body> {
  var teachingContents;

  _BodyState({required this.id});
  List checkedlist = [];
  int id;
  @override
  void initState() {
    // TODO: implement initState
    getTeachingContents();
    super.initState();
  }

  SharedPreferences? preferences;
  var body;
  var h1 = 200, h2 = 400, h3 = 600;

  var response;

  String? url;

  void getTeachingContents() async {
    print(id.toString());
    url = "$apiUrl/api/Teaching" + "/" + id.toString();
    preferences = await SharedPreferences.getInstance();

    String? token = preferences!.getString("token");

    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
      );
      body = json.decode(response.body);

      setState(() {
        teachingContents = body;
      });
      print(teachingContents["teachingContents"][0]["name"]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.56,
            child: teachingContents == null
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
                    itemCount: teachingContents["teachingContents"].length,
                    itemBuilder: (context, index) {
                      return teachingContents["teachingContents"][index]
                                  ["teachingSubContents"] ==
                              null
                          ? CheckBox(
                              title: teachingContents["teachingContents"][index]
                                  ["name"],
                              checked: checkedlist.contains(
                                      teachingContents["teachingContents"]
                                          [index]["id"])
                                  ? true
                                  : false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkedlist.contains(
                                          teachingContents["teachingContents"]
                                              [index]["id"])
                                      ? checkedlist.remove(
                                          teachingContents["teachingContents"]
                                              [index]["id"])
                                      : checkedlist.add(
                                          teachingContents["teachingContents"]
                                              [index]["id"]);
                                });
                              })
                          : ExpansionTile(
                              title: Text(
                                teachingContents["teachingContents"][index]
                                    ["name"],
                                style: TextStyle(
                                  fontSize: SizeConfig.defaultSize!* 1.8,
                                  color: kTextLigntColor,
                                ),
                              ),
                              children: [
                                Container(
                                  color: Colors.amber[100],
                                  width: 500,
                                  height: 250,
                                  child: ListView.builder(
                                      itemCount:
                                          teachingContents["teachingContents"]
                                                  [index]["teachingSubContents"]
                                              .length,
                                      itemBuilder: (context, index2) {
                                        return CheckBox(
                                            title: teachingContents[
                                                            "teachingContents"]
                                                        [index]
                                                    ["teachingSubContents"]
                                                [index2]["name"],
                                            checked: checkedlist.contains(
                                                    teachingContents["teachingContents"]
                                                                [index]
                                                            ["teachingSubContents"]
                                                        [index2]["id"])
                                                ? true
                                                : false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                checkedlist.contains(
                                                        teachingContents["teachingContents"]
                                                                    [index]
                                                                ["teachingSubContents"]
                                                            [index2]["id"])
                                                    ? checkedlist.remove(
                                                        teachingContents["teachingContents"]
                                                                    [index]
                                                                ["teachingSubContents"]
                                                            [index2]["id"])
                                                    : checkedlist.add(
                                                        teachingContents["teachingContents"][index]["teachingSubContents"][index2]["id"]);
                                              });
                                            });
                                      }),
                                )
                              ],
                            );
                    }),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.6,
            child: DefaultButton(
              press: checkedlist.isEmpty
                  ? null
                  : () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        widget.checkedList.remove(0);
                        return CheckList(
                          containsZero: true,
                          lessonList: checkedlist,
                          checkedList: widget.checkedList,
                          date: widget.date,
                          id: widget.smallid,
                        );
                      }));
                    },
              text: "Next",
            ),
          )
        ],
    
    );
  }
}
