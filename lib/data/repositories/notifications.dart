import 'package:contract_management/_all.dart';

abstract class INotifications {
  Future<bool> sendNotification(NotificationModel notificationModel);
  Future<List<NotificationModel>?> getNotifications(String userId);
  Future<String?> deleteNotifications(String userId);
}

class NotificationsRepo implements INotifications {
  final FirebaseFirestoreClass firebaseFirestoreClass;

  NotificationsRepo({required this.firebaseFirestoreClass});

  @override
  Future<List<NotificationModel>?> getNotifications(String userId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('notifications', 'userId', userId);
    return jsonData.map<NotificationModel>((json) => NotificationModel.fromMap(json))?.toList() ?? null;
  }

  @override
  Future<bool> sendNotification(NotificationModel notificationModel) async {
    final result = await firebaseFirestoreClass.storeData('notifications', null, notificationModel.toMap());
    return result;
  }

  @override
  Future<String?> deleteNotifications(String userId) async {
    return await firebaseFirestoreClass.deleteDataWithSpecificField('notifications', 'userId', userId);
  }
}
