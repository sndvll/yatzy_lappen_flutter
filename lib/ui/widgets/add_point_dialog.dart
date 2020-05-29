import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yatzy_lappen/model/models.dart';
import 'package:yatzy_lappen/store/store.dart';

import '../../constants.dart';
import 'buttons.dart';

class AddPointDialog extends StatelessWidget {
  final PointTypes type;
  final Player player;

  AddPointDialog(this.type, this.player);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
          child: ListBody(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(AppConstants.CELL_NAMES[type],
                style: TextStyle(color: Colors.blue)),
            Text(player.name, style: TextStyle(color: Colors.green)),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: AppConstants.POSSIBLE_POINTS[type]
                  .map((value) => Text(value.toString()))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StoreConnector<GameState, ButtonClickCallback>(
                  converter: (store) {
                    return () {
                      Navigator.of(context).pop();
                      store.dispatch(EditPointAction(
                          PointValue.scratch(type: type), player));
                    };
                  },
                  builder: (context, callback) => CircularButton(
                      icon: Icon(Icons.clear),
                      backgroundColor: Colors.redAccent,
                      onPressed: callback),
                ),
                CircularButton(
                    icon: Icon(Icons.done),
                    backgroundColor: Colors.green,
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          )
        ],
      )),
    );
  }
}
