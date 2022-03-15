import 'package:contract_management/_all.dart';

abstract class ClientRequestEvent {}

class ClientRequestInitEvent extends ClientRequestEvent {}

class ClientRequestUpdateEvent extends ClientRequestEvent {
  final ClientRequestModel clientRequestModel;

  ClientRequestUpdateEvent({
    required this.clientRequestModel,
  });
}

class ClientRequestSubmitEvent extends ClientRequestEvent {}
