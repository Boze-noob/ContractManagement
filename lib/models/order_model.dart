import 'package:contract_management/_all.dart';

//TODO I think that work details(location of client, name of client etc will be in announcement part
class OrderModel {
  final String id;
  final String senderName;
  final String? receiverName;
  final String? receiverId;
  final String orderLocation;
  final PaymentType paymentType;
  final DateTime createdDateTime;
  final DateTime completionDateTime;
  final DateTime? sentDateTime;
  final List<ContractItemsType> contractItems;
  final String employerName;
  final OrderStatusType orderStatusType;
  final AdminRequestType adminRequestType;
  final String clientName;
  final String price;
  final String description;
  final String? clientPhoneNumber;

  OrderModel({
    required this.id,
    required this.senderName,
    this.receiverName,
    this.receiverId,
    required this.orderLocation,
    required this.paymentType,
    required this.createdDateTime,
    required this.completionDateTime,
    this.sentDateTime,
    required this.contractItems,
    required this.employerName,
    required this.orderStatusType,
    required this.adminRequestType,
    required this.clientName,
    required this.price,
    required this.description,
    this.clientPhoneNumber,
  });

  OrderModel copyWith({
    String? id,
    String? senderName,
    String? receiverName,
    String? receiverId,
    String? orderLocation,
    PaymentType? paymentType,
    DateTime? createdDateTime,
    DateTime? sentDateTime,
    DateTime? completionDateTime,
    List<ContractItemsType>? contractItems,
    String? employerName,
    OrderStatusType? orderStatusType,
    AdminRequestType? adminRequestType,
    String? clientName,
    String? price,
    String? description,
    String? clientPhoneNumber,
  }) =>
      OrderModel(
        id: id ?? this.id,
        senderName: senderName ?? this.senderName,
        receiverName: receiverName ?? this.receiverName,
        receiverId: receiverId ?? this.receiverId,
        orderLocation: orderLocation ?? this.orderLocation,
        paymentType: paymentType ?? this.paymentType,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        sentDateTime: sentDateTime ?? this.sentDateTime,
        completionDateTime: completionDateTime ?? this.completionDateTime,
        contractItems: contractItems ?? this.contractItems,
        employerName: employerName ?? this.employerName,
        orderStatusType: orderStatusType ?? this.orderStatusType,
        adminRequestType: adminRequestType ?? this.adminRequestType,
        clientName: clientName ?? this.clientName,
        price: price ?? this.price,
        description: description ?? this.description,
        clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderName': senderName,
      'receiverName': receiverName,
      'receiverId': receiverId,
      'orderLocation': orderLocation,
      'paymentType': paymentType.index,
      'createdDateTime': createdDateTime.toUtc(),
      'sentDateTime': sentDateTime != null ? sentDateTime!.toUtc() : null,
      'completionDateTime': completionDateTime != null ? completionDateTime.toUtc() : null,
      'contractItems': ContractItemsType.getIndexValueList(contractItems),
      'employerName': employerName,
      'orderStatusType': orderStatusType.index,
      'adminRequestType': adminRequestType.index,
      'clientName': clientName,
      'price': price,
      'description': description,
      'clientPhoneNumber': clientPhoneNumber,
    };
  }

  factory OrderModel.fromMap(dynamic map) {
    return OrderModel(
      id: map['id'],
      senderName: map['senderName'],
      receiverName: map['receiverName'],
      receiverId: map['receiverId'] ?? null,
      orderLocation: map['orderLocation'],
      paymentType: PaymentType.getValue(map['paymentType']),
      createdDateTime: map['createdDateTime'] != null ? map['createdDateTime'].toDate() : null,
      completionDateTime: map['completionDateTime'] != null ? map['completionDateTime'].toDate() : null,
      contractItems: ContractItemsType.getContractItemsFromIndexList(List<int>.from(map['contractItems'])),
      employerName: map['employerName'],
      orderStatusType: OrderStatusType.getValue(map['orderStatusType']),
      adminRequestType: AdminRequestType.getValue(map['adminRequestType']),
      clientName: map['clientName'],
      price: map['price'],
      description: map['description'],
      sentDateTime: map['sentDateTime'] != null ? map['sentDateTime'].toDate() : null,
      clientPhoneNumber: map['clientPhoneNumber'],
    );
  }
}
