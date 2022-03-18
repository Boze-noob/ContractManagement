class ContractRequestModel {
  final String contractId;
  final String companyId;
  final String message;

  ContractRequestModel({
    required this.contractId,
    required this.companyId,
    required this.message,
  });

  ContractRequestModel copyWith({
    String? contractId,
    String? companyId,
    String? message,
  }) =>
      ContractRequestModel(
        contractId: contractId ?? this.contractId,
        companyId: companyId ?? this.companyId,
        message: message ?? this.message,
      );

  Map<String, dynamic> toMap() {
    return {
      'contractId': contractId,
      'companyId': companyId,
      'message': message,
    };
  }

  factory ContractRequestModel.fromMap(dynamic map) {
    return ContractRequestModel(
      contractId: 'contractId',
      companyId: 'companyId',
      message: 'message',
    );
  }
}
