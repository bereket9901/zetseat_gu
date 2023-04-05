import 'package:flutter/material.dart';
import 'package:zetseat_membership/Color.dart';
import '../constants.dart';

class CardDetail extends StatelessWidget {
  CardDetail(
      { this.title = "Placeholder Title",
        this.subTitle = "",
        this.subTitle1 = "",
        this.subTitle2 = "",
        this.subTitle3 = "",
        this.subTitle4 = "",
        this.cta = "",
        this.tap = defaultFunc});

  final String subTitle;
  final String subTitle1;
  final String subTitle2;
  final String subTitle3;
  final String subTitle4;
  final String cta;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: ZColors.muted.withOpacity(0.22),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(
                  title,
                  style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                     Text(
                      subTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(""),
                  ],
                ),
                Column(
                  children: [
                     Text(
                      subTitle1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                     ""
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                     Text(
                      subTitle2,
                    ),
                    const SizedBox(height: 10),
                    Text(""),
                  ],
                ),
                Column(
                  children: [
                     Text(
                      'Have been Baptized?',
                    ),
                    const SizedBox(height: 10),
                    Text(""),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                     Text(
                      subTitle3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "",
                    ),
                  ],
                ),
                Column(
                  children: [
                     Text(
                      subTitle4,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
