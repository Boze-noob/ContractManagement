class ContractsType {
  static const active = ContractsType._(0);
  static const completed = ContractsType._(1);
  static const terminated = ContractsType._(2);
  static const request = ContractsType._(3);

  static List<ContractsType> get values => [
        active,
        completed,
        terminated,
        request,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "active";
      case 1:
        return "completed";
      case 2:
        return "terminated";
      case 3:
        return "request";
      default:
        return " ";
    }
  }

  final int index;

  const ContractsType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static ContractsType getValue(int index) => ContractsType._(index);
}
