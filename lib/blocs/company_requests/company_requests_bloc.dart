import 'package:contract_management/_all.dart';

class CompanyRequestsBloc extends Bloc<CompanyRequestsEvent, CompanyRequestsState> {
  final IRequest requestRepo;
  CompanyRequestsBloc({required this.requestRepo}) : super(initialState()) {
    on<CompanyRequestsInitEvent>(_init);
    on<CompanyRequestsSendEvent>(_send);
    on<CompanyRequestsGetEvent>(_load);
  }
  static CompanyRequestsState initialState() => CompanyRequestsState(model: List.empty(), status: CompanyRequestsStateStatus.init);

  void _init(CompanyRequestsInitEvent event, Emitter<CompanyRequestsState> emit) {
    emit(initialState());
  }

  void _send(CompanyRequestsSendEvent event, Emitter<CompanyRequestsState> emit) {}

  void _load(CompanyRequestsGetEvent event, Emitter<CompanyRequestsState> emit) async {
    emit(state.copyWith(status: CompanyRequestsStateStatus.loading));
    final result = await requestRepo.getAdminRequests(event.companyId);
    if (result != null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.loaded, model: result));
    else
      emit(
        state.copyWith(
          status: CompanyRequestsStateStatus.empty,
          model: result,
        ),
      );
  }
}
