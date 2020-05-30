import 'package:yatzy_lappen/model/model.dart';

import 'state.dart';

GameState createUpdatedState(
        List<Player> currentState, List<List<Player>> previousStates) =>
    UpdatedState([...currentState], [...previousStates, currentState]);

List<String> getNames(String name) =>
    name.contains(',') ? name.split(',') : [name];

int getPlayerIndex(List<Player> players, Player player) =>
    players.indexWhere((element) => element.id == player.id);

Player updatedPlayer(Player player, PointValue value) => {
      PointTypes.ONES: player.copyWith(ones: value),
      PointTypes.TWOS: player.copyWith(twos: value),
      PointTypes.THREES: player.copyWith(threes: value),
      PointTypes.FOURS: player.copyWith(fours: value),
      PointTypes.FIVES: player.copyWith(fives: value),
      PointTypes.SIXES: player.copyWith(sixes: value),
      PointTypes.PAIR: player.copyWith(pair: value),
      PointTypes.TWO_PAIRS: player.copyWith(twoPairs: value),
      PointTypes.TRIPS: player.copyWith(trips: value),
      PointTypes.FOUR_OF_A_KIND: player.copyWith(fourOfAKind: value),
      PointTypes.FULL_HOUSE: player.copyWith(fullHouse: value),
      PointTypes.SMALL_STRAIGHT: player.copyWith(smallStraight: value),
      PointTypes.LARGE_STRAIGHT: player.copyWith(largeStraight: value),
      PointTypes.CHANCE: player.copyWith(chance: value),
      PointTypes.YATZY: player.copyWith(yatzy: value)
    }[value.type];
