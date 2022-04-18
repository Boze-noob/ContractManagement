import 'package:contract_management/_all.dart';

abstract class IBill {
  Future<List<BillModel>?> getBills();
  Future<BillModel?> getBill(String id);
  Future<bool> submitBill(BillModel billModel);
}

class BillRepo implements IBill {
  final FirebaseFirestoreClass firebaseFirestoreClass;

  BillRepo({required this.firebaseFirestoreClass});

  @override
  Future<BillModel> getBill(String id) async {
    print('usli smo u repo');
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('bills', 'announcementId', id);
    print('action ended in repo');
    return jsonData != null ? BillModel.fromMap(jsonData) : jsonData;
  }

  @override
  Future<List<BillModel>?> getBills() async {
    return await firebaseFirestoreClass.getAllDataFromCollection('bills', null);
  }

  @override
  Future<bool> submitBill(BillModel billModel) async {
    BillModel model = billModel.copyWith(id: generateRandomId());
    return await firebaseFirestoreClass.storeData('bills', model.id, model.toMap());
  }
}
