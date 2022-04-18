class BillModel {
  String id;
  String price;
  String? additionalReqPrice;
  String announcementId;

  BillModel({
    required this.id,
    required this.price,
    this.additionalReqPrice,
    required this.announcementId,
  });

  BillModel copyWith({
    String? id,
    String? price,
    String? additionalReqPrice,
    String? announcementId,
  }) =>
      BillModel(
        id: id ?? this.id,
        price: price ?? this.price,
        additionalReqPrice: additionalReqPrice ?? this.additionalReqPrice,
        announcementId: announcementId ?? this.announcementId,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'additionalReqPrice': additionalReqPrice,
      'announcementId': announcementId,
    };
  }

  factory BillModel.fromMap(dynamic map) {
    print('we enter in from map part');
    return BillModel(
      id: map['id'],
      price: map['price'],
      additionalReqPrice: map['additionalReqPrice'],
      announcementId: map['announcementId'],
    );
  }
}
