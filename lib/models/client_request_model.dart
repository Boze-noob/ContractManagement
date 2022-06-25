import 'package:contract_management/_all.dart';

class ClientRequestModel {
  final String clientId;
  final String email;
  final String displayName;
  final RequestType requestType;
  final String description;
  final String location;
  final DateTime createdDateTime;

  ClientRequestModel({
    required this.clientId,
    required this.email,
    required this.displayName,
    required this.requestType,
    required this.description,
    required this.location,
    required this.createdDateTime,
  });

  ClientRequestModel copyWith({
    String? clientId,
    String? email,
    String? displayName,
    RequestType? requestType,
    String? description,
    String? location,
    DateTime? createdDateTime,
  }) =>
      ClientRequestModel(
        clientId: clientId ?? this.clientId,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        requestType: requestType ?? this.requestType,
        description: description ?? this.description,
        location: location ?? this.location,
        createdDateTime: createdDateTime ?? this.createdDateTime,
      );

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'email': email,
      'displayName': displayName,
      'requestType': requestType.index,
      'description': description,
      'location': location,
      'createdDateTime': createdDateTime.toUtc().toString(),
    };
  }

  factory ClientRequestModel.fromMap(dynamic map) {
    return ClientRequestModel(
      clientId: map['clientId'],
      email: map['email'],
      displayName: map['displayName'],
      requestType: RequestType.getValue(map['requestType']),
      description: map['description'] ?? null,
      location: map['location'],
      createdDateTime: DateTime.parse(map['createdDateTime']),
    );
  }
}
