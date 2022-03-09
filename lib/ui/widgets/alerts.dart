import 'package:flutter/material.dart';

void showInfoMessage(String message, BuildContext context, {int duration = 3}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ),
  );
}
