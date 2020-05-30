import 'package:redux/redux.dart';
import 'package:shortid/shortid.dart';
import 'package:yatzy_lappen/model/model.dart';

import 'actions.dart';
import 'state.dart';
import '_utils.dart';

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

  UpdatedState updatedState =
      createUpdatedState(state.currentState, state.previousStates);

  getNames(action.name).forEach((name) {
    updatedState.currentState
        .add(Player(name: name.trim(), id: shortid.generate()));
  });

  return updatedState;
}

GameState _onEditPoint(GameState state, EditPointAction action) {
  UpdatedState updatedState =
      createUpdatedState(state.currentState, state.previousStates);

  updatedState.currentState[getPlayerIndex(state.currentState, action.player)] =
      updatedPlayer(action.player, action.value);

  return updatedState;
}
