import 'package:flutter/material.dart';
import 'package:zetseat_gu/Color.dart';

import '../constants.dart';

class CardHorizontalTextOnly extends StatelessWidget {
   CardHorizontalTextOnly(
      {this.title = "Placeholder Title",
        this.subTitle = "",
        this.cta = "",
        this.tap = defaultFunc});

  final String subTitle;
  final String cta;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 4,
            shadowColor: ZColors.muted.withOpacity(0.22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  color: ZColors.info, fontSize: 16,fontWeight: FontWeight.w100 )),
                          Text(subTitle,
                            style: const TextStyle(
                                color: ZColors.text, fontSize: 12),),
                          Text(cta,
                            style: kCtaText,),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
