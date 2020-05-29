import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yatzy_lappen/model/models.dart';
import 'package:yatzy_lappen/store/store.dart';

import 'widgets/widgets.dart';

class GamePage extends StatelessWidget {
  final String title;

  GamePage({this.title});

  List<PlayerColumn> _columns(List<Player> players) {
    return players.map((player) => PlayerColumn(player: player)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: [
            StoreConnector<GameState, ButtonProps>(
              converter: (store) => ButtonProps(
                  isDisabled: true, // TODO only allow when game is completed
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
                StoreConnector<GameState, List<Player>>(
                  converter: (store) => store.state.currentState,
                  builder: (context, players) {
                    print(players.toString());
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [TypeColumn(), ..._columns(players)],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StoreConnector<GameState, ButtonProps>(
                        converter: (store) => ButtonProps(
                            isDisabled: store.state.previousStates.length == 0,
                            onPressed: () => store.dispatch(UndoAction())),
                        builder: (context, props) => CircularButton(
                              icon: Icon(Icons.undo),
                              backgroundColor: Colors.redAccent,
                              onPressed:
                                  !props.isDisabled ? props.onPressed : null,
                            )),
                    CircularButton(
                      icon: Icon(Icons.people),
                      backgroundColor: Colors.black,
                      onPressed: () async => showDialog(
                          context: context,
                          builder: (BuildContext context) => AddPlayerDialog()),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
