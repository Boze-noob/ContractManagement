class AdminRequestModel {
  final String displayName;
  final String email;
  final String? description;
  final String location;
  final String contractName;
  final List<int> contractItems;

  AdminRequestModel({
    required this.displayName,
    required this.email,
    this.description,
    required this.location,
    required this.contractName,
    required this.contractItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'description': description ?? null,
      'location': location,
      'contractName': contractName,
      'contractItems': contractItems,
    };
  }

  factory AdminRequestModel.fromMap(dynamic map) {
    return AdminRequestModel(
      displayName: map['displayName'],
      email: map['email'],
      description: map['description'],
      location: map['location'],
      contractName: map['contractName'],
      contractItems: map['contractItems'],
    );
  }
}
