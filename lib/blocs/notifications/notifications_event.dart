import 'package:contract_management/_all.dart';

abstract class NotificationsEvent {}

class NotificationsInitEvent extends NotificationsEvent {}

class NotificationsLoadEvent extends NotificationsEvent {
  final String userId;

  NotificationsLoadEvent({required this.userId});
}

class NotificationsSendEvent extends NotificationsEvent {
  final NotificationModel notificationModel;

  NotificationsSendEvent({required this.notificationModel});
}

class NotificationsDeleteEvent extends NotificationsEvent {
  final String userId;

  NotificationsDeleteEvent({required this.userId});
}
