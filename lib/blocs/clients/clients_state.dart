import 'package:contract_management/_all.dart';

enum ClientsStateStatus {
  init,
  loading,
  loaded,
  deletedSuccessfully,
  error,
}

class ClientsState {
  final ClientsStateStatus status;
  final List<UserModel> clients;
  final String? errorMessage;

  ClientsState({
    required this.status,
    required this.clients,
    this.errorMessage,
  });

  ClientsState copyWith({
    ClientsStateStatus? status,
    List<UserModel>? clients,
    String? errorMessage,
  }) =>
      ClientsState(
        status: status ?? this.status,
        clients: clients ?? this.clients,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
