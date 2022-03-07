import 'package:contract_management/_all.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  ClientsBloc()
      : super(
          ClientsState(
            status: ClientsStateStatus.init,
          ),
        ) {
    on<ClientsInitEvent>(_initClients);
    on<ClientsLoadEvent>(_loadClients);
  }

  void _initClients(ClientsInitEvent event, Emitter<ClientsState> emit) async {
    final state = this.state;
  }

  void _loadClients(ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    final state = this.state;
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }

  void _addClients(ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    final state = this.state;
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }

  void _deleteClients(
      ClientsLoadEvent event, Emitter<ClientsState> emit) async {
    final state = this.state;
    emit(state.copyWith(status: ClientsStateStatus.loading));
  }
}
