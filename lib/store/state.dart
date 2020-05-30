import 'package:meta/meta.dart';
import 'package:yatzy_lappen/model/model.dart';

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
