import 'package:contract_management/_all.dart';

abstract class AnnouncementEvent {}

class AnnouncementGetEvent extends AnnouncementEvent {}

class AnnouncementCreateEvent extends AnnouncementEvent {
  final OrderModel orderModel;
  final String employerName;

  AnnouncementCreateEvent({required this.orderModel, required this.employerName});
}
