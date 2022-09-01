import 'package:contract_management/_all.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  ICompanyRequest companyRequest;

  RequestsBloc({required this.companyRequest}) : super(initialState()) {
    on<RequestsInitEvent>(_init);
    on<RequestsLoadEvent>(_load);
    on<RequestsDeleteEvent>(_delete);
    on<RequestsSortEvent>(_sort);
  }

  static RequestsState initialState() => RequestsState(
        status: RequestsStateStatus.init,
        clientRequestModel: List.empty(),
      );

  void _init(RequestsInitEvent event, Emitter<RequestsState> emit) {
    initialState();
  }

  void _load(RequestsLoadEvent event, Emitter<RequestsState> emit) async {
    emit(
      state.copyWith(
        status: RequestsStateStatus.loading,
      ),
    );
    final result = await companyRequest.getRequests('requests', 'createdDateTime');
    if (result != null) {
      emit(state.copyWith(status: RequestsStateStatus.loaded, clientRequestModel: result));
    } else
      emit(state.copyWith(status: RequestsStateStatus.error, errorMessage: 'Error happen'));
  }

  void _delete(RequestsDeleteEvent event, Emitter<RequestsState> emit) async {
    emit(state.copyWith(status: RequestsStateStatus.loading));
    List<ClientRequestModel> requests = List.from(state.clientRequestModel);
    await companyRequest.deleteRequest(event.id);
    requests.removeWhere((request) => request.id == event.id);
    emit(state.copyWith(status: RequestsStateStatus.loaded, clientRequestModel: requests));
  }

  void _sort(RequestsSortEvent event, Emitter<RequestsState> emit) {
    emit(state.copyWith(status: RequestsStateStatus.loading));
    List<ClientRequestModel> requests = List.from(state.clientRequestModel);
    requests.sort((a, b) => a.createdDateTime.compareTo(b.createdDateTime));
    if (event.sortType == SortType.newest) requests = requests.reversed.toList();
    emit(
      state.copyWith(
        status: RequestsStateStatus.loaded,
        clientRequestModel: requests,
      ),
    );
  }
}
