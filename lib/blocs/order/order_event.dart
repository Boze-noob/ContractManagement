import 'package:contract_management/_all.dart';

abstract class OrderEvent {}

class OrderInitEvent extends OrderEvent {}

class OrderGetEvent extends OrderEvent {}

class OrderUpdateEvent extends OrderEvent {
  final OrderModel orderModel;

  OrderUpdateEvent({required this.orderModel});
}

class OrderCreateEvent extends OrderEvent {
  final String clientName;

  OrderCreateEvent({required this.clientName});
}

class OrderSendEvent extends OrderEvent {
  final String orderId;
  final String companyId;

  OrderSendEvent({required this.orderId, required this.companyId});
}

class OrderDeleteEvent extends OrderEvent {
  final String orderId;

  OrderDeleteEvent({required this.orderId});
}
