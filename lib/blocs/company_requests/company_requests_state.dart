import 'package:contract_management/_all.dart';

enum CompanyRequestsStateStatus {
  init,
  loading,
  loaded,
  error,
  empty,
  editSuccessful,
}

class CompanyRequestsState {
  final CompanyRequestsStateStatus status;
  final List<OrderModel> orderModels;
  final String? message;

  CompanyRequestsState(
      {required this.status, required this.orderModels, this.message});

  CompanyRequestsState copyWith({
    final CompanyRequestsStateStatus? status,
    final List<OrderModel>? orderModels,
    final String? message,
  }) =>
      CompanyRequestsState(
        status: status ?? this.status,
        orderModels: orderModels ?? this.orderModels,
        message: message ?? this.message,
      );
}
