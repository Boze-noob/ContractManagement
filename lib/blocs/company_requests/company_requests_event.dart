import 'package:contract_management/_all.dart';

abstract class CompanyRequestsEvent {}

class CompanyGetOrderRequestsEvent extends CompanyRequestsEvent {
  final String receiverId;

  CompanyGetOrderRequestsEvent({
    required this.receiverId,
  });
}

class CompanyGetAnnouncementRequestsEvent extends CompanyRequestsEvent {}

class CompanyEditOrderRequestEvent extends CompanyRequestsEvent {
  final OrderStatusType orderStatusType;
  final String orderId;

  CompanyEditOrderRequestEvent({required this.orderStatusType, required this.orderId});
}

class CompanyEditAnnouncementRequestsEvent extends CompanyRequestsEvent {}
