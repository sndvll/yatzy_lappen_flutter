import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/models.dart';
import '../utils/utils.dart';
import 'add_point_dialog.dart';

import 'cell.dart';

class PlayerColumn extends StatelessWidget {
  final Player player;

  PlayerColumn({@required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Cell.name(
          value: player.name.substring(0, 2),
          bottomBorder: BorderCreator.create(width: 1),
          rightBorder: BorderCreator.create(width: 2),
          topBorder: BorderCreator.create(width: 2),
        ),
        ..._cells(player.props, context)
      ],
    );
  }

  List<Cell> _cells(List<PointValue> points, BuildContext context) {
    return PointTypes.values.map((type) {
      PointValue pointValue = points.firstWhere((point) => point.type == type);
      Color color = Colors.white;
      if (!pointValue.pristine) {
        color = Colors.green;
      }
      if (pointValue.scratched) {
        color = Colors.red;
      }

      return Cell(
        color: color,
        callback: (type) async => showDialog(
            context: context,
            builder: (BuildContext context) => AddPointDialog(type, player)),
        type: type,
        value: pointValue.value.toString(),
        bottomBorder: _getBottomBorder(type),
        clickable: !pointValue.scratched ? _isClickable(type) : false,
      );
    }).toList();
  }

  bool _isClickable(PointTypes type) {
    switch (type) {
      case PointTypes.TOP_SUM:
      case PointTypes.BONUS:
      case PointTypes.TOTAL:
        return false;
      default:
        return true;
    }
  }

  BorderCreator _getBottomBorder(PointTypes type) {
    switch (type) {
      case PointTypes.SIXES:
      case PointTypes.TOP_SUM:
      case PointTypes.BONUS:
      case PointTypes.YATZY:
        return BorderCreator.create(width: 1);
      case PointTypes.TOTAL:
        return BorderCreator.create(width: 2);
      default:
        return BorderCreator.create();
    }
  }
}
