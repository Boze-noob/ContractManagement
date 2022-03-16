import 'dart:io';

import 'package:contract_management/_all.dart';

abstract class IRevenue {
  Future<RevenueModel?> getData();
  Future<String?> updateData();
}

class RevenueRepo implements IRevenue {
  FirebaseFirestoreClass firebaseFirestoreClass;

  RevenueRepo({required this.firebaseFirestoreClass});

  @override
  Future<RevenueModel?> getData() async {
    final jsonData = await firebaseFirestoreClass.getData('revenue', 'companyRevenue');
    if (jsonData != null)
      return RevenueModel.fromMap(jsonData);
    else
      return null;
  }

  @override
  Future<String?> updateData() {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
