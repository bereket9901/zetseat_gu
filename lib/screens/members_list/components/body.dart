import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../widgets/card-horizontal.dart';
import '../../members_detail/members_details.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getMember();
  }

  bool success = false;

  List memberIds = [];

  var members;
  var url = "$apiUrl/api/SmallGroup";
  SharedPreferences? preferences;
  var body;

  var response;
  String id = '';

  void getMember() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences!.getString("id")!;
    String? token = preferences!.getString("token");

    try {
      response = await http.get(
        Uri.parse(url + "/" + id),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: members == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
              child: Column(
                children: [
                   const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          strokeWidth: 3)
                      : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: members['members'].length,
                              itemBuilder: (context, index) {
                                return  CardHorizontalTextOnly(tap:(){
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => MembersDetailsPage(id:members['members'][index]['memberID'],),
                                    ),);
                                },
                                  title:members['members'][index]['member']
                                ['name'].toString(),
                                  subTitle: members['members'][index]['member']
                                  ['address']['mobilePhoneNo'].toString(),
                                  cta:"View full detail",
                                );
                              })),
                 const  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
