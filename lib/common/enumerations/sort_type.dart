class ClientRequestSortType {
  static const newest = ClientRequestSortType._(0);
  static const oldest = ClientRequestSortType._(1);

  static List<ClientRequestSortType> get values => [newest, oldest];

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

  const ClientRequestSortType._(this.index);

  static List<int> get indexes => values.map<int>((x) => x.index).toList();

  static ClientRequestSortType getValue(int index) => ClientRequestSortType._(index);
}

class OrderSortType {
  static const newest = OrderSortType._(0);
  static const oldest = OrderSortType._(1);
  static const waiting = OrderSortType._(2);
  static const declined = OrderSortType._(3);
  static const sent = OrderSortType._(4);
  static const accepted = OrderSortType._(5);

  static List<OrderSortType> get values => [newest, oldest, waiting, declined, sent, accepted];

  String translate() {
    switch (index) {
      case 0:
        return "Newest";
      case 1:
        return "Oldest";
      case 2:
        return "Waiting";
      case 3:
        return "Declined";
      case 4:
        return "Sent";
      case 5:
        return "Accepted";
      default:
        return " ";
    }
  }

  final int index;

  const OrderSortType._(this.index);

  static List<int> get indexes => values.map<int>((x) => x.index).toList();

  static OrderSortType getValue(int index) => OrderSortType._(index);
}

class AnnouncementSortType {
  static const newest = AnnouncementSortType._(0);
  static const oldest = AnnouncementSortType._(1);
  static const waiting = AnnouncementSortType._(2);
  static const sent = AnnouncementSortType._(3);
  static const inProgress = AnnouncementSortType._(4);
  static const done = AnnouncementSortType._(5);
  static const approved = AnnouncementSortType._(6);

  static List<AnnouncementSortType> get values => [
        newest,
        oldest,
        waiting,
        sent,
        approved,
        done,
        inProgress,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "Newest";
      case 1:
        return "Oldest";
      case 2:
        return "Waiting";
      case 3:
        return "Sent";
      case 4:
        return "In Progress";
      case 5:
        return "Done";
      case 6:
        return "Approved";
      default:
        return " ";
    }
  }

  final int index;

  const AnnouncementSortType._(this.index);

  static List<int> get indexes => values.map<int>((x) => x.index).toList();

  static AnnouncementSortType getValue(int index) => AnnouncementSortType._(index);
}
