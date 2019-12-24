import 'package:flutter_in_practice/mine/container.dart';
import 'package:redux/redux.dart';

import 'redux.dart';

Future<Store<AppState>> createStore() async {

  var initialState = WgContainer().appState;

  // final config = WgContainer().config;

  final List<Middleware<AppState>> wms = [];

  return Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: wms,
  );
}
