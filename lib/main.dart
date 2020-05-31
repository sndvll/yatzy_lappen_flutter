import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:shortid/shortid.dart';

import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:yatzy_lappen/store/store.dart';
import 'package:yatzy_lappen/utils/logger.dart';

import 'constants.dart';
import 'ui/main_page.dart';

void main() async {
  var store = await init();
  logger.d('App initialized');
  runApp(App(
    store: store,
    title: AppConstants.TITLE,
  ));
}

class App extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  App({Key key, @required this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        home: GamePage(title: title),
      ));
}

Future<Store<AppState>> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.level = Level.nothing;

  final persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>(AppState.fromJson));

  final state = await persistor.load();

  return Store<AppState>(
    reducers,
    middleware: [persistor.createMiddleware()],
    initialState: state ?? AppState(shortid.generate()),
  );
}
