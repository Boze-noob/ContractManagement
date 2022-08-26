abstract class RequestsEvent {}

class RequestsInitEvent extends RequestsEvent {}

class RequestsLoadEvent extends RequestsEvent {}

class RequestsDeleteEvent extends RequestsEvent {
  String id;

  RequestsDeleteEvent({required this.id});
}
