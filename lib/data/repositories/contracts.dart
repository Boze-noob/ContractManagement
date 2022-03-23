import 'package:contract_management/_all.dart';

abstract class IContracts {
  Future<List<ContractsModel>?> load(ContractType contractStatus);
  Future<List<CreateContractModel>?> loadContractsTemplates();
  Future<CreateContractModel?> loadSingleContractTemplate(String contractDisplayName);
  Future<ContractsCounterModel?> loadContractsCount();
  Future<bool> storeDate(CreateContractModel createContractModel);
  Future<String?> deleteContract(String contractName);
  Future<String?> deleteContractRequest(String companyId);
  Future<bool> sendContractRequest(ContractRequestModel contractRequestModel);
  Future<ContractRequestModel?> getContractRequest(String companyId);
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

  @override
  Future<bool> storeDate(CreateContractModel createContractModel) async {
    //Better practice is to let firebase to create document uid but for simplicity I will use contractName
    return await firebaseFirestoreClass.storeData('contractTemplates', createContractModel.contractName, createContractModel.toMap());
  }

  @override
  Future<List<CreateContractModel>?> loadContractsTemplates() async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection('contractTemplates', null);
    return jsonData.map<CreateContractModel>((json) => CreateContractModel.fromMap(json))?.toList() ?? jsonData;
  }

  @override
  Future<String?> deleteContract(String contractName) {
    return firebaseFirestoreClass.deleteData('contractTemplates', contractName);
  }

  @override
  Future<bool> sendContractRequest(ContractRequestModel contractRequestModel) async {
    return await firebaseFirestoreClass.storeData('contractRequests', contractRequestModel.companyId, contractRequestModel.toMap());
  }

  @override
  Future<ContractRequestModel?> getContractRequest(String companyId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('contractRequests', 'companyId', companyId);
    var list = jsonData.map<ContractRequestModel>((json) => ContractRequestModel.fromMap(json))?.toList() ?? null;
    return list[0];
  }

  @override
  Future<CreateContractModel?> loadSingleContractTemplate(String contractDisplayName) async {
    final jsonData = await firebaseFirestoreClass.getData('contractTemplates', contractDisplayName);
    return CreateContractModel.fromMap(jsonData);
  }

  @override
  Future<String?> deleteContractRequest(String companyId) async {
    return await firebaseFirestoreClass.deleteData('contractRequests', companyId);
  }
}
