import 'package:redux/redux.dart';
import 'package:shortid/shortid.dart';
import 'package:yatzy_lappen/model/model.dart';
import 'package:yatzy_lappen/utils/logger.dart';

import 'actions.dart';
import 'state.dart';
import '_utils.dart';

final reducers = combineReducers<AppState>([
  TypedReducer<AppState, AddPlayerAction>(_onAddPlayer),
  TypedReducer<AppState, EditPointAction>(_onEditPoint),
  TypedReducer<AppState, UndoAction>(_onUndo),
  TypedReducer<AppState, NewGameAction>(
      (state, action) => AppState(shortid.generate(), players: []))
]);

AppState _onUndo(AppState state, UndoAction action) {
  logger.d('Undo state id ${state.id}');
  if (AppState.hasPreviousStates) {
    AppState.remove(state.id);
    return AppState.getPreviousState(index: -1);
  }
  return AppState.getPreviousState();
}

AppState _onAddPlayer(AppState state, AddPlayerAction action) {
  if (action.name.length == 0) {
    return state;
  }

  var players = [...state.players];
  getNames(action.name).forEach((name) {
    players.add(Player(name: name.trim(), id: shortid.generate()));
  });
  logger.d('Players ${action.name.toString()} added to game');
  return state.copyWith(players: [...players]);
}

AppState _onEditPoint(AppState state, EditPointAction action) {
  var players = [...state.players];
  players[getPlayerIndex(state.players, action.player)] =
      updatedPlayer(action.player, action.value);

  logger.d(
      'Player ${action.player.name.toString()} got ${action.value.value} on ${action.value.type}');
  return state.copyWith(players: players);
}
