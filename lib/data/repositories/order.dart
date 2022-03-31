import 'package:contract_management/_all.dart';

abstract class IOrder {
  Future<bool> createOrder(OrderModel orderModel);
  Future<String?> sendOrder(String orderId, String companyId);
  Future<String?> deleteOrder(String orderId);
  Future<bool?> editOrder(OrderModel orderModel);
  Future<List<OrderModel>?> getOrders();
}

class OrderRepo implements IOrder {
  final FirebaseFirestoreClass firebaseFirestoreClass;
  final INotifications notificationsRepo;

  OrderRepo({
    required this.firebaseFirestoreClass,
    required this.notificationsRepo,
  });

  @override
  Future<bool> createOrder(OrderModel orderModel) async {
    return await firebaseFirestoreClass.storeData('orders', orderModel.id, orderModel.toMap());
  }

  @override
  Future<String?> deleteOrder(String orderId) async {
    return await firebaseFirestoreClass.deleteData('orders', orderId);
  }

  @override
  Future<bool?> editOrder(OrderModel orderModel) async {
    return await firebaseFirestoreClass.storeData('orders', orderModel.id, orderModel.toMap());
  }

  @override
  Future<List<OrderModel>?> getOrders() async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection('orders', null);
    return jsonData != null ? jsonData.map<OrderModel>((json) => OrderModel.fromMap(json))?.toList() : jsonData;
  }

  @override
  Future<String?> sendOrder(String orderId, String companyId) async {
    await notificationsRepo.sendNotification(NotificationModel(userId: companyId, message: 'You have new order request'));
    return await firebaseFirestoreClass.updateSpecificField('orders', orderId, 'receiverName', companyId);
  }
}
