class ContractsType {
  static const active = ContractsType._(1);
  static const completed = ContractsType._(2);
  static const terminated = ContractsType._(3);

  static List<ContractsType> get values => [
        active,
        completed,
        terminated,
      ];

  final int index;

  const ContractsType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static ContractsType? getValue(int index) =>
      indexes.contains(index) ? ContractsType._(index) : null;
}
