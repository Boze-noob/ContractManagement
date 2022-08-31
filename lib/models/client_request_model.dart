import 'package:contract_management/_all.dart';

class ClientRequestModel {
  final String id;
  final String clientId;
  final String email;
  final String displayName;
  final RequestType requestType;
  final String description;
  final String location;
  final DateTime createdDateTime;
  final String? phoneNumber;

  ClientRequestModel({
    required this.id,
    required this.clientId,
    required this.email,
    required this.displayName,
    required this.requestType,
    required this.description,
    required this.location,
    required this.createdDateTime,
    this.phoneNumber,
  });

  ClientRequestModel copyWith({
    String? id,
    String? clientId,
    String? email,
    String? displayName,
    RequestType? requestType,
    String? description,
    String? location,
    DateTime? createdDateTime,
    String? phoneNumber,
  }) =>
      ClientRequestModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        requestType: requestType ?? this.requestType,
        description: description ?? this.description,
        location: location ?? this.location,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'email': email,
      'displayName': displayName,
      'requestType': requestType.index,
      'description': description,
      'location': location,
      'createdDateTime': createdDateTime.toUtc().toString(),
      'phoneNumber': phoneNumber
    };
  }

  factory ClientRequestModel.fromMap(dynamic map) {
    return ClientRequestModel(
      id: map['id'],
      clientId: map['clientId'],
      email: map['email'],
      displayName: map['displayName'],
      requestType: RequestType.getValue(map['requestType']),
      description: map['description'] ?? null,
      location: map['location'],
      createdDateTime: DateTime.parse(map['createdDateTime']),
      phoneNumber: map['phoneNumber'],
    );
  }
}
