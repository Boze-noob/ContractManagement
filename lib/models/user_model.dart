class UserModel {
  final String id;
  final String email;
  final String? password;
  final String displayName;
  final String? phoneNumber;
  final String? rating;
  final String? location;
  final String role;
  final String? contractId;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    required this.displayName,
    this.phoneNumber,
    this.rating,
    this.location,
    required this.role,
    this.contractId,
  });

  UserModel copyWith({
    final String? id,
    final String? email,
    final String? password,
    final String? displayName,
    final String? phoneNumber,
    final String? rating,
    final String? location,
    final String? role,
    final String? contractId,
  }) =>
      UserModel(
        id: id != null ? id : this.id,
        email: email != null ? email : this.email,
        password: password != null ? password : this.password,
        displayName: displayName != null ? displayName : this.displayName,
        phoneNumber: phoneNumber != null ? phoneNumber : this.phoneNumber,
        rating: rating != null ? rating : this.rating,
        location: location != null ? location : this.location,
        role: role != null ? role : this.role,
        contractId: contractId != null ? contractId : this.contractId,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber ?? null,
      'rating': rating ?? null,
      'location': location ?? null,
      'role': role,
      'contractId': contractId ?? null,
    };
  }

  factory UserModel.fromMap(dynamic map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'] ?? null,
      rating: map['rating'] ?? null,
      location: map['location'] ?? null,
      role: map['role'],
      contractId: map['contractId'] ?? null,
    );
  }
}
