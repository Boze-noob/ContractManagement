import 'package:contract_management/_all.dart';

class ClientRequestModel {
  final String clientId;
  final RequestType requestType;
  final String? description;
  final String location;
  final String createdDateTime;

  ClientRequestModel({
    required this.clientId,
    required this.requestType,
    this.description,
    required this.location,
    required this.createdDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'requestType': requestType,
      'description': description ?? null,
      'location': location,
      'createdDateTime': createdDateTime,
    };
  }

  factory ClientRequestModel.fromMap(dynamic map) {
    return ClientRequestModel(
      clientId: map['clientId'],
      requestType: map['requestType'],
      description: map['description'] ?? null,
      location: map['location'],
      createdDateTime: map['createdDateTime'],
    );
  }
}
