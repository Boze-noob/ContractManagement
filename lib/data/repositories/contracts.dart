import 'package:contract_management/_all.dart';

abstract class IContracts {
  Future<List<ContractsModel>?> load(ContractsType contractStatus);
}

class ContractsRepo implements IContracts {
  FirebaseFirestoreClass firebaseFirestoreClass;

  ContractsRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ContractsModel>?> load(ContractsType contractStatus) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(
      'contracts',
      'contractStatus',
      contractStatus.index,
    );
    return jsonData.map<ContractsModel>((json) => ContractsModel.fromMap(json))?.toList() ?? null;
  }
}
