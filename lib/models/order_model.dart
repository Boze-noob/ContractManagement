import 'package:contract_management/_all.dart';

//TODO I think that work details(location of client, name of client etc will be in announcement part
class OrderModel {
  final String? id;
  final String senderName;
  final String? receiverName;
  final String orderLocation;
  final PaymentType paymentType;
  final DateTime createdDateTime;
  final DateTime? sentDateTime;
  final List<ContractItemsType> contractItems;
  final String employerName;
  final OrderStatusType orderStatusType;
  final AdminRequestType adminRequestType;
  final String clientName;

  OrderModel({
    this.id,
    required this.senderName,
    this.receiverName,
    required this.orderLocation,
    required this.paymentType,
    required this.createdDateTime,
    this.sentDateTime,
    required this.contractItems,
    required this.employerName,
    required this.orderStatusType,
    required this.adminRequestType,
    required this.clientName,
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
    String? clientName,
  }) =>
      OrderModel(
        id: id ?? this.id,
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
        clientName: clientName ?? this.clientName,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderName': senderName,
      'receiverName': receiverName,
      'orderLocation': orderLocation,
      'paymentType': paymentType.index,
      'createdDateTime': createdDateTime.toUtc(),
      'sentDateTime': sentDateTime != null ? sentDateTime!.toUtc() : null,
      'contractItems': ContractItemsType.getIndexValueList(contractItems),
      'employerName': employerName,
      'orderStatusType': orderStatusType.index,
      'adminRequestType': adminRequestType.index,
      'clientName': clientName,
    };
  }

  factory OrderModel.fromMap(dynamic map) {
    return OrderModel(
      id: map['id'],
      senderName: map['senderName'],
      receiverName: map['receiverName'],
      orderLocation: map['orderLocation'],
      paymentType: PaymentType.getValue(map['paymentType']),
      createdDateTime: map['createdDateTime'] != null ? map['createdDateTime'].toDate() : null,
      sentDateTime: map['sentDateTime'] != null ? map['sentDateTime'].toDate() : null,
      contractItems: ContractItemsType.getContractItemsFromIndexList(List<int>.from(map['contractItems'])),
      employerName: map['employerName'],
      orderStatusType: OrderStatusType.getValue(map['orderStatusType']),
      adminRequestType: AdminRequestType.getValue(map['adminRequestType']),
      clientName: map['clientName'],
    );
  }
}
