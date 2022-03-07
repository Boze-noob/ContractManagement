enum ClientsStateStatus {
  init,
  loading,
  loaded,
  error,
}

class ClientsState {
  final ClientsStateStatus? status;

  ClientsState({
    this.status,
  });

  ClientsState copyWith({
    ClientsStateStatus? status,
  }) =>
      ClientsState(
        status: status ?? this.status,
      );
}
