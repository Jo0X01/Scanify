import 'package:flutter/material.dart';

abstract class AppDialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 60, left: 25, right: 25),
        duration: Duration(seconds: 2),
        content: Text(msg, maxLines: 20,softWrap: true, overflow: TextOverflow.visible,),
      ),
    );
  }
}
