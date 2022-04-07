import 'package:contract_management/_all.dart';

class CompanyRequestsBloc extends Bloc<CompanyRequestsEvent, CompanyRequestsState> {
  final ICompanyRequest companyRequestRepo;
  CompanyRequestsBloc({required this.companyRequestRepo}) : super(initialState()) {
    on<CompanyGetOrderRequestsEvent>(_getOrder);
    on<CompanyGetAnnouncementRequestsEvent>(_getAnnouncement);
    on<CompanyEditOrderRequestEvent>(_editOrder);
    on<CompanyEditAnnouncementRequestsEvent>(_editAnnouncement);
  }

  static CompanyRequestsState initialState() => CompanyRequestsState(
        status: CompanyRequestsStateStatus.init,
        orderModels: List.empty(),
      );

  Future<void> _getOrder(CompanyGetOrderRequestsEvent event, Emitter<CompanyRequestsState> emit) async {
    emit(state.copyWith(status: CompanyRequestsStateStatus.loading));
    final result = await companyRequestRepo.getOrders(event.receiverId);
    if (result != null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.loaded, orderModels: result));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }

  Future<void> _getAnnouncement(CompanyGetAnnouncementRequestsEvent event, Emitter<CompanyRequestsState> emit) async {}

  Future<void> _editOrder(CompanyEditOrderRequestEvent event, Emitter<CompanyRequestsState> emit) async {
    final result = await companyRequestRepo.editOrder(event.orderStatusType, event.orderId);
    if (result == null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.editSuccessful, message: 'Order has been edited'));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }

  Future<void> _editAnnouncement(
      CompanyEditAnnouncementRequestsEvent event, Emitter<CompanyRequestsState> emit) async {}
}
