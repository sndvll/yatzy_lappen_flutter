export 'border_creator.dart';

import 'package:yatzy_lappen/model/points.dart';

class PointValueCreator {
  static List<PointValue> create() {
    return PointTypes.values.map((type) => PointValue(type: type)).toList();
  }
}
