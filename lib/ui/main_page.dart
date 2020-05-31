import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yatzy_lappen/model/model.dart';
import 'package:yatzy_lappen/store/store.dart';

import 'widgets/widgets.dart';

class GamePage extends StatelessWidget {
  final String title;

  GamePage({this.title});

  List<PlayerColumn> _columns(List<Player> players) =>
      players.map((player) => PlayerColumn(player: player)).toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: [
            StoreConnector<AppState, ButtonProps>(
              converter: (store) => ButtonProps(
                  isDisabled: !store.state.canRestart,
                  onPressed: () => store.dispatch(NewGameAction())),
              builder: (context, props) => IconButton(
                  onPressed: !props.isDisabled ? props.onPressed : null,
                  icon: Icon(Icons.fiber_new)),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StoreConnector<AppState, List<Player>>(
                  converter: (store) => store.state.players,
                  builder: (context, players) => SingleChildScrollView(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [TypeColumn(), ..._columns(players)],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StoreConnector<AppState, ButtonProps>(
                        converter: (store) => ButtonProps(
                            isDisabled:
                                store.state.completed || !store.state.canUndo,
                            onPressed: () => store.dispatch(UndoAction())),
                        builder: (context, props) => CircularButton.icon(
                              icon: Icons.undo,
                              backgroundColor: Colors.redAccent,
                              disabledColor: Colors.black38,
                              onPressed:
                                  !props.isDisabled ? props.onPressed : null,
                            )),
                    StoreConnector<AppState, ButtonProps>(
                        converter: (store) => ButtonProps(
                            isDisabled: store.state.started,
                            onPressed: () async => showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AddPlayerDialog())),
                        builder: (context, props) => CircularButton.icon(
                            icon: Icons.people,
                            backgroundColor: Colors.black,
                            onPressed:
                                !props.isDisabled ? props.onPressed : null))
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
