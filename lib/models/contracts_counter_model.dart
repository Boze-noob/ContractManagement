class ContractsCounterModel {
  final int active;
  final int completed;
  final int terminated;
  final int requests;

  ContractsCounterModel({
    required this.active,
    required this.requests,
    required this.terminated,
    required this.completed,
  });

  ContractsCounterModel copyWith({
    final int? active,
    final int? completed,
    final int? terminated,
    final int? requests,
  }) =>
      ContractsCounterModel(
        active: active != null ? active : this.active,
        completed: completed != null ? completed : this.completed,
        terminated: terminated != null ? terminated : this.terminated,
        requests: requests != null ? requests : this.requests,
      );
}
