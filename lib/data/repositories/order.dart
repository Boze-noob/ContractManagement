import 'package:contract_management/_all.dart';

abstract class IOrder {
  Future<bool> createOrder(OrderModel orderModel);
  Future<String?> sendOrder(String orderId, String receiverId, String receiverName);
  Future<String?> deleteOrder(String orderId);
  Future<bool> editOrder(OrderModel orderModel);
  Future<List<OrderModel>?> getOrders();
  Future<Map?> getCompanies(List<int> contractItems);
}

class OrderRepo implements IOrder {
  final FirebaseFirestoreClass firebaseFirestoreClass;
  final INotifications notificationsRepo;
  final IContracts contractsRepo;
  final ICompanies companiesRepo;

  OrderRepo({
    required this.firebaseFirestoreClass,
    required this.notificationsRepo,
    required this.contractsRepo,
    required this.companiesRepo,
  });

  @override
  Future<bool> createOrder(OrderModel orderModel) async {
    return await firebaseFirestoreClass.storeData('orders', orderModel.id, orderModel.toMap());
  }

  @override
  Future<String?> deleteOrder(String orderId) async {
    return await firebaseFirestoreClass.deleteData('orders', orderId);
  }

  @override
  Future<bool> editOrder(OrderModel orderModel) async {
    return await firebaseFirestoreClass.storeData('orders', orderModel.id, orderModel.toMap());
  }

  @override
  Future<List<OrderModel>?> getOrders() async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection('orders', null);
    return jsonData != null ? jsonData.map<OrderModel>((json) => OrderModel.fromMap(json))?.toList() : jsonData;
  }

  @override
  Future<String?> sendOrder(String orderId, String receiverId, String receiverName) async {
    await notificationsRepo
        .sendNotification(NotificationModel(userId: receiverId, message: 'You have new order request'));
    List<String> fields = ['receiverId', 'receiverName', 'sentDateTime', 'orderStatusType'];
    List values = [receiverId, receiverName, DateTime.now().toUtc(), 2];

    return await firebaseFirestoreClass.updaterSpecificFields('orders', orderId, fields, values);
  }

  //TODO too complex, it would be nice to refactor
  @override
  Future<Map?> getCompanies(List<int> contractItems) async {
    final contractTemplates = await contractsRepo.loadContractsTemplates();
    List<CreateContractModel> contractTemplatesThatMatch = List.empty();
    List<String> companiesThatMatch = List.empty();
    List<String> companiesThatMatchName = List.empty();

    if (contractTemplates != null) {
      int num = 0;
      final contractTemplatesItemsType = contractTemplates.map((item) => item.contractItems).toList();
      contractTemplatesItemsType.forEach((contractTemplateItem) {
        if (contractItems.every((item) => contractTemplateItem.contains(item))) {
          contractTemplatesThatMatch = List.from(contractTemplatesThatMatch)..add(contractTemplates[num]);
          num++;
        } else
          num++;
      });
    } else
      return null;

    if (contractTemplatesThatMatch.isEmpty) return null;

    final List<UserModel>? companies = await companiesRepo.getCompanies();

    if (companies != null) {
      companies.forEach((company) {
        contractTemplatesThatMatch.forEach((contractTemplate) {
          if (company.contractId == contractTemplate.contractName) {
            companiesThatMatch = List.from(companiesThatMatch)..add(company.id);
            companiesThatMatchName = List.from(companiesThatMatchName)..add(company.displayName);
          }
        });
      });
      final Map<String, List> companiesMap = {
        "companiesIds": companiesThatMatch,
        "companiesName": companiesThatMatchName,
      };
      return companiesThatMatch.isNotEmpty ? companiesMap : null;
    } else
      return null;
  }
}
