import 'package:contract_management/_all.dart';

enum ClientRequestStateStatus {
  init,
  loading,
  submitting,
  submitSuccessfully,
  error,
}

class ClientRequestState {
  final ClientRequestStateStatus status;
  final ClientRequestModel requestModel;
  final String? errorMessage;

  ClientRequestState({
    required this.status,
    required this.requestModel,
    this.errorMessage,
  });

  ClientRequestState copyWith({
    ClientRequestStateStatus? status,
    ClientRequestModel? requestModel,
    String? errorMessage,
  }) =>
      ClientRequestState(
        status: status ?? this.status,
        requestModel: requestModel ?? this.requestModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
