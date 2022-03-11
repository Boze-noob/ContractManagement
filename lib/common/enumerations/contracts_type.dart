class ContractsType {
  static const active = ContractsType._(0);
  static const completed = ContractsType._(1);
  static const terminated = ContractsType._(2);

  static List<ContractsType> get values => [
        active,
        completed,
        terminated,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "active";
      case 1:
        return "completed";
      case 2:
        return "terminated";
      default:
        return " ";
    }
  }

  final int index;

  const ContractsType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static ContractsType getValue(int index) => ContractsType._(index);
}
