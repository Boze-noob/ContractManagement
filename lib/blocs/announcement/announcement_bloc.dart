import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/announcement.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final IAnnouncement announcementRepo;
  AnnouncementBloc({required this.announcementRepo}) : super(initialState()) {
    on<AnnouncementGetEvent>(_getAnnouncement);
    on<AnnouncementCreateEvent>(_createAnnouncement);
    on<AnnouncementDeleteEvent>(_deleteAnnouncement);
    on<AnnouncementSendEvent>(_sendAnnouncement);
  }

  static AnnouncementState initialState() =>
      AnnouncementState(status: AnnouncementStateStatus.init, announcementsModels: List.empty());

  Future<void> _getAnnouncement(AnnouncementGetEvent event, Emitter<AnnouncementState> emit) async {
    emit(state.copyWith(status: AnnouncementStateStatus.loading));
    final result = await announcementRepo.getAnnouncements();
    if (result != null)
      emit(state.copyWith(status: AnnouncementStateStatus.loaded, announcementsModels: result));
    else
      emit(state.copyWith(status: AnnouncementStateStatus.error, message: 'Error happen'));
  }

  Future<void> _createAnnouncement(AnnouncementCreateEvent event, Emitter<AnnouncementState> emit) async {
    if (event.orderModel.receiverId == null) {
      emit(state.copyWith(status: AnnouncementStateStatus.error, message: 'Receiver id is not defined'));
    } else {
      AnnouncementModel announcementModel = AnnouncementModel(
        id: generateRandomId(),
        orderId: event.orderModel.id,
        receiverId: event.orderModel.receiverId,
        receiverName: event.orderModel.receiverName,
        contractItems: event.orderModel.contractItems,
        price: event.orderModel.price,
        createdDateTime: event.orderModel.createdDateTime,
        employerName: event.employerName,
        announcementStatusType: AnnouncementStatusType.waiting,
        completionDateTime: event.orderModel.completionDateTime,
      );
      final result = await announcementRepo.createAnnouncement(announcementModel);
      if (result)
        emit(state.copyWith(status: AnnouncementStateStatus.created, message: 'Announcement created'));
      else
        emit(state.copyWith(status: AnnouncementStateStatus.error, message: 'Error happen'));
    }
  }

  Future<void> _deleteAnnouncement(AnnouncementDeleteEvent event, Emitter<AnnouncementState> emit) async {
    final result = await announcementRepo.deleteAnnouncement(event.announcementId);
    if (result == null)
      emit(state.copyWith(status: AnnouncementStateStatus.deleted, message: 'Deleted successfully'));
    else
      emit(state.copyWith(status: AnnouncementStateStatus.error, message: result));
  }

  Future<void> _sendAnnouncement(AnnouncementSendEvent event, Emitter<AnnouncementState> emit) async {
    final result = await announcementRepo.sendAnnouncement(event.announcementId, event.receiverId);
    if (result == null)
      emit(state.copyWith(status: AnnouncementStateStatus.sent, message: 'Announcement sent'));
    else
      emit(state.copyWith(status: AnnouncementStateStatus.error, message: result));
  }
}
