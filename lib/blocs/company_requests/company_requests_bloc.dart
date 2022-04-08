import 'package:contract_management/_all.dart';

class CompanyRequestsBloc extends Bloc<CompanyRequestsEvent, CompanyRequestsState> {
  final ICompanyRequest companyRequestRepo;
  CompanyRequestsBloc({required this.companyRequestRepo}) : super(initialState()) {
    on<CompanyGetRequestsEvent>(_getRequests);
    on<CompanyGetOrderRequestsEvent>(_getOrders);
    on<CompanyGetAnnouncementRequestsEvent>(_getAnnouncements);
    on<CompanyEditOrderRequestEvent>(_editOrder);
    on<CompanyEditAnnouncementRequestsEvent>(_editAnnouncement);
  }

  static CompanyRequestsState initialState() => CompanyRequestsState(
        status: CompanyRequestsStateStatus.init,
        orderModels: List.empty(),
        announcementsModels: List.empty(),
      );

  Future<void> _getRequests(CompanyGetRequestsEvent event, Emitter<CompanyRequestsState> emit) async {
    emit(state.copyWith(status: CompanyRequestsStateStatus.loading));
    final orders = await companyRequestRepo.getOrders(event.receiverId);
    final announcements = await companyRequestRepo.getAnnouncements(event.receiverId);
    emit(state.copyWith(
        status: CompanyRequestsStateStatus.loaded, orderModels: orders, announcementsModels: announcements));
  }

  Future<void> _getOrders(CompanyGetOrderRequestsEvent event, Emitter<CompanyRequestsState> emit) async {
    emit(state.copyWith(status: CompanyRequestsStateStatus.loading));
    final result = await companyRequestRepo.getOrders(event.receiverId);
    if (result != null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.loaded, orderModels: result));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }

  Future<void> _getAnnouncements(CompanyGetAnnouncementRequestsEvent event, Emitter<CompanyRequestsState> emit) async {
    emit(state.copyWith(status: CompanyRequestsStateStatus.loading));
    final result = await companyRequestRepo.getAnnouncements(event.receiverId);
    if (result != null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.loaded, announcementsModels: result));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }

  Future<void> _editOrder(CompanyEditOrderRequestEvent event, Emitter<CompanyRequestsState> emit) async {
    final result = await companyRequestRepo.editOrder(event.orderStatusType, event.orderId);
    if (result == null)
      emit(state.copyWith(status: CompanyRequestsStateStatus.orderEditSuccessful, message: 'Order has been edited'));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }

  Future<void> _editAnnouncement(CompanyEditAnnouncementRequestsEvent event, Emitter<CompanyRequestsState> emit) async {
    final result = await companyRequestRepo.editAnnouncement(event.announcementStatusType, event.announcementId);
    if (result == null)
      emit(state.copyWith(
          status: CompanyRequestsStateStatus.announcementEditSuccessful, message: 'Announcement has been edited'));
    else
      emit(state.copyWith(status: CompanyRequestsStateStatus.error, message: 'Error happen'));
  }
}
