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

  void _addClients(ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }

  void _deleteClients(ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }
}
