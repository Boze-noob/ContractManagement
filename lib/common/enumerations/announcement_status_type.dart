class AnnouncementStatusType {
  static const waiting = AnnouncementStatusType._(0);
  static const sent = AnnouncementStatusType._(1);

  static List<AnnouncementStatusType> get values => [
        waiting,
        sent,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "waiting";
      case 1:
        return "sent";
      default:
        return " ";
    }
  }

  final int index;

  const AnnouncementStatusType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static AnnouncementStatusType getValue(int index) => AnnouncementStatusType._(index);
}
