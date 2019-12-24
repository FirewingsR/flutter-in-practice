import '../../../container.dart';
import '../../ui.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ResetAction) {
    return WgContainer().appState;
  }
//  else {
//    return state.copyWith(
//      user: userReducer(state.user, action),
//      post: postReducer(state.post, action),
//      page: pageReducer(state.page, action),
//    );
//  }
}