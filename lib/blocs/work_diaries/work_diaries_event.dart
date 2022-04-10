import 'package:contract_management/_all.dart';

abstract class WorkDiariesEvent {}

class WorkDiariesGetEvent extends WorkDiariesEvent {
  final String companyId;

  WorkDiariesGetEvent({required this.companyId});
}

class WorkDiariesUpdateEvent extends WorkDiariesEvent {
  final WorkDiaryModel? workDiaryModel;
  final WorkingDayModel? workingDayModel;

  WorkDiariesUpdateEvent({this.workDiaryModel, this.workingDayModel});
}

class WorkDiariesSubmitUpdateEvent extends WorkDiariesEvent {
  final List<WorkingDayModel>? workingDayModels;

  WorkDiariesSubmitUpdateEvent(this.workingDayModels);
}

class WorkDiariesCreateEvent extends WorkDiariesEvent {
  final WorkDiaryModel workDiaryModel;

  WorkDiariesCreateEvent({required this.workDiaryModel});
}
