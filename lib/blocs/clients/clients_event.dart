abstract class ClientsEvent {}

class ClientsInitEvent extends ClientsEvent {}

class ClientsLoadEvent extends ClientsEvent {}

class ClientsAddEvent extends ClientsEvent {}

class ClientsDeleteEvent extends ClientsEvent {
  String clientId;

  ClientsDeleteEvent({required this.clientId});
}
