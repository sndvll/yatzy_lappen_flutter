import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum PointTypes {
  ONES,
  TWOS,
  THREES,
  FOURS,
  FIVES,
  SIXES,
  TOP_SUM,
  BONUS,
  PAIR,
  TWO_PAIRS,
  TRIPS,
  FOUR_OF_A_KIND,
  FULL_HOUSE,
  SMALL_STRAIGHT,
  LARGE_STRAIGHT,
  CHANCE,
  YATZY,
  TOTAL
}

@immutable
class PointValue extends Equatable {
  final PointTypes type;
  final int value;
  final bool pristine;
  final bool scratched;

  const PointValue(
      {@required this.type,
      this.value = 0,
      this.pristine = true,
      this.scratched = false});

  const PointValue.scratch(
      {@required this.type,
      this.value = 0,
      this.pristine = false,
      this.scratched = true});

  const PointValue.setPoint(
      {@required this.type,
      @required this.value,
      this.scratched = false,
      this.pristine = false});

  @override
  String toString() {
    return '{type: $type, value: $value, pristine: $pristine, scratched: $scratched}';
  }

  @override
  List<Object> get props => [type, value, pristine, scratched];
}
