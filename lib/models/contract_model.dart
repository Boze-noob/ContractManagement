import 'package:contract_management/_all.dart';

//TODO will we add dateTime??
class ContractModel {
  final String companyName;
  final String contractTemplateId;
  final String companyId;
  final ContractType contractStatus;

  ContractModel({
    required this.companyName,
    required this.contractTemplateId,
    required this.companyId,
    required this.contractStatus,
  });

  ContractModel copyWith({
    final String? companyName,
    final String? contractTemplateId,
    final String? companyId,
    final ContractType? contractStatus,
  }) =>
      ContractModel(
        companyName: companyName != null ? companyName : this.companyName,
        contractTemplateId: contractTemplateId != null ? contractTemplateId : this.contractTemplateId,
        companyId: companyId != null ? companyId : this.companyId,
        contractStatus: contractStatus != null ? contractStatus : this.contractStatus,
      );

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'contractTemplateId': contractTemplateId,
      'companyId': companyId,
      'contractStatus': contractStatus.index,
    };
  }

  factory ContractModel.fromMap(dynamic map) {
    return ContractModel(
      companyName: map['companyName'],
      contractTemplateId: map['contractTemplateId'],
      companyId: map['companyId'],
      contractStatus: ContractType.getValue(map['contractStatus']),
    );
  }
}
