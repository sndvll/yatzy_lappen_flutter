import 'package:flutter/material.dart';

class BorderCreator extends BorderSide {
  final Color color = Colors.black;
  final double width;

  const BorderCreator.create({this.width = 0});
}
