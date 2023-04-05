import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, this.text="", this.press, this.textsize=10})
      : super(key: key);
  final String text;
  final VoidCallback? press;
  final double textsize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //     side: BorderSide(
        //         color: press == null ? Colors.black : Colors.transparent)),
        // color: kPrimaryColor,
        style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryColor)),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textsize == null
                ? getProportionateScreenWidth(18)
                : getProportionateScreenWidth(textsize),
            color: press == null ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
