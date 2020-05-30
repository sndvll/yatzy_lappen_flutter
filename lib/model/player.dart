import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'points.dart';

@immutable
class Player extends Equatable {
  final String name;
  final String id;
  final PointValue ones;
  final PointValue twos;
  final PointValue threes;
  final PointValue fours;
  final PointValue fives;
  final PointValue sixes;
  final PointValue pair;
  final PointValue twoPairs;
  final PointValue trips;
  final PointValue fourOfAKind;
  final PointValue fullHouse;
  final PointValue smallStraight;
  final PointValue largeStraight;
  final PointValue chance;
  final PointValue yatzy;

  Player(
      {this.ones = const PointValue(type: PointTypes.ONES),
      this.twos = const PointValue(type: PointTypes.TWOS),
      this.threes = const PointValue(type: PointTypes.THREES),
      this.fours = const PointValue(type: PointTypes.FOURS),
      this.fives = const PointValue(type: PointTypes.FIVES),
      this.sixes = const PointValue(type: PointTypes.SIXES),
      this.pair = const PointValue(type: PointTypes.PAIR),
      this.twoPairs = const PointValue(type: PointTypes.TWO_PAIRS),
      this.trips = const PointValue(type: PointTypes.TRIPS),
      this.fourOfAKind = const PointValue(type: PointTypes.FOUR_OF_A_KIND),
      this.fullHouse = const PointValue(type: PointTypes.FULL_HOUSE),
      this.smallStraight = const PointValue(type: PointTypes.SMALL_STRAIGHT),
      this.largeStraight = const PointValue(type: PointTypes.LARGE_STRAIGHT),
      this.chance = const PointValue(type: PointTypes.CHANCE),
      this.yatzy = const PointValue(type: PointTypes.YATZY),
      @required this.name,
      @required this.id});

  Player copyWith(
      {PointValue ones,
      PointValue twos,
      PointValue threes,
      PointValue fours,
      PointValue fives,
      PointValue sixes,
      PointValue pair,
      PointValue twoPairs,
      PointValue trips,
      PointValue fourOfAKind,
      PointValue fullHouse,
      PointValue smallStraight,
      PointValue largeStraight,
      PointValue chance,
      PointValue yatzy}) {
    return Player(
        name: this.name,
        id: this.id,
        ones: ones ?? this.ones,
        twos: twos ?? this.twos,
        threes: threes ?? this.threes,
        fours: fours ?? this.fours,
        fives: fives ?? this.fives,
        sixes: sixes ?? this.sixes,
        pair: pair ?? this.pair,
        twoPairs: twoPairs ?? this.twoPairs,
        trips: trips ?? this.trips,
        fourOfAKind: fourOfAKind ?? this.fourOfAKind,
        fullHouse: fullHouse ?? this.fullHouse,
        smallStraight: smallStraight ?? this.smallStraight,
        largeStraight: largeStraight ?? this.largeStraight,
        chance: chance ?? this.chance,
        yatzy: yatzy ?? this.yatzy);
  }

  PointValue get topSum => [
        this.ones,
        this.twos,
        this.threes,
        this.fours,
        this.fives,
        this.sixes
      ].reduce((acc, current) => PointValue(
          type: PointTypes.TOP_SUM, value: acc.value + current.value));

  PointValue get bonus {
    bool hasBonus = topSum.value > 62;
    return PointValue(
        type: PointTypes.BONUS, value: hasBonus ? 50 : 0, pristine: !hasBonus);
  }

  PointValue get total =>
      [this.topSum, ..._bottomValues].reduce((acc, current) =>
          PointValue(type: PointTypes.TOTAL, value: acc.value + current.value));

  bool get completed => [
        this.ones,
        this.twos,
        this.threes,
        this.fours,
        this.fives,
        this.sixes,
        this.pair,
        this.twoPairs,
        this.trips,
        this.fourOfAKind,
        this.fullHouse,
        this.smallStraight,
        this.largeStraight,
        this.chance,
        this.yatzy
      ].every((pointValue) => !pointValue.pristine);

  bool get started => values.any((pointValue) => !pointValue.pristine);

  List<PointValue> get _bottomValues => values.sublist(8, 16);

  List<PointValue> get values => [
        this.ones,
        this.twos,
        this.threes,
        this.fours,
        this.fives,
        this.sixes,
        this.bonus,
        this.pair,
        this.twoPairs,
        this.trips,
        this.fourOfAKind,
        this.fullHouse,
        this.smallStraight,
        this.largeStraight,
        this.chance,
        this.yatzy
      ];

  List<PointValue> get props => <PointValue>[
        ones,
        twos,
        threes,
        fours,
        fives,
        sixes,
        topSum,
        bonus,
        pair,
        twoPairs,
        trips,
        fourOfAKind,
        fullHouse,
        smallStraight,
        largeStraight,
        chance,
        yatzy,
        total
      ];

  @override
  String toString() => '{ name: $name, id: $id, points: $props}';
}
