enum ContractsStateStatus {
  init,
}

class ContractsState {
  final ContractsStateStatus? status;
  ContractsState({this.status});

  ContractsState copyWith({
    ContractsStateStatus? status,
  }) =>
      ContractsState(
        status: status ?? this.status,
      );
}
