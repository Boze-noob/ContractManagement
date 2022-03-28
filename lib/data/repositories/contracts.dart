import 'package:contract_management/_all.dart';

abstract class IContracts {
  Future<List<ContractModel>?> loadContracts(ContractType contractStatus);
  Future<ContractsCounterModel?> loadContractsCount();
  Future<bool> createActiveContract(ContractModel contractModel);

  Future<List<CreateContractModel>?> loadContractsTemplates();
  Future<CreateContractModel?> loadSingleContractTemplate(String contractDisplayName);
  Future<bool> createContractTemplate(CreateContractModel createContractModel);
  Future<String?> deleteContractTemplate(String contractName);

  Future<String?> deleteContractRequest(String companyId);
  Future<bool> sendContractRequest(ContractRequestModel contractRequestModel);
  Future<ContractRequestModel?> getContractRequest(String companyId);
  Future<CreateContractModel?> getCurrentActive(String contractId);
  Future<String?> acceptContract(String companyId, String contractId, String signature);
}

class ContractsRepo implements IContracts {
  FirebaseFirestoreClass firebaseFirestoreClass;

  ContractsRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ContractModel>?> loadContracts(ContractType contractStatus) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(
      'contracts',
      'contractStatus',
      contractStatus.index,
    );
    return jsonData.map<ContractModel>((json) => ContractModel.fromMap(json))?.toList() ?? null;
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
  Future<bool> createActiveContract(ContractModel contractModel) async {
    return await firebaseFirestoreClass.storeData('contracts', contractModel.companyId, contractModel.toMap());
  }

  @override
  Future<bool> createContractTemplate(CreateContractModel createContractModel) async {
    //Better practice is to let firebase to create document uid but for simplicity I will use contractName
    return await firebaseFirestoreClass.storeData('contractTemplates', createContractModel.contractName, createContractModel.toMap());
  }

  @override
  Future<List<CreateContractModel>?> loadContractsTemplates() async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection('contractTemplates', null);
    return jsonData.map<CreateContractModel>((json) => CreateContractModel.fromMap(json))?.toList() ?? jsonData;
  }

  @override
  Future<String?> deleteContractTemplate(String contractName) {
    return firebaseFirestoreClass.deleteData('contractTemplates', contractName);
  }

  @override
  Future<bool> sendContractRequest(ContractRequestModel contractRequestModel) async {
    return await firebaseFirestoreClass.storeData('contractRequests', contractRequestModel.companyId, contractRequestModel.toMap());
  }

  @override
  Future<ContractRequestModel?> getContractRequest(String companyId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('contractRequests', 'companyId', companyId);
    if (jsonData != null) {
      var list = jsonData.map<ContractRequestModel>((json) => ContractRequestModel.fromMap(json))?.toList() ?? null;
      return list != null ? list[0] : null;
    } else
      return null;
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

  @override
  Future<CreateContractModel?> getCurrentActive(String contractId) async {
    final result = await firebaseFirestoreClass.getData('contractTemplates', contractId);
    return result != null ? CreateContractModel.fromMap(result) : null;
  }

  @override
  Future<String?> acceptContract(String companyId, String contractId, String signature) async {
    List<String> fieldNames = [
      'contractId',
      'contractSignature',
    ];
    List<String> fieldValues = [contractId, signature];

    return await firebaseFirestoreClass.updaterSpecificFields('users', companyId, fieldNames, fieldValues);
  }
}
