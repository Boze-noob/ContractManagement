import 'package:contract_management/_all.dart';

enum RequestsStateStatus {
  init,
  loading,
  loaded,
  error,
}

class RequestsState {
  final RequestsStateStatus status;
  final List<ClientRequestModel> clientRequestModel;
  final String? errorMessage;

  RequestsState({
    required this.status,
    required this.clientRequestModel,
    this.errorMessage,
  });

  RequestsState copyWith({
    RequestsStateStatus? status,
    List<ClientRequestModel>? clientRequestModel,
    String? errorMessage,
  }) =>
      RequestsState(
        status: status ?? this.status,
        clientRequestModel: clientRequestModel ?? this.clientRequestModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
