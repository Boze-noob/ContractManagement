import 'package:contract_management/_all.dart';
import 'package:contract_management/blocs/navigator/navigator_state.dart' as navigatorState;

class NavigatorBloc extends Bloc<NavigatorEvent, navigatorState.NavigatorState> {
  NavigatorBloc() : super(initialState()) {
    on<NavigatorInitEvent>(_init);
    on<NavigatorUpdateEvent>(_update);
  }

  static navigatorState.NavigatorState initialState() => navigatorState.NavigatorState(
        status: navigatorState.NavigatorStateStatus.init,
        index: 0,
      );

  void _init(NavigatorInitEvent event, Emitter<navigatorState.NavigatorState> emit) {
    initialState();
  }

  void _update(NavigatorUpdateEvent event, Emitter<navigatorState.NavigatorState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
