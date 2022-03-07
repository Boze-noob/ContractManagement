class RoleType {
  static const admin = RoleType._(1);
  static const company = RoleType._(2);
  static const client = RoleType._(3);

  static List<RoleType> get values => [
        admin,
        company,
        client,
      ];

  final int index;

  const RoleType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static RoleType? getValue(int index) => indexes.contains(index) ? RoleType._(index) : null;
}
