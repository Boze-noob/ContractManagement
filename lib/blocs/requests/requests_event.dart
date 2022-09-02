import 'package:contract_management/_all.dart';

abstract class RequestsEvent {}

class RequestsInitEvent extends RequestsEvent {}

class RequestsLoadEvent extends RequestsEvent {}

class RequestsDeleteEvent extends RequestsEvent {
  String id;

  RequestsDeleteEvent({required this.id});
}

class RequestsSortClientRequestsEvent extends RequestsEvent {
  final ClientRequestSortType sortType;

  RequestsSortClientRequestsEvent({required this.sortType});
}
