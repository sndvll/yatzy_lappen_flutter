import 'package:redux/redux.dart';
import 'package:shortid/shortid.dart';
import 'package:yatzy_lappen/model/models.dart';

abstract class GameState {
  List<Player> currentState;
  List<List<Player>> previousStates;
}

class InitialState implements GameState {
  List<Player> currentState = [];
  List<List<Player>> previousStates = [];
}

class UpdatedState implements GameState {
  List<Player> currentState;
  List<List<Player>> previousStates;
  UpdatedState(this.currentState, this.previousStates);
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
    state.previousStates.length > 1
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
  newState[_getPlayerIndex(state.currentState, action.player)] =
      _updatedPlayer(action.player, action.value);

  return UpdatedState(newState, previousStates);
}

int _getPlayerIndex(List<Player> players, Player player) =>
    players.indexOf(player);

Player _updatedPlayer(Player player, PointValue value) {
  switch (value.type) {
    case PointTypes.ONES:
      return player.copyWith(ones: value);
    case PointTypes.TWOS:
      return player.copyWith(twos: value);
    case PointTypes.THREES:
      return player.copyWith(threes: value);
    case PointTypes.FOURS:
      return player.copyWith(fours: value);
    case PointTypes.FIVES:
      return player.copyWith(fives: value);
    case PointTypes.SIXES:
      return player.copyWith(sixes: value);
    case PointTypes.PAIR:
      return player.copyWith(pair: value);
    case PointTypes.TWO_PAIRS:
      return player.copyWith(twoPairs: value);
    case PointTypes.TRIPS:
      return player.copyWith(trips: value);
    case PointTypes.FOUR_OF_A_KIND:
      return player.copyWith(fourOfAKind: value);
    case PointTypes.FULL_HOUSE:
      return player.copyWith(fullHouse: value);
    case PointTypes.SMALL_STRAIGHT:
      return player.copyWith(smallStraight: value);
    case PointTypes.LARGE_STRAIGHT:
      return player.copyWith(largeStraight: value);
    case PointTypes.CHANCE:
      return player.copyWith(chance: value);
    case PointTypes.YATZY:
      return player.copyWith(yatzy: value);
    default:
      return player.copyWith();
  }
}
