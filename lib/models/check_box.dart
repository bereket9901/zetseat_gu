// import 'dart:ffi';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CheckBox extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback? press;
  final Icon? icon;
  final void Function(bool?) onChanged;
  final int? id;
  final bool? isChecked;
  final bool? checked;

  CheckBox({
    Key? key,
    this.title="",
    required this.onChanged,
    this.subtitle="",
    this.icon,
    this.id,
    this.press,
    this.isChecked,
    this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return InkWell(
      onTap: press,
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: defaultSize * 1.8,
            color: kTextLigntColor,
          ),
        ),
        subtitle: subtitle == null ? Text(" ") : Text(subtitle),
        secondary: icon,
        controlAffinity: ListTileControlAffinity.trailing,
        value: checked,
        onChanged: onChanged,
        activeColor: Colors.orangeAccent,
        checkColor: Colors.green,
      ),
    );
  }
}
