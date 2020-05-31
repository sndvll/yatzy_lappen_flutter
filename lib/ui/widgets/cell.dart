import 'package:flutter/material.dart';
import 'package:yatzy_lappen/model/model.dart';

import '../utils/border_creator.dart';

typedef void OnCellClick(PointTypes type);

class Cell extends StatelessWidget {
  final String value;
  final bool clickable;
  final BorderSide topBorder;
  final BorderSide bottomBorder;
  final BorderSide leftBorder;
  final BorderSide rightBorder;
  final OnCellClick callback;
  final PointTypes type;
  final double width;
  final Color color;

  Cell(
      {@required this.value,
      @required this.callback,
      @required this.type,
      @required this.clickable,
      this.width = 50,
      this.color = Colors.white,
      this.topBorder = const BorderCreator.create(width: 1),
      this.bottomBorder = const BorderCreator.create(),
      this.leftBorder = const BorderCreator.create(),
      this.rightBorder = const BorderCreator.create(width: 2)});

  Cell.type(
      {@required this.value,
      this.width = 90,
      this.callback,
      this.type,
      this.clickable = false,
      this.color = Colors.white,
      this.topBorder = const BorderCreator.create(width: 1),
      this.bottomBorder = const BorderCreator.create(),
      this.leftBorder = const BorderCreator.create(width: 2),
      this.rightBorder = const BorderCreator.create(width: 2)});

  Cell.name(
      {@required this.value,
      this.width = 50,
      this.callback,
      this.type,
      this.clickable = false,
      this.color = Colors.white,
      this.topBorder,
      this.bottomBorder,
      this.leftBorder = const BorderCreator.create(),
      this.rightBorder});

  @override
  Widget build(BuildContext context) => Material(
      child: Ink(
          width: width,
          height: 30,
          decoration: BoxDecoration(
              color: color,
              border: Border(
                  top: topBorder,
                  right: rightBorder,
                  bottom: bottomBorder,
                  left: leftBorder)),
          child: InkWell(
            onTap: clickable ? () => callback(type) : null,
            child: Center(child: Text(value)),
          )));
}
