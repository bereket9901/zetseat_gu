import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Color.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<Body> createState() => _BodyState();
}

DateTime currentTime = DateTime.now();

class _BodyState extends State<Body> {
  String? dropdownValue;
  String? dropdownValueCategory;
  String? text = '';
  bool display = false;
  bool isOnFetch = true;

  @override
  void initState() {
    super.initState();
    getMemberDetails();
  }

  var members;
  var url = "$apiUrl/api/Member";
  SharedPreferences? preferences;
  var body;
  var response;

  void getMemberDetails() async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");

    try {
      response = await http.get(
        Uri.parse(url + "/" + widget.id.toString()),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
      );

      body = json.decode(response.body);

      setState(() {
        members = body;
        isOnFetch = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SafeArea(
        child: !isOnFetch
            ? SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                const CircleAvatar(
                  // backgroundColor: kAvatarColor,
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  members['name'],
                ),
                const SizedBox(height: 10),
                Text(
                  '${members['address']['email']}',
                ),
                const SizedBox(height: 25),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.90,
                  child: Card(
                    elevation: 4,
                    shadowColor: ZColors.muted.withOpacity(0.22),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Basic Information's",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Phone Number',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['address']?['mobilePhoneNo'] ?? "",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Region',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['address']?['region']?['name'] ?? ""
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    '     Address    ',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['address']['region']
                                  ['name']??""),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Specific location',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['address']
                                  ['specificLocation']??""),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'House Number',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['address']['houseNo']??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Date of Birth',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['dateOfBirth'] ?? "",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.90,
                  child: Card(
                    elevation: 4,
                    shadowColor: ZColors.muted.withOpacity(0.22),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Career and Education",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Academic Status',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['educationCareerInfo']['name']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Field of Study',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['educationCareerInfo']
                                    ['fieldOfStudy']
                                        ??"",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Education Level',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['educationCareerInfo']?
                                  ['educationLevel']?['name']
                                      ??""),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'School',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['educationCareerInfo']
                                  ['school']
                                      ??""),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Career Type',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['educationCareerInfo']?
                                    ['careerType']?['name']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Career Name',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['educationCareerInfo']
                                    ['career']['name']
                                        ??"",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.90,
                  child: Card(
                    elevation: 4,
                    shadowColor: ZColors.muted.withOpacity(0.22),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Contact person information",
                                style:  TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Name',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['contactPerson']['name']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Gender',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['contactPerson']['gender']
                                    ['name']
                                        ??"",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Phone Number',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['contactPerson']
                                  ['mobilePhoneNo']
                                      ??""),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Region',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['contactPerson']['region']
                                  ['name']
                                      ??""),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Sub-City',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['contactPerson']['zone']
                                    ['name']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Specific Location',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['contactPerson']
                                    ['specificLocation']
                                        ??"",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.90,
                  child: Card(
                    elevation: 4,
                    shadowColor: ZColors.muted.withOpacity(0.22),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Membership Information's",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Membership Type',
                                    style: kCardSubtitle,

                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['membershipInfo']
                                    ['membershipType']['name']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Membership status',
                                    style:kCardSubtitle),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['membershipInfo']?
                                    ['membershipStatus']?['name'].toString()
                                        ??"",

                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Salvation Year',
                                    style: kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['membershipInfo']
                                  ['salvationDate']
                                      ??""),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Baptized',
                                    style:kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(members['membershipInfo']
                                  ['baptized']
                                      ?members['membershipInfo']
                                  ['baptized'].toString():""),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Text(
                                    'Why Zetseat',
                                    style:kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['membershipInfo']
                                    ['whyZetseat']
                                        ??"",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Branch',
                                    style:kCardSubtitle,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    members['membershipInfo']['branch']
                                    ['name']
                                        ??"",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : spinCircle,
      ),
    );
  }
}