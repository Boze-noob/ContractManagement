import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/announcement.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final IAnnouncement announcementRepo;
  AnnouncementBloc({required this.announcementRepo}) : super(initialState()) {
    on<AnnouncementGetEvent>(_getAnnouncement);
    on<AnnouncementCreateEvent>(_createAnnouncement);
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
    if (event.orderModel.receiverId != null) {
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
        employerName: event.orderModel.employerName,
      );
      final result = await announcementRepo.createAnnouncement(announcementModel);
      if (result)
        emit(state.copyWith(status: AnnouncementStateStatus.announcementCreated));
      else
        emit(state.copyWith(status: AnnouncementStateStatus.error, message: 'Error happen'));
    }
  }
}
