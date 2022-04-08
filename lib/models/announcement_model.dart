import 'package:contract_management/_all.dart';

class AnnouncementModel {
  final String id;
  final String orderId;
  final String? receiverId;
  final String? receiverName;
  final List<ContractItemsType> contractItems;
  final String price;
  final DateTime createdDateTime;
  final String employerName;
  final AnnouncementStatusType announcementStatusType;

  AnnouncementModel(
      {required this.id,
      required this.orderId,
      this.receiverId,
      this.receiverName,
      required this.contractItems,
      required this.price,
      required this.createdDateTime,
      required this.employerName,
      required this.announcementStatusType});

  AnnouncementModel copyWith({
    String? id,
    String? orderId,
    String? receiverId,
    String? receiverName,
    List<ContractItemsType>? contractItems,
    String? price,
    DateTime? createdDateTime,
    String? employerName,
    AnnouncementStatusType? announcementStatusType,
  }) =>
      AnnouncementModel(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        receiverId: receiverId ?? this.receiverId,
        receiverName: receiverName ?? this.receiverName,
        contractItems: contractItems ?? this.contractItems,
        price: price ?? this.price,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        employerName: employerName ?? this.employerName,
        announcementStatusType: announcementStatusType ?? this.announcementStatusType,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'contractItems': ContractItemsType.getIndexValueList(contractItems),
      'price': price,
      'createdDateTime': createdDateTime.toUtc(),
      'employerName': employerName,
      'announcementStatusType': announcementStatusType.index,
    };
  }

  factory AnnouncementModel.fromMap(dynamic map) {
    return AnnouncementModel(
      id: map['id'],
      orderId: map['orderId'],
      receiverId: map['receiverId'],
      receiverName: map['receiverName'],
      contractItems: ContractItemsType.getContractItemsFromIndexList(List<int>.from(map['contractItems'])),
      price: map['price'],
      createdDateTime: map['createdDateTime'] != null ? map['createdDateTime'].toDate() : null,
      employerName: map['employerName'],
      announcementStatusType: AnnouncementStatusType.getValue(map['announcementStatusType']),
    );
  }
}
