import 'package:contract_management/_all.dart';

enum WorkDiariesStateStatus {
  init,
  loading,
  loaded,
  created,
  updateSuccessful,
  error,
}

class WorkDiariesState {
  final WorkDiariesStateStatus status;
  final List<WorkDiaryModel> workDiaryModels;
  final WorkDiaryModel? workDiaryModel;
  final WorkingDayModel? workingDayModel;
  final String? message;

  WorkDiariesState({
    required this.status,
    required this.workDiaryModels,
    this.workDiaryModel,
    this.workingDayModel,
    this.message,
  });

  WorkDiariesState copyWith({
    WorkDiariesStateStatus? status,
    List<WorkDiaryModel>? workDiaryModels,
    WorkDiaryModel? workDiaryModel,
    WorkingDayModel? workingDayModel,
    String? message,
  }) =>
      WorkDiariesState(
        status: status ?? this.status,
        workDiaryModels: workDiaryModels ?? this.workDiaryModels,
        workDiaryModel: workDiaryModel ?? this.workDiaryModel,
        workingDayModel: workingDayModel ?? this.workingDayModel,
      );
}
