import 'package:contract_management/_all.dart';

abstract class OrderEvent {}

class OrderInitEvent extends OrderEvent {
  final OrderModel orderModel;

  OrderInitEvent({required this.orderModel});
}

class OrderInitClientDataEvent extends OrderEvent {
  final String employerName;
  final String senderName;
  final String orderLocation;

  OrderInitClientDataEvent({required this.employerName, required this.senderName, required this.orderLocation});
}

class OrderGetEvent extends OrderEvent {}

class OrderUpdateEvent extends OrderEvent {
  final OrderModel orderModel;

  OrderUpdateEvent({required this.orderModel});
}

class OrderSubmitUpdateEvent extends OrderEvent {}

class OrderCreateEvent extends OrderEvent {
  final String clientName;
  final String description;

  OrderCreateEvent({required this.clientName, required this.description});
}

class OrderSendEvent extends OrderEvent {
  final String orderId;
  final String receiverId;
  final String receiverName;

  OrderSendEvent({required this.orderId, required this.receiverId, required this.receiverName});
}

class OrderDeleteEvent extends OrderEvent {
  final String orderId;

  OrderDeleteEvent({required this.orderId});
}

class OrderGetCompaniesForOrderEvent extends OrderEvent {
  final List<ContractItemsType> contractItems;

  OrderGetCompaniesForOrderEvent({required this.contractItems});
}
