import 'dart:async';

import 'package:contract_management/_all.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  INotifications notificationsRepo;
  late StreamSubscription currentUserSubscription;
  NotificationsBloc({
    required this.notificationsRepo,
    required CurrentUserBloc currentUserBloc,
  }) : super(initialState()) {
    on<NotificationsInitEvent>(_init);
    on<NotificationsLoadEvent>(_load);
    on<NotificationsSendEvent>(_send);
    on<NotificationsDeleteEvent>(_delete);
    currentUserSubscription = currentUserBloc.stream.listen((state) {
      if (state.status == CurrentUserStateStatus.success) {
        if (state.userModel!.role == RoleType.client.translate() ||
            state.userModel!.role == RoleType.company.translate()) {
          add(NotificationsLoadEvent(userId: state.userModel!.id));
        } else
          add(NotificationsLoadEvent(userId: 'admin'));
      }
    });
  }

  static initialState() => NotificationsState(status: NotificationStateStatus.init, model: List.empty());

  Future<void> _init(NotificationsInitEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsState(status: NotificationStateStatus.init, model: List.empty()));
  }

  Future<void> _load(NotificationsLoadEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: NotificationStateStatus.loading));
    final result = await notificationsRepo.getNotifications(event.userId);
    if (result != null)
      emit(state.copyWith(model: result, status: NotificationStateStatus.loaded));
    else
      emit(state.copyWith(errorMessage: 'Error happen', status: NotificationStateStatus.error));
  }

  Future<void> _send(NotificationsSendEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: NotificationStateStatus.submitting));
    final result = await notificationsRepo.sendNotification(event.notificationModel);
    if (result)
      emit(state.copyWith(
        status: NotificationStateStatus.successfullySubmitted,
      ));
    else
      emit(state.copyWith(status: NotificationStateStatus.error, errorMessage: 'Error happen'));
  }

  Future<void> _delete(NotificationsDeleteEvent event, Emitter<NotificationsState> emit) async {
    final result = await notificationsRepo.deleteNotifications(event.userId);
    if (result == null) {
      emit(state.copyWith(
        status: NotificationStateStatus.successfullyDeleted,
      ));
      emit(state.copyWith(status: NotificationStateStatus.loading));
      final result = await notificationsRepo.getNotifications(event.userId);
      if (result != null) emit(state.copyWith(model: result, status: NotificationStateStatus.loaded));
    } else
      emit(state.copyWith(status: NotificationStateStatus.error));
  }

  @override
  Future<void> close() {
    currentUserSubscription.cancel();
    return super.close();
  }
}
