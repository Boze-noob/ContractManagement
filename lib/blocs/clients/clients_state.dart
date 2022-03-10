import 'package:contract_management/_all.dart';

enum ClientsStateStatus {
  init,
  loading,
  loaded,
  error,
}

class ClientsState {
  final ClientsStateStatus status;
  final List<UserModel> clients;

  ClientsState({
    required this.status,
    required this.clients,
  });

  ClientsState copyWith({
    ClientsStateStatus? status,
    List<UserModel>? clients,
  }) =>
      ClientsState(
        status: status ?? this.status,
        clients: clients ?? this.clients,
      );
}
