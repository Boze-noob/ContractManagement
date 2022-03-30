import 'package:contract_management/_all.dart';

enum OrderStateStatus {
  init,
  loading,
  loaded,
  submitSuccessful,
  error,
  deleteSuccessful,
}

class OrderState {
  final OrderStateStatus status;
  final OrderModel orderModel;
  final List<OrderModel> orderModels;
  final String? message;

  OrderState({
    required this.status,
    required this.orderModel,
    required this.orderModels,
    this.message,
  });

  OrderState copyWith({
    OrderStateStatus? status,
    OrderModel? orderModel,
    List<OrderModel>? orderModels,
    String? message,
  }) =>
      OrderState(
        status: status ?? this.status,
        orderModel: orderModel ?? this.orderModel,
        orderModels: orderModels ?? this.orderModels,
        message: message ?? this.message,
      );
}
