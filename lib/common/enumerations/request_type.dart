class RequestType {
  static const activate = RequestType._(0);
  static const interference = RequestType._(1);
  static const repair = RequestType._(2);

  static List<RequestType> get values => [
        activate,
        interference,
        repair,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "activate";
      case 1:
        return "interference";
      case 2:
        return "repair";
      default:
        return " ";
    }
  }

  final int index;

  const RequestType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static RequestType getValue(int index) => RequestType._(index);
}
