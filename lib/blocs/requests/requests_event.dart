import 'package:contract_management/_all.dart';

abstract class RequestsEvent {}

class RequestsInitEvent extends RequestsEvent {}

class RequestsLoadEvent extends RequestsEvent {}

class RequestsDeleteEvent extends RequestsEvent {
  String id;

  RequestsDeleteEvent({required this.id});
}

class RequestsSortEvent extends RequestsEvent {
  final SortType sortType;

  RequestsSortEvent({required this.sortType});
}
