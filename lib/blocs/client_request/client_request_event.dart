import 'package:contract_management/_all.dart';

abstract class ClientRequestEvent {}

class ClientRequestInitEvent extends ClientRequestEvent {}

class ClientRequestInitUserDataEvent extends ClientRequestEvent {
  final String? phoneNumber;
  final String? location;

  ClientRequestInitUserDataEvent({required this.phoneNumber, required this.location});
}

class ClientRequestUpdateEvent extends ClientRequestEvent {
  final ClientRequestModel clientRequestModel;

  ClientRequestUpdateEvent({
    required this.clientRequestModel,
  });
}

class ClientRequestSubmitEvent extends ClientRequestEvent {}
