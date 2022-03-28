import 'package:contract_management/_all.dart';

enum CompanyRequestsStateStatus {
  init,
  loading,
  loaded,
  error,
  empty,
}

class CompanyRequestsState {
  final CompanyRequestsStateStatus status;
  final List<AdminRequestModel>? model;
  final String? errorMessage;

  CompanyRequestsState({required this.status, required this.model, this.errorMessage});

  CompanyRequestsState copyWith({
    CompanyRequestsStateStatus? status,
    List<AdminRequestModel>? model,
    String? errorMessage,
  }) =>
      CompanyRequestsState(
        status: status ?? this.status,
        model: model,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
