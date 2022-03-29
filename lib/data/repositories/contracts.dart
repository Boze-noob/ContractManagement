import 'dart:io';

import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

abstract class IContracts {
  Future<List<ContractModel>?> loadContracts(ContractType contractStatus);
  Future<ContractsCounterModel?> loadContractsCount();
  Future<bool> createActiveContract(ContractModel contractModel);
  Future<String?> completeContract(ContractModel contractModel);
  Future<String?> terminateContract(ContractModel contractModel, String userRoleType);

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
  INotifications notificationsRepo;

  ContractsRepo({
    required this.firebaseFirestoreClass,
    required this.notificationsRepo,
  });

  @override
  Future<List<ContractModel>?> loadContracts(ContractType contractStatus) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(
      'contracts',
      'contractStatus',
      contractStatus.index,
    );
    return jsonData != null ? jsonData.map<ContractModel>((json) => ContractModel.fromMap(json))?.toList() : null;
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

  @override
  Future<String?> completeContract(ContractModel contractModel) async {
    List<String> fieldNames = [
      'contractId',
      'contractSignature',
    ];
    List fieldValues = List.filled(2, null);
    //All admins will receive this notification
    await notificationsRepo.sendNotification(NotificationModel(userId: 'admin', message: 'Contract has been expired'));
    await notificationsRepo.sendNotification(NotificationModel(userId: contractModel.companyId, message: 'Contract has been expired'));
    await firebaseFirestoreClass.updaterSpecificFields('users', contractModel.companyId, fieldNames, fieldValues);
    return await firebaseFirestoreClass.updateSpecificField('contracts', contractModel.companyId, 'contractStatus', ContractType.completed.index);
  }

  @override
  Future<String?> terminateContract(ContractModel contractModel, String userRoleType) async {
    if (userRoleType == RoleType.admin.translate())
      await notificationsRepo.sendNotification(NotificationModel(userId: contractModel.companyId, message: 'Admin terminated your contract'));
    else
      await notificationsRepo.sendNotification(NotificationModel(userId: 'admin', message: 'Company ${contractModel.companyName} terminated its contract'));

    List<String> fieldNames = [
      'contractId',
      'contractSignature',
    ];
    List fieldValues = List.filled(2, null);
    await firebaseFirestoreClass.updaterSpecificFields('users', contractModel.companyId, fieldNames, fieldValues);
    return await firebaseFirestoreClass.updateSpecificField('contracts', contractModel.companyId, 'contractStatus', ContractType.terminated.index);
  }
}
