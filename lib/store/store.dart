import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:shortid/shortid.dart';

import '../model/models.dart';

@immutable
abstract class GameState {
  final List<Player> currentState = [];
  final List<List<Player>> previousStates = [];

  bool get completed;
  bool get started;
}

class InitialState implements GameState {
  final List<Player> currentState = [];
  final List<List<Player>> previousStates = [];
  bool get completed => false;
  bool get started => false;
}

class UpdatedState implements GameState {
  final List<Player> currentState;
  final List<List<Player>> previousStates;

  bool get completed =>
      currentState.length > 0 &&
      currentState.every((player) => player.completed);
  bool get started =>
      currentState.length > 0 && currentState.any((player) => player.started);

  UpdatedState(this.currentState, this.previousStates) {
    print(this.currentState.toString());
  }
}

class AddPlayerAction {
  final String name;
  AddPlayerAction(this.name);
}

class EditPointAction {
  final PointValue value;
  final Player player;
  EditPointAction(this.value, this.player);
}

class UndoAction {}

class NewGameAction {}

final reducers = combineReducers<GameState>([
  TypedReducer<GameState, AddPlayerAction>(_onAddPlayer),
  TypedReducer<GameState, EditPointAction>(_onEditPoint),
  TypedReducer<GameState, UndoAction>(_onUndo),
  TypedReducer<GameState, NewGameAction>((state, action) => InitialState())
]);

GameState _onUndo(GameState state, UndoAction action) =>
    state.previousStates.length > 0
        ? UpdatedState(state.previousStates.removeLast(), state.previousStates)
        : state;

GameState _onAddPlayer(GameState state, AddPlayerAction action) {
  if (action.name.length == 0) {
    return state;
  }

  List<List<Player>> previousStates = [
    ...state.previousStates,
    state.currentState
  ];

  List<Player> players = [...state.currentState];
  List<String> names = [];

  if (action.name.contains(',')) {
    names = action.name.split(',');
  } else {
    names.add(action.name);
  }

  names.forEach((name) {
    players.add(Player(name: name.trim(), id: shortid.generate()));
  });

  return UpdatedState(players, previousStates);
}

GameState _onEditPoint(GameState state, EditPointAction action) {
  List<List<Player>> previousStates = [
    ...state.previousStates,
    state.currentState
  ];
  List<Player> newState = [...state.currentState];
  Player newPlayer = _updatedPlayer(action.player, action.value);
  newState[_getPlayerIndex(state.currentState, action.player)] = newPlayer;

  return UpdatedState(newState, previousStates);
}

int _getPlayerIndex(List<Player> players, Player player) =>
    players.indexWhere((element) => element.id == player.id);

Player _updatedPlayer(Player player, PointValue value) => {
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
