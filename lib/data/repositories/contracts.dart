import 'package:contract_management/_all.dart';

abstract class IContracts {
  Future<List<ContractsModel>?> load(ContractType contractStatus);
  Future<ContractsCounterModel?> loadContractsCount();
}

class ContractsRepo implements IContracts {
  FirebaseFirestoreClass firebaseFirestoreClass;

  ContractsRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ContractsModel>?> load(ContractType contractStatus) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(
      'contracts',
      'contractStatus',
      contractStatus.index,
    );
    return jsonData.map<ContractsModel>((json) => ContractsModel.fromMap(json))?.toList() ?? null;
  }

  @override
  Future<ContractsCounterModel?> loadContractsCount() async {
    try {
      ContractsCounterModel contractsCounterModel = ContractsCounterModel(
        active: await firebaseFirestoreClass.getNumberOfSpecificField('contracts', 'contractStatus', ContractType.active.index),
        completed: await firebaseFirestoreClass.getNumberOfSpecificField('contracts', 'contractStatus', ContractType.completed.index),
        terminated: await firebaseFirestoreClass.getNumberOfSpecificField('contracts', 'contractStatus', ContractType.terminated.index),
        requests: await firebaseFirestoreClass.getNumberOfSpecificField('contracts', 'contractStatus', ContractType.request.index),
      );
      return contractsCounterModel;
    } catch (e) {
      return null;
    }
  }
}
