class AnnouncementStatusType {
  static const waiting = AnnouncementStatusType._(0);
  static const sent = AnnouncementStatusType._(1);
  static const inProgress = AnnouncementStatusType._(2);
  static const done = AnnouncementStatusType._(3);

  static List<AnnouncementStatusType> get values => [
        waiting,
        sent,
        inProgress,
        done,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "waiting";
      case 1:
        return "sent";
      case 2:
        return "in progress";
      case 3:
        return "done";
      default:
        return " ";
    }
  }

  final int index;

  const AnnouncementStatusType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static AnnouncementStatusType getValue(int index) =>
      AnnouncementStatusType._(index);
}
