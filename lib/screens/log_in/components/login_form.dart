import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:zetseat_membership/components/custom_surfix_icon.dart';
import 'package:zetseat_membership/components/form_error.dart';
// import 'package:zetseat_gu/screens/forgot_password/forgot_password_screen.dart';
import 'package:zetseat_membership/screens/home/home_page.dart';
import 'package:zetseat_membership/screens/members_detail/members_details.dart';
import 'package:zetseat_membership/screens/members_list/members_list.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameContoller = new TextEditingController();
  TextEditingController passwordContoller = new TextEditingController();
  String?  user;
  String?  password;
  bool remember = false;
  bool load = false;
  final List<String> errors = [];
  Timer? timer;
  // var Duration;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      addError(error: KConnectToInternet);
      if (mounted) {
        setState(() {
          load = false;
        });
      }
    });
  }

  void addError({String error=''}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error=''}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          load
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  strokeWidth: 3,
                ))
              : DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      startTimer();
                      setState(() {
                        load = true;
                      });
                      signIn(userNameContoller.text, passwordContoller.text);
                    }
                  },
                ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordContoller,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password *",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: userNameContoller,
      onSaved: (newValue) => user = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUserNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUserNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "User Name *",
        hintText: "Enter your User Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  signIn(String username, String password) async {
    Map jsonData;
    var data = jsonEncode({'userName': username, 'password': password});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post(
        Uri.parse("$apiUrl/api/account/authenticate"),
        headers: {'content-type': 'application/json'},
        body: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      sharedPreferences.setString("token", jsonData['token']['access_token']);
      sharedPreferences.setString("id",
          jsonData['user']['userSmallGroups'][0]['smallGroupID'].toString());
      sharedPreferences.setString(
          "name", jsonData['user']['firstName'].toString());
      Navigator.pushReplacementNamed(context, MembersPage.routeName,
          arguments: jsonData['user']['userSmallGroups'][0]['smallGroupID']
              .toString());
      remember = true;
    } else {
      setState(() {
        load = false;
      });
      addError(error: kInvaliduserpassError);
      removeError(error: KConnectToInternet);
      return "";
    }
  }
}
