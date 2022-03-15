import 'package:contract_management/_all.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  IRequest request;
  RequestsBloc({required this.request}) : super(initialState()) {
    on<RequestsInitEvent>(_init);
    on<RequestsLoadEvent>(_load);
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
    final result = await request.getRequests('requests', 'createdDateTime');
    if (result != null) {
      emit(state.copyWith(status: RequestsStateStatus.loaded, clientRequestModel: result));
    } else
      emit(state.copyWith(status: RequestsStateStatus.error, errorMessage: 'Error happen'));
  }
}
