import 'package:contract_management/_all.dart';

class AdminRequestsBloc extends Bloc<AdminRequestsEvent, AdminRequestsState>{
  final IRequest requestRepo;
  AdminRequestsBloc({required this.requestRepo}) : super(initialState()){
    on<AdminRequestsInitEvent>(_init);
    on<AdminRequestsGetEvent>(_load);

  }
  static AdminRequestsState initialState() => AdminRequestsState(model: List.empty(), status: AdminRequestsStateStatus.init);

  void _init(AdminRequestsInitEvent event, Emitter<AdminRequestsState> emit){
    emit(initialState());
  }

  void _load(AdminRequestsGetEvent event, Emitter<AdminRequestsState> emit) async {
    emit(state.copyWith(status: AdminRequestsStateStatus.loading));
    final result = await requestRepo.getAdminRequests(event.companyId);
    if(result != null)
      emit(state.copyWith(status: AdminRequestsStateStatus.loaded, model: result ));
    else emit(state.copyWith(status: AdminRequestsStateStatus.error, errorMessage: 'Error happen'));
  }
}