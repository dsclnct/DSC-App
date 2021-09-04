import 'package:flutter/material.dart';

const klightGreen = Color(0xff5ED5A8);
const kintroBackgroundColor = Color(0xff1B232A);

var kcoloredLine = Container(
  child: Row(
    children: [
      Expanded(
          child: Container(
        color: Colors.red,
        height: 2,
      )),
      Expanded(
          child: Container(
        color: Colors.blue,
        height: 2,
      )),
      Expanded(
          child: Container(
        color: Colors.green,
        height: 2,
      )),
      Expanded(
          child: Container(
        color: Colors.yellow[700],
        height: 2,
      )),
    ],
  ),
);
var kthickColoredLine = Container(
  child: Row(
    children: [
      Expanded(
          child: Container(
        color: Colors.red,
        height: 5,
      )),
      Expanded(
          child: Container(
        color: Colors.blue,
        height: 5,
      )),
      Expanded(
          child: Container(
        color: Colors.green,
        height: 5,
      )),
      Expanded(
          child: Container(
        color: Colors.yellow[700],
        height: 5,
      )),
    ],
  ),
);
