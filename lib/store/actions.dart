import 'package:yatzy_lappen/model/model.dart';

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
