class UserModel {
  final String id;
  final String email;
  final String password;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
  });

  UserModel copyWith({
    final String? id,
    final String? email,
    final String? password,
    final String? role,
  }) =>
      UserModel(
        id: id != null ? id : this.id,
        email: email != null ? email : this.email,
        password: password != null ? password : this.password,
        role: role != null ? role : this.role,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
