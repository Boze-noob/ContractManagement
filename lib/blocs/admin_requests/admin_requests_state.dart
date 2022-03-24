import 'package:contract_management/_all.dart';

enum AdminRequestsStateStatus {
  init, loading, loaded, error,
}

class AdminRequestsState {

  final AdminRequestsStateStatus status;
  final List<AdminRequestModel> model;
  final String? errorMessage;

  AdminRequestsState({required this.status, required this.model, this.errorMessage});

  AdminRequestsState copyWith({
     AdminRequestsStateStatus? status,
     List<AdminRequestModel>? model,
     String? errorMessage,
}) => AdminRequestsState(status: status ?? this.status, model: model ?? this.model, errorMessage: errorMessage ?? this.errorMessage,);

}