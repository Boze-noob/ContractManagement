import 'package:contract_management/_all.dart';

abstract class OrderEvent {}

class OrderInitEvent extends OrderEvent {
  final OrderModel orderModel;

  OrderInitEvent({required this.orderModel});
}

class OrderGetEvent extends OrderEvent {}

class OrderUpdateEvent extends OrderEvent {
  final OrderModel orderModel;

  OrderUpdateEvent({required this.orderModel});
}

class OrderSubmitUpdateEvent extends OrderEvent {}

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

class OrderGetCompaniesForOrderEvent extends OrderEvent {
  final List<ContractItemsType> contractItems;

  OrderGetCompaniesForOrderEvent({required this.contractItems});
}
