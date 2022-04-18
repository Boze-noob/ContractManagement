import 'package:contract_management/_all.dart';

abstract class BillEvent {}

class BillInitEvent extends BillEvent {
  final String price;
  final String announcementId;

  BillInitEvent({
    required this.price,
    required this.announcementId,
  });
}

class BillUpdateEvent extends BillEvent {
  final BillModel billModel;

  BillUpdateEvent({required this.billModel});
}

class BillSubmitEvent extends BillEvent {}

class BillGetSingleEvent extends BillEvent {
  final String announcementId;

  BillGetSingleEvent({required this.announcementId});
}

class BillGetAllEvent extends BillEvent {}
