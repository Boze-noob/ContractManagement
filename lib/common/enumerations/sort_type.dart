class SortType {
  static const newest = SortType._(0);
  static const oldest = SortType._(1);

  static List<SortType> get values => [newest, oldest];

  String translate() {
    switch (index) {
      case 0:
        return "Newest";
      case 1:
        return "Oldest";
      default:
        return " ";
    }
  }

  final int index;

  const SortType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static SortType getValue(int index) => SortType._(index);
}
