import 'package:contract_management/_all.dart';

class ContractsModel {
  final String name;
  final String clientName;
  final String location;
  final String company;
  final ContractsType contractStatus;

  ContractsModel({
    required this.name,
    required this.clientName,
    required this.location,
    required this.company,
    required this.contractStatus,
  });

  ContractsModel copyWith({
    final String? name,
    final String? clientName,
    final String? location,
    final String? rate,
    final ContractsType? contractStatus,
  }) =>
      ContractsModel(
        name: name != null ? name : this.name,
        clientName: clientName != null ? clientName : this.clientName,
        location: location != null ? location : this.location,
        company: rate != null ? rate : this.company,
        contractStatus: contractStatus != null ? contractStatus : this.contractStatus,
      );

  factory ContractsModel.fromMap(dynamic map) {
    return ContractsModel(
      name: map['name'],
      clientName: map['clientName'],
      location: map['location'],
      company: map['company'],
      contractStatus: ContractsType.getValue(map['contractStatus']),
    );
  }
}
