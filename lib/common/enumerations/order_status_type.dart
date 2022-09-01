class OrderStatusType {
  static const waiting = OrderStatusType._(0);
  static const declined = OrderStatusType._(1);
  static const sent = OrderStatusType._(2);
  static const accepted = OrderStatusType._(3);

  static List<OrderStatusType> get values => [
        waiting,
        declined,
        sent,
        accepted,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "Waiting";
      case 1:
        return "Declined";
      case 2:
        return "Sent";
      case 3:
        return "Accepted";
      default:
        return " ";
    }
  }

  final int index;

  const OrderStatusType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static OrderStatusType getValue(int index) => OrderStatusType._(index);
}
