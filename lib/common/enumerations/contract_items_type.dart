class ContractItemsType {
  static const item1 = ContractItemsType._(0);
  static const item2 = ContractItemsType._(1);
  static const item3 = ContractItemsType._(2);
  static const item4 = ContractItemsType._(3);
  static const item5 = ContractItemsType._(4);
  static const item6 = ContractItemsType._(5);

  static List<ContractItemsType> get values => [
        item1,
        item2,
        item3,
        item4,
        item5,
        item6,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "item1";
      case 1:
        return "item2";
      case 2:
        return "item3";
      case 3:
        return "item4";
      case 4:
        return "item5";
      case 5:
        return "item6";
      default:
        return " ";
    }
  }

  final int index;

  const ContractItemsType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static ContractItemsType getValue(int index) => ContractItemsType._(index);
}
