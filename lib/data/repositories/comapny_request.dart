import 'package:contract_management/_all.dart';

abstract class ICompanyRequest {
  Future<List<OrderModel>?> getOrders(String receiverId);
  Future<String?> editOrder(OrderStatusType orderStatusType, String orderId);
  Future<List<AnnouncementModel>?> getAnnouncements(String receiverId);
  Future<String?> editAnnouncement(AnnouncementStatusType announcementStatusType, String announcementId);

  Future<List<ClientRequestModel>?> getRequests(String collection, String sortFieldName);
}

class CompanyRequestRepo implements ICompanyRequest {
  FirebaseFirestoreClass firebaseFirestoreClass;

  CompanyRequestRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ClientRequestModel>?> getRequests(String collection, String sortFieldName) async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection(collection, sortFieldName);
    return jsonData.map<ClientRequestModel>((json) => ClientRequestModel.fromMap(json))?.toList() ?? jsonData;
  }

  @override
  Future<String?> editOrder(OrderStatusType orderStatusType, String orderId) async {
    final result =
        await firebaseFirestoreClass.updateSpecificField('orders', orderId, 'orderStatusType', orderStatusType.index);
    return result;
  }

  @override
  Future<List<OrderModel>?> getOrders(String receiverId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('orders', 'receiverId', receiverId);
    return jsonData != null ? jsonData.map<OrderModel>((json) => OrderModel.fromMap(json))?.toList() : null;
  }

  @override
  Future<List<AnnouncementModel>?> getAnnouncements(String receiverId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('announcements', 'receiverId', receiverId);
    return jsonData != null
        ? jsonData.map<AnnouncementModel>((json) => AnnouncementModel.fromMap(json))?.toList()
        : null;
  }

  @override
  Future<String?> editAnnouncement(AnnouncementStatusType announcementStatusType, String announcementId) async {
    final result = await firebaseFirestoreClass.updateSpecificField(
        'announcements', announcementId, 'announcementStatusType', announcementStatusType.index);
    return result;
  }
}
