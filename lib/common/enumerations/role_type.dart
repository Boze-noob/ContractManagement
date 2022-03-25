class RoleType {
  static const admin = RoleType._(0);
  static const company = RoleType._(1);
  static const client = RoleType._(2);
  static const orderEmployer = RoleType._(3);
  static const announcementEmployer = RoleType._(4);
  static const orderVerifyEmployer = RoleType._(5);

  static List<RoleType> get values => [
        admin,
        company,
        client,
        orderEmployer,
        announcementEmployer,
        orderVerifyEmployer,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "Admin";
      case 1:
        return "Company";
      case 2:
        return "Client";
      case 3:
        return "Order employer";
      case 4:
        return "Announcement employer";
      case 5:
        return "Order verify employer";
      default:
        return " ";
    }
  }

  final int index;
  static int get getEnumLength => values.length;

  const RoleType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static RoleType getValue(int index) => RoleType._(index);
}
