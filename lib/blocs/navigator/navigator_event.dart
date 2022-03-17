abstract class NavigatorEvent {}

class NavigatorInitEvent extends NavigatorEvent {}

class NavigatorUpdateEvent extends NavigatorEvent {
  final int index;

  NavigatorUpdateEvent(this.index);
}
