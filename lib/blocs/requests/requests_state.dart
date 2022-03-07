enum RequestsStateStatus {
  init,
}

class RequestsState {
  RequestsStateStatus? status;
  RequestsState({this.status});

  RequestsState copyWith({
    RequestsStateStatus? status,
  }) =>
      RequestsState(
        status: status ?? this.status,
      );
}
