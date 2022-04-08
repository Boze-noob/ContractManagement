import 'package:contract_management/_all.dart';

abstract class CompanyRequestsEvent {}

class CompanyGetRequestsEvent extends CompanyRequestsEvent {
  final String receiverId;

  CompanyGetRequestsEvent({required this.receiverId});
}

class CompanyGetOrderRequestsEvent extends CompanyRequestsEvent {
  final String receiverId;

  CompanyGetOrderRequestsEvent({
    required this.receiverId,
  });
}

class CompanyGetAnnouncementRequestsEvent extends CompanyRequestsEvent {
  final String receiverId;

  CompanyGetAnnouncementRequestsEvent({required this.receiverId});
}

class CompanyEditOrderRequestEvent extends CompanyRequestsEvent {
  final OrderStatusType orderStatusType;
  final String orderId;

  CompanyEditOrderRequestEvent({required this.orderStatusType, required this.orderId});
}

class CompanyEditAnnouncementRequestsEvent extends CompanyRequestsEvent {
  final AnnouncementStatusType announcementStatusType;
  final String announcementId;

  CompanyEditAnnouncementRequestsEvent({required this.announcementStatusType, required this.announcementId});
}
