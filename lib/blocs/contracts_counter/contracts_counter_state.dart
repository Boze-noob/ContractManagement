enum ContractsCounterStateStatus {
  init,
  loading,
  loaded,
  error,
}

class ContractsCounterState {
  final ContractsCounterStateStatus status;
  final int active;
  final int completed;
  final int terminated;

  ContractsCounterState({
    required this.status,
    required this.active,
    required this.completed,
    required this.terminated,
  });

  ContractsCounterState copyWith({
    ContractsCounterStateStatus? status,
    int? active,
    int? completed,
    int? terminated,
  }) =>
      ContractsCounterState(
        status: status ?? this.status,
        active: active ?? this.active,
        completed: completed ?? this.completed,
        terminated: terminated ?? this.terminated,
      );
}
