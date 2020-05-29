import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
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

  PointValue get topSum {
    int sum = [
      this.ones,
      this.twos,
      this.threes,
      this.fours,
      this.fives,
      this.sixes
    ].fold(0, (acc, pointValue) => acc + pointValue.value);
    return PointValue(type: PointTypes.TOP_SUM, value: sum);
  }

  PointValue get bonus {
    return PointValue(
        type: PointTypes.BONUS, value: topSum.value > 62 ? 50 : 0);
  }

  PointValue get total {
    int sum = [
      this.ones,
      this.twos,
      this.threes,
      this.fours,
      this.fives,
      this.sixes,
      this.bonus,
      this.topSum,
      this.pair,
      this.twoPairs,
      this.trips,
      this.fourOfAKind,
      this.fullHouse,
      this.smallStraight,
      this.largeStraight,
      this.chance,
      this.yatzy
    ].fold(0, (acc, pointValue) => acc + pointValue.value);
    return PointValue(type: PointTypes.TOTAL, value: sum);
  }

  bool get completed {
    // todo implement this check.
    return false;
  }

  List<PointValue> get props {
    return <PointValue>[
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
  }

  @override
  String toString() {
    return '{ name: $name, id: $id, points: $props}';
  }
}
