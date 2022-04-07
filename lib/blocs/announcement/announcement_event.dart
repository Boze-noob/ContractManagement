import 'package:contract_management/_all.dart';

abstract class AnnouncementEvent {}

class AnnouncementGetEvent extends AnnouncementEvent {}

class AnnouncementCreateEvent extends AnnouncementEvent {
  final OrderModel orderModel;

  AnnouncementCreateEvent({required this.orderModel});
}
