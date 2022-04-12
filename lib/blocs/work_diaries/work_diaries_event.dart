import 'package:contract_management/_all.dart';

abstract class WorkDiariesEvent {}

class WorkDiariesInitEvent extends WorkDiariesEvent {
  final WorkingDayModel workingDayModel;

  WorkDiariesInitEvent({required this.workingDayModel});
}

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

class WorkDiariesUpdateByIdEvent extends WorkDiariesEvent {
  final String announcementId;

  WorkDiariesUpdateByIdEvent({required this.announcementId});
}
