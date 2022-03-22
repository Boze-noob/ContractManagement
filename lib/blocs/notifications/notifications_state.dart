import 'package:contract_management/_all.dart';

enum NotificationStateStatus {
  init,
  loading,
  loaded,
  submitting,
  successfullySubmitted,
  error,
  successfullyDeleted,
}

class NotificationsState {
  final NotificationStateStatus status;
  final List<NotificationModel> model;
  final String? errorMessage;

  NotificationsState({
    required this.status,
    required this.model,
    this.errorMessage,
  });

  NotificationsState copyWith({
    final NotificationStateStatus? status,
    final List<NotificationModel>? model,
    final String? errorMessage,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        model: model ?? this.model,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
