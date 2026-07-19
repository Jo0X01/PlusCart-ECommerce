import 'package:flutter/material.dart';

abstract class AppDialogs {
  static showSnackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: Duration(seconds: 6)),
    );
  }
}
