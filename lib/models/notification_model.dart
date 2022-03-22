class NotificationModel {
  final String userId;
  final String message;

  NotificationModel({required this.userId, required this.message});

  NotificationModel copyWith({
    final String? userId,
    final String? message,
  }) =>
      NotificationModel(userId: userId ?? this.userId, message: message ?? this.message);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
    };
  }

  factory NotificationModel.fromMap(dynamic map) {
    return NotificationModel(
      userId: map['userId'],
      message: map['message'],
    );
  }
}
