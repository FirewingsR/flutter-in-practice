import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';

import 'adapter/adapter.dart';
import 'ui/ui.dart';
import 'config.dart';

class WgContainer {
  static WgContainer _instance;

  final _injector = Injector();

  WgConfig _config;
  Future<void> onReady;

  factory WgContainer([WgConfig config]) {
    if (_instance == null) {
      _instance = WgContainer._(config);
    }
    return _instance;
  }

  WgContainer._(WgConfig config) {
    _config = config;

    onReady = Future(() async {
      _config.packageInfo = await PackageInfo.fromPlatform();
      _config.appDocDir = await getApplicationDocumentsDirectory();

      print(_config);

      registerLoggers();
      registerTheme();
      registerNavigatorKeys();
      registerAppState();

      await registerAppStore();

      registerServices();
      registerUsecases();
      registerPresenters();
    });
  }

  Store<AppState> get appStore {
    return _injector.getDependency<Store<AppState>>();
  }

  WgConfig get config {
    return _config;
  }

  WgTheme get theme {
    return _injector.getDependency<WgTheme>();
  }

  BasePresenter get basePresenter {
    return _injector.getDependency<BasePresenter>();
  }

  void registerLoggers() {
    Logger.root.level = config.loggerLevel;
    Logger.root.onRecord.listen((record) {
      final label = record.loggerName.padRight(3).substring(0, 3).toUpperCase();
      final time = record.time.toIso8601String().substring(0, 23);
      final level = record.level.toString().padRight(4);
      print('$label $time $level ${record.message}');
    });

    _injector.registerSingleton<Logger>((injector) {
      return Logger('app');
    }, dependencyName: 'app');

    _injector.registerSingleton<Logger>((injector) {
      return Logger('action');
    }, dependencyName: 'action');

    _injector.registerSingleton<Logger>((injector) {
      return Logger('api');
    }, dependencyName: 'api');
  }

  Logger get appLogger {
    return _injector.getDependency<Logger>(dependencyName: 'app');
  }

  Logger get actionLogger {
    return _injector.getDependency<Logger>(dependencyName: 'action');
  }

  Logger get apiLogger {
    return _injector.getDependency<Logger>(dependencyName: 'api');
  }

  void registerTheme() {
    _injector.registerSingleton<WgTheme>((injector) {
      return WgTheme();
    });
  }

  void registerNavigatorKeys() {
    _injector.registerSingleton<GlobalKey<NavigatorState>>((injector) {
      return GlobalKey<NavigatorState>();
    }, dependencyName: 'root');
  }

  GlobalKey<NavigatorState> get rootNavigatorKey {
    return _injector.getDependency<GlobalKey<NavigatorState>>(
        dependencyName: 'root');
  }

  void registerAppState() {
    _injector.registerDependency<AppState>((injector) {
      return AppState(version: _config.packageInfo.version);
    });
  }

  AppState get appState {
    return _injector.getDependency<AppState>();
  }

  Future<void> registerAppStore() async {
    final store = await createStore();

    _injector.registerSingleton<Store<AppState>>((injector) {
      return store;
    });
  }

  void registerServices() {}

  void registerUsecases() {}

  void registerPresenters() {
    _injector.registerSingleton<BasePresenter>((injector) {
      return BasePresenter(appStore: appStore);
    });
  }
}
