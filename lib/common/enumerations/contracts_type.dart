class ContractType {
  static const active = ContractType._(0);
  static const completed = ContractType._(1);
  static const terminated = ContractType._(2);
  static const request = ContractType._(3);

  static List<ContractType> get values => [
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

  const ContractType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static ContractType getValue(int index) => ContractType._(index);
}
