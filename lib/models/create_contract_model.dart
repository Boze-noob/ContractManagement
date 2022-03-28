//TODO will we add dateTime??

class CreateContractModel {
  final String contractName;
  final String contractDescription;
  final List<int> contractItems;

  CreateContractModel({required this.contractName, required this.contractDescription, required this.contractItems});

  CreateContractModel copyWith({
    String? contractName,
    String? contractDescription,
    List<int>? contractItems,
  }) =>
      CreateContractModel(
        contractName: contractName ?? this.contractName,
        contractDescription: contractDescription ?? this.contractDescription,
        contractItems: contractItems ?? this.contractItems,
      );

  Map<String, dynamic> toMap() {
    return {
      'contractName': contractName,
      'contractDescription': contractDescription,
      'contractItems': contractItems,
    };
  }

  factory CreateContractModel.fromMap(dynamic map) {
    return CreateContractModel(
      contractName: map['contractName'],
      contractDescription: map['contractDescription'],
      contractItems: List<int>.from(map['contractItems']),
    );
  }
}
