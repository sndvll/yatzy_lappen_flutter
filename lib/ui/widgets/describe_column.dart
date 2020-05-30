import 'package:flutter/widgets.dart';

import '../utils/border_creator.dart';
import '../../constants.dart';
import 'cell.dart';

class TypeColumn extends StatelessWidget {
  List<Cell> _cells() {
    return AppConstants.CELL_NAMES.values
        .map((value) =>
            Cell.type(value: value, bottomBorder: getBottomBorder(value)))
        .toList();
  }

  BorderCreator getBottomBorder(String value) {
    switch (value) {
      case AppConstants.SIXES:
      case AppConstants.TOP_SUM:
      case AppConstants.BONUS:
      case AppConstants.YATZY:
        return BorderCreator.create(width: 1);
      case AppConstants.TOTAL:
        return BorderCreator.create(width: 2);
      default:
        return BorderCreator.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Cell.type(
          value: AppConstants.NAME,
          bottomBorder: BorderCreator.create(width: 1),
          topBorder: BorderCreator.create(width: 2),
        ),
        ..._cells()
      ],
    );
  }
}
