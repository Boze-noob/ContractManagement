import 'package:contract_management/_all.dart';

class ContractsModel {
  final String name;
  final String description;
  final String clientName;
  final String location;
  final String company;
  final ContractType contractStatus;

  ContractsModel({
    required this.name,
    required this.description,
    required this.clientName,
    required this.location,
    required this.company,
    required this.contractStatus,
  });

  ContractsModel copyWith({
    final String? name,
    final String? description,
    final String? clientName,
    final String? location,
    final String? rate,
    final ContractType? contractStatus,
  }) =>
      ContractsModel(
        name: name != null ? name : this.name,
        description: description != null ? description : this.description,
        clientName: clientName != null ? clientName : this.clientName,
        location: location != null ? location : this.location,
        company: rate != null ? rate : this.company,
        contractStatus: contractStatus != null ? contractStatus : this.contractStatus,
      );

  factory ContractsModel.fromMap(dynamic map) {
    return ContractsModel(
      name: map['name'],
      description: map['description'],
      clientName: map['clientName'],
      location: map['location'],
      company: map['company'],
      contractStatus: ContractType.getValue(map['contractStatus']),
    );
  }
}
