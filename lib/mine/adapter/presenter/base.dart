import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:redux/redux.dart';

import '../../ui/ui.dart';
import '../../container.dart';

class BasePresenter {
  Store<AppState> appStore;

  BasePresenter({@required this.appStore});

  NavigatorState navigator([BuildContext context]) {
    return context == null ? WgContainer().rootNavigatorKey.currentState : Navigator.of(context);
  }
  
  Future<T> doWithLoading<T>(Future<T> Function() doSomething) async {
    final cancelLoading = showLoading();
    T result;
    try {
     result = await doSomething();  
    } on Exception catch(e) {
      handleException(e);
    } finally {
      cancelLoading();
    }
    return result;
  }

  doSomething() {}

  VoidCallback showLoading() {
    return BotToast.showLoading();
  }

  handleException(e) {
  }
}
