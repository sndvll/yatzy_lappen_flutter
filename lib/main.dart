import 'package:flutter/material.dart';
import 'package:yatzy_lappen/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yatzy_lappen/ui/ui.dart';

import 'constants.dart';

void main() {
  runApp(App(
    store: Store<GameState>(reducers, initialState: InitialState()),
    title: AppConstants.TITLE,
  ));
}

class App extends StatelessWidget {
  final Store<GameState> store;
  final String title;

  App({Key key, @required this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GameState>(
        store: store,
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          home: GamePage(title: title),
        ));
  }
}
