import 'package:contract_management/_all.dart';

abstract class IAnnouncement {
  Future<List<AnnouncementModel>?> getAnnouncements();
  Future<bool> createAnnouncement(AnnouncementModel announcementModel);
  Future<String?> deleteAnnouncement(String announcementId);
  Future<String?> sendAnnouncement(String announcementId);
}

class AnnouncementRepo implements IAnnouncement {
  FirebaseFirestoreClass firebaseFirestoreClass;

  AnnouncementRepo({
    required this.firebaseFirestoreClass,
  });

  //TODO change to get by worker id)
  @override
  Future<List<AnnouncementModel>?> getAnnouncements() async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection('announcements', null);
    return jsonData != null
        ? jsonData.map<AnnouncementModel>((json) => AnnouncementModel.fromMap(json))?.toList()
        : jsonData;
  }

  @override
  Future<bool> createAnnouncement(AnnouncementModel announcementModel) async {
    return await firebaseFirestoreClass.storeData('announcements', announcementModel.id, announcementModel.toMap());
  }

  @override
  Future<String?> deleteAnnouncement(String announcementId) async {
    return await firebaseFirestoreClass.deleteData('announcements', announcementId);
  }

  @override
  Future<String?> sendAnnouncement(String announcementId) async {
    return await firebaseFirestoreClass.updateSpecificField(
        'announcements', announcementId, 'announcementStatusType', 1);
  }
}
