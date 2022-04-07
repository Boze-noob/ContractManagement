import 'package:contract_management/_all.dart';

enum AnnouncementStateStatus {
  init,
  loading,
  loaded,
  deleted,
  sent,
  created,
  error,
}

class AnnouncementState {
  final AnnouncementStateStatus status;
  final List<AnnouncementModel> announcementsModels;
  final String? message;

  AnnouncementState({required this.status, this.message, required this.announcementsModels});

  AnnouncementState copyWith({
    AnnouncementStateStatus? status,
    String? message,
    List<AnnouncementModel>? announcementsModels,
  }) =>
      AnnouncementState(
        status: status ?? this.status,
        message: message ?? this.message,
        announcementsModels: announcementsModels ?? this.announcementsModels,
      );
}
