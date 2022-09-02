import 'package:contract_management/_all.dart';

abstract class AnnouncementEvent {}

class AnnouncementGetEvent extends AnnouncementEvent {}

class AnnouncementCreateEvent extends AnnouncementEvent {
  final OrderModel orderModel;
  final String employerName;

  AnnouncementCreateEvent({
    required this.orderModel,
    required this.employerName,
  });
}

class AnnouncementDeleteEvent extends AnnouncementEvent {
  final String announcementId;

  AnnouncementDeleteEvent({
    required this.announcementId,
  });
}

class AnnouncementSendEvent extends AnnouncementEvent {
  final String announcementId;
  final String? receiverId;

  AnnouncementSendEvent({
    required this.announcementId,
    required this.receiverId,
  });
}

class AnnouncementDeclineEvent extends AnnouncementEvent {
  final String announcementId;
  final AnnouncementStatusType announcementStatusType;
  final String? declineMessage;

  AnnouncementDeclineEvent({
    required this.announcementId,
    required this.announcementStatusType,
    this.declineMessage,
  });
}

class AnnouncementSortEvent extends AnnouncementEvent {
  final AnnouncementSortType announcementSortType;

  AnnouncementSortEvent({
    required this.announcementSortType,
  });
}
