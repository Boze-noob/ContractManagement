import 'dart:ui';

abstract class MyContractEvent {}

class MyContractInitEvent extends MyContractEvent {}

class MyContractGetCurrentEvent extends MyContractEvent {
  final String? contractId;

  MyContractGetCurrentEvent({this.contractId});
}

class MyContractGetRequestEvent extends MyContractEvent {
  final String companyId;

  MyContractGetRequestEvent({required this.companyId});
}

class MyContractAcceptRequestEvent extends MyContractEvent {
  final String companyId;
  final String contractId;
  final Image signatureImg;

  MyContractAcceptRequestEvent({
    required this.companyId,
    required this.contractId,
    required this.signatureImg,
  });
}
