import 'package:contract_management/_all.dart';

class AnnouncementModel {
  final String id;
  final String orderId;
  final String? receiverId;
  final String? receiverName;
  final List<ContractItemsType> contractItems;
  final String price;
  final DateTime createdDateTime;
  final DateTime completionDateTime;
  final String employerName;
  final AnnouncementStatusType announcementStatusType;
  final String? declineComment;

  AnnouncementModel({
    required this.id,
    required this.orderId,
    this.receiverId,
    this.receiverName,
    required this.contractItems,
    required this.price,
    required this.createdDateTime,
    required this.completionDateTime,
    required this.employerName,
    required this.announcementStatusType,
    this.declineComment,
  });

  AnnouncementModel copyWith({
    String? id,
    String? orderId,
    String? receiverId,
    String? receiverName,
    List<ContractItemsType>? contractItems,
    String? price,
    DateTime? createdDateTime,
    DateTime? completionDateTime,
    DateTime? endDateTime,
    String? employerName,
    AnnouncementStatusType? announcementStatusType,
    String? declineComment,
  }) =>
      AnnouncementModel(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        receiverId: receiverId ?? this.receiverId,
        receiverName: receiverName ?? this.receiverName,
        contractItems: contractItems ?? this.contractItems,
        price: price ?? this.price,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        completionDateTime: completionDateTime ?? this.completionDateTime,
        employerName: employerName ?? this.employerName,
        announcementStatusType:
            announcementStatusType ?? this.announcementStatusType,
        declineComment: declineComment ?? this.declineComment,
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
      'completionDateTime': completionDateTime.toUtc(),
      'employerName': employerName,
      'announcementStatusType': announcementStatusType.index,
      'declineComment': declineComment,
    };
  }

  factory AnnouncementModel.fromMap(dynamic map) {
    return AnnouncementModel(
      id: map['id'],
      orderId: map['orderId'],
      receiverId: map['receiverId'],
      receiverName: map['receiverName'],
      contractItems: ContractItemsType.getContractItemsFromIndexList(
          List<int>.from(map['contractItems'])),
      price: map['price'],
      createdDateTime: map['createdDateTime'] != null
          ? map['createdDateTime'].toDate()
          : null,
      completionDateTime: map['completionDateTime'] != null
          ? map['completionDateTime'].toDate()
          : null,
      employerName: map['employerName'],
      announcementStatusType:
          AnnouncementStatusType.getValue(map['announcementStatusType']),
      declineComment: map['declineComment'] ?? null,
    );
  }
}
