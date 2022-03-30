class AdminRequestType {
  static const order = AdminRequestType._(0);
  static const announcement = AdminRequestType._(1);

  static List<AdminRequestType> get values => [
        order,
        announcement,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "order";
      case 1:
        return "announcement";
      default:
        return " ";
    }
  }

  final int index;

  const AdminRequestType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static AdminRequestType getValue(int index) => AdminRequestType._(index);
}
