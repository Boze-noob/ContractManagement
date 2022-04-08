import 'package:contract_management/_all.dart';

abstract class IWorkDiaries {
  Future<List<WorkDiaryModel>?> getDiaries(String companyId);
  Future<bool> editDiary(WorkDiaryModel workDiaryModel);
  Future<bool> createDiary(WorkDiaryModel workDiaryModel);
}

class WorkDiaries implements IWorkDiaries {
  final FirebaseFirestoreClass firebaseFirestoreClass;

  WorkDiaries({required this.firebaseFirestoreClass});

  @override
  Future<bool> createDiary(WorkDiaryModel workDiaryModel) async {
    return await firebaseFirestoreClass.storeData('workDiaries', workDiaryModel.id, workDiaryModel.toMap());
  }

  @override
  Future<bool> editDiary(WorkDiaryModel workDiaryModel) async {
    return await firebaseFirestoreClass.storeData('workDiaries', workDiaryModel.id, workDiaryModel.toMap());
  }

  @override
  Future<List<WorkDiaryModel>?> getDiaries(String companyId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('workDiaries', 'companyId', companyId);
    return jsonData != null ? jsonData.map<WorkDiaryModel>((json) => WorkDiaryModel.fromMap(json))?.toList() : null;
  }
}
