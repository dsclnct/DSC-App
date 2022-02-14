import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff515151),
      textColor: Colors.white,
      fontSize: 16.0);
}
