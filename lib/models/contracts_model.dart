import 'package:contract_management/_all.dart';

class ContractsModel {
  final String name;
  final String location;
  final String rate;
  final ContractsType contractStatus;

  ContractsModel({
    required this.name,
    required this.location,
    required this.rate,
    required this.contractStatus,
  });

  ContractsModel copyWith({
    final String? name,
    final String? location,
    final String? rate,
    final ContractsType? contractStatus,
  }) =>
      ContractsModel(
        name: name != null ? name : this.name,
        location: location != null ? location : this.location,
        rate: rate != null ? rate : this.rate,
        contractStatus:
            contractStatus != null ? contractStatus : this.contractStatus,
      );
}
