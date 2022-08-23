import 'package:contract_management/_all.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  IClients clientsRepo;

  ClientsBloc({
    required this.clientsRepo,
  }) : super(
          ClientsState(
            status: ClientsStateStatus.init,
            clients: List.empty(),
          ),
        ) {
    on<ClientsInitEvent>(_initClients);
    on<ClientsLoadEvent>(_loadClients);
    on<ClientsAddEvent>(_addClient);
    on<ClientsDeleteEvent>(_deleteClient);
  }

  void _initClients(ClientsInitEvent event, Emitter<ClientsState> emit) async {}

  void _loadClients(ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(status: ClientsStateStatus.loading));
    emit(
      state.copyWith(
        status: ClientsStateStatus.loaded,
        clients: await clientsRepo.getClients(),
      ),
    );
  }

  void _addClient(ClientsAddEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }

  void _deleteClient(ClientsDeleteEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(status: ClientsStateStatus.loading));

    final result = await clientsRepo.deleteClient(event.clientId);

    if (result == null) {
      List<UserModel> clients = state.clients;
      clients.removeWhere((client) => client.id == event.clientId);
      emit(
        state.copyWith(status: ClientsStateStatus.deletedSuccessfully, clients: clients),
      );
    } else
      emit(
        state.copyWith(status: ClientsStateStatus.error, errorMessage: result),
      );
  }
}
