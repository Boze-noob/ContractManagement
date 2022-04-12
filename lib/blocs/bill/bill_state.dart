import 'package:contract_management/_all.dart';

enum BillStateStatus { init, loading, loaded, submitSuccessful, error }

class BillState {
  final BillStateStatus status;
  final BillModel billModel;
  final List<BillModel> billsModels;
  final String? message;

  BillState({
    required this.status,
    required this.billModel,
    this.message,
    required this.billsModels,
  });

  BillState copyWith({
    BillStateStatus? status,
    BillModel? billModel,
    List<BillModel>? billsModels,
    String? message,
  }) =>
      BillState(
        status: status ?? this.status,
        billModel: billModel ?? this.billModel,
        billsModels: billsModels ?? this.billsModels,
        message: message ?? this.message,
      );
}
