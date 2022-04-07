import 'package:contract_management/_all.dart';

abstract class IAnnouncement {
  Future<List<AnnouncementModel>?> getAnnouncements();
  Future<bool> createAnnouncement(AnnouncementModel announcementModel);
}

class AnnouncementRepo implements IAnnouncement {
  FirebaseFirestoreClass firebaseFirestoreClass;

  AnnouncementRepo({
    required this.firebaseFirestoreClass,
  });

  //TODO change to get by worker id)
  @override
  Future<List<AnnouncementModel>?> getAnnouncements() async {
    return await firebaseFirestoreClass.getAllDataFromCollection('announcement', null);
  }

  @override
  Future<bool> createAnnouncement(AnnouncementModel announcementModel) async {
    return await firebaseFirestoreClass.storeData('announcement', announcementModel.id, announcementModel.toMap());
  }
}
