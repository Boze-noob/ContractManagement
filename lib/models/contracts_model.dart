import 'package:contract_management/_all.dart';

class ContractsModel {
  final String name;
  final String description;
  final String companyName;
  final ContractType contractStatus;
  final String companyId;
  final String contractId;

  ContractsModel({
    required this.name,
    required this.description,
    required this.companyName,
    required this.contractStatus,
    required this.companyId,
    required this.contractId,
  });

  ContractsModel copyWith({
    final String? name,
    final String? description,
    final String? companyName,
    final ContractType? contractStatus,
    final String? companyId,
    final String? contractId,
  }) =>
      ContractsModel(
        name: name != null ? name : this.name,
        description: description != null ? description : this.description,
        companyName: companyName != null ? companyName : this.companyName,
        contractStatus: contractStatus != null ? contractStatus : this.contractStatus,
        companyId: companyId != null ? companyId : this.companyId,
        contractId: contractId != null ? contractId : this.contractId,
      );

  factory ContractsModel.fromMap(dynamic map) {
    return ContractsModel(
      name: map['name'],
      description: map['description'],
      companyName: map['company'],
      contractStatus: ContractType.getValue(map['contractStatus']),
      companyId: map['companyId'],
      contractId: map['contractId'],
    );
  }
}
