class ContractRequestModel {
  final String contractId;
  final String companyId;

  ContractRequestModel({required this.contractId, required this.companyId});

  ContractRequestModel copyWith({
    String? contractId,
    String? companyId,
  }) =>
      ContractRequestModel(
        contractId: contractId ?? this.contractId,
        companyId: companyId ?? this.companyId,
      );

  Map<String, dynamic> toMap() {
    return {
      'contractId': contractId,
      'companyId': companyId,
    };
  }

  factory ContractRequestModel.fromMap(dynamic map) {
    return ContractRequestModel(
      contractId: 'contractId',
      companyId: 'companyId',
    );
  }
}
