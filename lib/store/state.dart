import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shortid/shortid.dart';
import 'package:yatzy_lappen/model/model.dart';
import 'package:yatzy_lappen/utils/logger.dart';

class NoHistoryException implements Exception {}

@immutable
class AppState {
  final String id;
  final List<Player> players;
  final bool loadedFromPersistence;

  static final Map<String, AppState> _previousStates = Map<String, AppState>();
  static AppState remove(String id) => _previousStates.remove(id);

  AppState._internal(this.id, this.players,
      {this.loadedFromPersistence = false});

  factory AppState(String id,
      {List<Player> players = const [], bool loadedFromPersistence = false}) {
    if (_previousStates.containsKey(id)) {
      return _previousStates[id].copyWith();
    }
    final AppState state = AppState._internal(id, players,
        loadedFromPersistence: loadedFromPersistence);
    _previousStates[id] = state;
    logger.d('State generated $id');
    return state;
  }

  AppState copyWith({List<Player> players}) => AppState(shortid.generate(),
      players: players ?? this.players, loadedFromPersistence: false);

  bool get completed =>
      players.length > 0 && players.every((player) => player.completed);
  bool get started =>
      players.length > 0 && players.any((player) => player.started);
  bool get canUndo =>
      !loadedFromPersistence &&
      players.length > 0 &&
      _previousStates.keys.length > 1;
  bool get canRestart => loadedFromPersistence || completed;

  static bool get hasPreviousStates => _previousStates.length > 1;
  static AppState getPreviousState({int index = 0}) =>
      _previousStates.values.toList()[_previousStates.length + index];

  static AppState fromJson(dynamic state) {
    if (state != null) {
      try {
        Iterable decoded = json.decode(state['players']);
        if (decoded.length > 0) {
          var players =
              decoded.map((element) => Player.fromJson(element)).toList();
          logger.d('Persisted state serialized');
          return AppState(state['id'],
              players: players, loadedFromPersistence: true);
        }
      } catch (error, stackTrace) {
        logger.e('Could not init persisted state.', [error, stackTrace]);
      }
    }
    logger.d('Initializing an empty state');
    return AppState(shortid.generate());
  }

  dynamic toJson() => {
        'id': id,
        'players': players.map((player) => player.toJson).toList().toString()
      };

  @override
  String toString() {
    return 'id: $id';
  }
}
