import 'package:contract_management/_all.dart';

//TODO I think that work details(location of client, name of client etc will be in announcement part
class OrderModel {
  final String? id;
  final String senderName;
  final String receiverName;
  final String orderLocation;
  final PaymentType paymentType;
  final DateTime createdDateTime;
  final DateTime sentDateTime;
  final List<ContractItemsType> contractItems;
  final String employerName;
  final OrderStatusType orderStatusType;
  final AdminRequestType adminRequestType;

  OrderModel({
    this.id,
    required this.senderName,
    required this.receiverName,
    required this.orderLocation,
    required this.paymentType,
    required this.createdDateTime,
    required this.sentDateTime,
    required this.contractItems,
    required this.employerName,
    required this.orderStatusType,
    required this.adminRequestType,
  });

  OrderModel copyWith({
    String? id,
    String? senderName,
    String? receiverName,
    String? orderLocation,
    PaymentType? paymentType,
    DateTime? createdDateTime,
    DateTime? sentDateTime,
    List<ContractItemsType>? contractItems,
    String? employerName,
    OrderStatusType? orderStatusType,
    AdminRequestType? adminRequestType,
  }) =>
      OrderModel(
        senderName: senderName ?? this.senderName,
        receiverName: receiverName ?? this.receiverName,
        orderLocation: orderLocation ?? this.orderLocation,
        paymentType: paymentType ?? this.paymentType,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        sentDateTime: sentDateTime ?? this.sentDateTime,
        contractItems: contractItems ?? this.contractItems,
        employerName: employerName ?? this.employerName,
        orderStatusType: orderStatusType ?? this.orderStatusType,
        adminRequestType: adminRequestType ?? this.adminRequestType,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': generateRandomId(),
      'senderName': senderName,
      'receiverName': receiverName,
      'orderLocation': orderLocation,
      'paymentType': paymentType.index,
      'createdDateTime': createdDateTime.toUtc(),
      'sentDateTime': sentDateTime.toUtc(),
      'contractItems': ContractItemsType.getIndexValueList(contractItems),
      'employerName': employerName,
      'orderStatusType': orderStatusType,
      'adminRequestType': adminRequestType,
    };
  }

  factory OrderModel.fromMap(dynamic map) {
    return OrderModel(
      id: map['id'],
      senderName: map['senderName'],
      receiverName: map['receiverName'],
      orderLocation: map['orderLocation'],
      paymentType: PaymentType.getValue(map['paymentType']),
      createdDateTime: map['createdDateTime'].toLocal(),
      sentDateTime: map['sentDateTime'].toLocal(),
      contractItems: ContractItemsType.getContractItemsFromIndexList(map['contractItems']),
      employerName: map['employerName'],
      orderStatusType: OrderStatusType.getValue(map['orderStatusType']),
      adminRequestType: AdminRequestType.getValue(map['adminRequestType']),
    );
  }
}

//This should be done on backend
String generateRandomId() {
  var uuid = Uuid();
  return uuid.v4();
}
