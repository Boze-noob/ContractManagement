import 'package:contract_management/_all.dart';

class WorkDiaryModel {
  final String announcementId;
  final String? projectName;
  final String? projectDescription;
  final String? interferences;
  final String? additionalRequirements;
  final String? specialCases;
  final DateTime startDate;
  final DateTime endDate;
  final List<WorkingDayModel> workingDayModels;

  WorkDiaryModel({
    required this.announcementId,
    this.projectName,
    this.projectDescription,
    this.interferences,
    this.additionalRequirements,
    this.specialCases,
    required this.startDate,
    required this.endDate,
    required this.workingDayModels,
  });

  WorkDiaryModel copyWith({
    String? announcementId,
    String? projectName,
    String? projectDescription,
    String? interferences,
    String? additionalRequirements,
    String? specialCases,
    DateTime? startDate,
    DateTime? endDate,
    List<WorkingDayModel>? workingDayModels,
  }) =>
      WorkDiaryModel(
        announcementId: announcementId ?? this.announcementId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        workingDayModels: workingDayModels ?? this.workingDayModels,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        interferences: interferences ?? this.interferences,
        additionalRequirements: additionalRequirements ?? this.additionalRequirements,
        specialCases: specialCases ?? this.specialCases,
      );
}
