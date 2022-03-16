import 'package:contract_management/_all.dart';

enum RevenueStateStatus {
  init,
  loading,
  loaded,
  error,
}

class RevenueState {
  final RevenueStateStatus status;
  final RevenueModel revenueModel;
  final String? errorMessage;

  RevenueState({
    required this.status,
    required this.revenueModel,
    this.errorMessage,
  });

  RevenueState copyWith({
    RevenueStateStatus? status,
    RevenueModel? revenueModel,
    String? errorMessage,
  }) =>
      RevenueState(
        status: status ?? this.status,
        revenueModel: revenueModel ?? this.revenueModel,
      );
}
