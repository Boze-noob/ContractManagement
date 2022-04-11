import 'package:contract_management/_all.dart';

class WorkDiaryModel {
  final String id;
  final String announcementId;
  final String companyId;
  final String? projectName;
  final String? projectDescription;
  final String? interferences;
  final String? additionalRequirements;
  final String? specialCases;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime completionDateTime;
  final List<WorkingDayModel> workingDayModels;

  WorkDiaryModel({
    required this.id,
    required this.announcementId,
    required this.companyId,
    this.projectName,
    this.projectDescription,
    this.interferences,
    this.additionalRequirements,
    this.specialCases,
    required this.startDate,
    this.endDate,
    required this.completionDateTime,
    required this.workingDayModels,
  });

  WorkDiaryModel copyWith({
    String? id,
    String? announcementId,
    String? companyId,
    String? projectName,
    String? projectDescription,
    String? interferences,
    String? additionalRequirements,
    String? specialCases,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? completionDateTime,
    List<WorkingDayModel>? workingDayModels,
  }) =>
      WorkDiaryModel(
        id: id ?? this.id,
        announcementId: announcementId ?? this.announcementId,
        companyId: companyId ?? this.companyId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        completionDateTime: completionDateTime ?? this.completionDateTime,
        workingDayModels: workingDayModels ?? this.workingDayModels,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        interferences: interferences ?? this.interferences,
        additionalRequirements:
            additionalRequirements ?? this.additionalRequirements,
        specialCases: specialCases ?? this.specialCases,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'announcementId': announcementId,
      'companyId': companyId,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'interferences': interferences,
      'additionalRequirements': additionalRequirements,
      'specialCases': specialCases,
      'startDate': startDate.toUtc(),
      'endDate': endDate != null ? endDate!.toUtc() : null,
      'completionDateTime': completionDateTime.toUtc(),
      //TODO check this
      'workingDayModels':
          workingDayModels.map((items) => items.toMap()).toList(),
    };
  }

  factory WorkDiaryModel.fromMap(dynamic map) {
    return WorkDiaryModel(
      id: map['id'],
      announcementId: map['announcementId'],
      companyId: map['companyId'],
      projectName: map['projectName'],
      projectDescription: map['projectDescription'],
      interferences: map['interferences'],
      additionalRequirements: map['additionalRequirements'],
      specialCases: map['specialCases'],
      startDate: map['startDate'] != null ? map['startDate'].toDate() : null,
      endDate: map['endDate'] != null ? map['endDate'].toDate() : null,
      completionDateTime: map['completionDateTime'] != null
          ? map['completionDateTime'].toDate()
          : null,
      workingDayModels: map['workingDayModels']
          .map<WorkingDayModel>((item) => WorkingDayModel.fromMap(item))
          .toList(),
    );
  }
}
