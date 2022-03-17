enum NavigatorStateStatus {
  init,
  updated,
}

class NavigatorState {
  final NavigatorStateStatus status;
  final int index;

  NavigatorState({required this.status, required this.index});

  NavigatorState copyWith({
    NavigatorStateStatus? status,
    int? index,
  }) =>
      NavigatorState(
        status: status ?? this.status,
        index: index ?? this.index,
      );
}
