import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class TextFormFieldStyle {
  static TextStyle inputFieldTextStyle() {
    return TextStyle(
      fontFamily: AppFonts.quicksandBold,
      fontSize: 14,
      color: Colors.black,
    );
  }

  static InputDecoration inputDecoration(String labelTxt) {
    return InputDecoration(
      labelText: labelTxt,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: AppFonts.quicksandRegular,
      ),
      border: OutlineInputBorder(),
    );
  }
}
