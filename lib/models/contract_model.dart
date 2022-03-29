import 'package:contract_management/_all.dart';

class ContractModel {
  final String companyName;
  final String contractTemplateId;
  final String companyId;
  final ContractType contractStatus;
  final DateTime completionDateTime;

  ContractModel({
    required this.companyName,
    required this.contractTemplateId,
    required this.companyId,
    required this.contractStatus,
    required this.completionDateTime,
  });

  ContractModel copyWith({
    final String? companyName,
    final String? contractTemplateId,
    final String? companyId,
    final ContractType? contractStatus,
    final DateTime? completionDateTime,
  }) =>
      ContractModel(
        companyName: companyName != null ? companyName : this.companyName,
        contractTemplateId: contractTemplateId != null ? contractTemplateId : this.contractTemplateId,
        companyId: companyId != null ? companyId : this.companyId,
        contractStatus: contractStatus != null ? contractStatus : this.contractStatus,
        completionDateTime: completionDateTime != null ? completionDateTime : this.completionDateTime,
      );

  Map<String, dynamic> toMap() {
    DateTime now = DateTime.now();
    DateTime completionDate = DateTime(now.year, now.month + 1, now.day);

    return {
      'companyName': companyName,
      'contractTemplateId': contractTemplateId,
      'companyId': companyId,
      'contractStatus': contractStatus.index,
      'completionDateTime': completionDate,
    };
  }

  factory ContractModel.fromMap(dynamic map) {
    return ContractModel(
      companyName: map['companyName'],
      contractTemplateId: map['contractTemplateId'],
      companyId: map['companyId'],
      contractStatus: ContractType.getValue(map['contractStatus']),
      completionDateTime: map['completionDateTime'].toDate(),
    );
  }
}
