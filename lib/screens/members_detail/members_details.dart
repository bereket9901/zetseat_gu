import 'package:flutter/material.dart';
import 'package:zetseat_membership/Color.dart';
import '../../constants.dart';
import 'components/body.dart';

class MembersDetailsPage extends StatelessWidget {
  const MembersDetailsPage({super.key, required this.id});
  final int id;
  static String routeName = "/members_details";
  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar() {
      return AppBar(
        backgroundColor: kPrimaryColor,
        leading: TextButton(onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_outlined, color: ZColors.black,)

        ),
        centerTitle: true,
        title: const Text(
          "Members Details",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),

      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body:Body(id: id,),
    );
  }
}
