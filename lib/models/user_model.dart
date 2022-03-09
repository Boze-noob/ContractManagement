class UserModel {
  final String id;
  final String email;
  final String? password;
  final String displayName;
  final String? rating;
  final String? location;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    required this.displayName,
    this.rating,
    this.location,
    required this.role,
  });

  UserModel copyWith({
    final String? id,
    final String? email,
    final String? password,
    final String? displayName,
    final String? rating,
    final String? location,
    final String? role,
  }) =>
      UserModel(
        id: id != null ? id : this.id,
        email: email != null ? email : this.email,
        password: password != null ? password : this.password,
        displayName: displayName != null ? displayName : this.displayName,
        rating: rating != null ? rating : this.rating,
        location: location != null ? location : this.location,
        role: role != null ? role : this.role,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'rating': rating,
      'location': location,
      'role': role,
    };
  }

  factory UserModel.fromMap(dynamic map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      displayName: map['displayName'],
      rating: map['rating'],
      location: map['location'],
      role: map['role'],
    );
  }
}
