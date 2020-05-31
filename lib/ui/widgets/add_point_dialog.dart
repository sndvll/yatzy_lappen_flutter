import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yatzy_lappen/model/model.dart';
import 'package:yatzy_lappen/store/store.dart';

import '../../constants.dart';
import 'buttons.dart';

typedef void DispatchPointCallback(int number);

@immutable
class OnCloseEvent {
  final String name;
  final PointValue value;

  OnCloseEvent(this.name, this.value);
}

class SetPointDialog extends StatelessWidget {
  final PointTypes type;
  final Player player;

  SetPointDialog(this.type, this.player);

  List<int> get _selections => AppConstants.POSSIBLE_POINTS[type];

  void _close(BuildContext context, {PointValue value}) {
    Navigator.of(context).pop(OnCloseEvent(player.name, value));
  }

  Widget getPointSelections(DispatchPointCallback callback) {
    switch (type) {
      case PointTypes.YATZY:
        return Center(
            child: FlatButton(
                color: Colors.cyan,
                onPressed: () =>
                    callback(AppConstants.POSSIBLE_POINTS[PointTypes.YATZY][0]),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellowAccent),
                    Text(AppConstants.YATZY.toUpperCase() + '!!',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    Icon(Icons.star, color: Colors.yellowAccent)
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )));
      case PointTypes.SMALL_STRAIGHT:
      case PointTypes.LARGE_STRAIGHT:
        return Center(
            child: FlatButton(
                color: Colors.cyan,
                onPressed: () =>
                    callback(AppConstants.POSSIBLE_POINTS[type][0]),
                child: Row(
                  children: [
                    Text(AppConstants.CELL_NAMES[type],
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )));
      default:
        return Center(
            child: Container(
          height: 200,
          width: 300,
          child: Scrollbar(
              child: GridView.builder(
            itemCount: _selections.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20, mainAxisSpacing: 8, crossAxisCount: 4),
            itemBuilder: (context, index) => CircularButton.text(
              backgroundColor: Colors.lightGreen,
              onPressed: () => callback(_selections[index]),
              text: _selections[index].toString(),
            ),
          )),
        ));
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(AppConstants.CELL_NAMES[type],
            style: TextStyle(color: Colors.blue)),
        Text(player.name, style: TextStyle(color: Colors.green))
      ]),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        StoreConnector<AppState, DispatchPointCallback>(
          converter: (store) {
            return (int value) {
              var v = PointValue.setPoint(type: type, value: value);
              _close(context, value: v);
              store.dispatch(EditPointAction(v, player));
            };
          },
          builder: (context, callback) => getPointSelections(callback),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularButton.icon(
                    icon: Icons.exit_to_app,
                    backgroundColor: Colors.black38,
                    onPressed: () => _close(context)),
                StoreConnector<AppState, ButtonClickCallback>(
                  converter: (store) {
                    return () {
                      var v = PointValue.scratch(type: type);
                      store.dispatch(EditPointAction(v, player));
                      _close(context, value: v);
                    };
                  },
                  builder: (context, callback) => CircularButton.icon(
                      icon: Icons.clear,
                      backgroundColor: Colors.redAccent,
                      onPressed: callback),
                )
              ],
            ))
      ]));
}
