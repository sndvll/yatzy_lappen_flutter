import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yatzy_lappen/constants.dart';

import '../../model/models.dart';
import '../utils/utils.dart';
import 'add_point_dialog.dart';
import 'cell.dart';

class PlayerColumn extends StatelessWidget {
  final Player player;

  PlayerColumn({@required this.player});

  String _snackBarText(PointValue value) =>
      '${player.name} ${AppConstants.SNACKBAR_GOT} ${value.value.toString()} ${AppConstants.SNACKBAR_POINTS_ON} ${AppConstants.CELL_NAMES[value.type].toLowerCase()}.';

  String _scratchedSnackbarText(PointValue value) =>
      '${player.name} ${AppConstants.SCRATCHED} ${AppConstants.CELL_NAMES[value.type].toLowerCase()}.';

  String get _yatzySnackBarText =>
      '${player.name.toUpperCase()} ${AppConstants.SNACKBAR_GOT.toUpperCase()} ${AppConstants.YATZY.toUpperCase()}!!';

  void _showSnackbar(BuildContext context, OnCloseEvent event) {
    if (event != null && event.value != null) {
      var text = event.value.scratched
          ? _scratchedSnackbarText(event.value)
          : _snackBarText(event.value);

      if (event.value.type == PointTypes.YATZY) {
        text = _yatzySnackBarText;
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
        content: Text(text),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          new Cell.name(
            value: player.name.length > 2
                ? player.name.substring(0, 2)
                : player.name,
            bottomBorder: BorderCreator.create(width: 1),
            rightBorder: BorderCreator.create(width: 2),
            topBorder: BorderCreator.create(width: 2),
          ),
          ..._cells(player.props, context)
        ],
      );

  List<Cell> _cells(List<PointValue> points, BuildContext context) =>
      PointTypes.values.map((type) {
        PointValue pointValue =
            points.firstWhere((point) => point.type == type);
        Color color = Colors.white;
        String value = pointValue.value == 0 ? '' : pointValue.value.toString();
        if (!pointValue.pristine) {
          color = Colors.lightGreen;
        }
        if (pointValue.scratched) {
          color = Colors.red;
          value = 'X';
        }

        return Cell(
          color: color,
          callback: (type) async => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      SetPointDialog(type, player))
              .then((event) => _showSnackbar(context, event)),
          type: type,
          value: value,
          bottomBorder: _getBottomBorder(type),
          clickable: _isClickable(type, pointValue),
        );
      }).toList();

  bool _isClickable(PointTypes type, PointValue value) {
    if (!value.pristine) {
      return false;
    }
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
