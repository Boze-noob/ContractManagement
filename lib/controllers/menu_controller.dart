import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contract_management/_all.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String? itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName!;
  }

  isHovering(String? itemName) => hoverItem.value == itemName;

  isActive(String? itemName) => activeItem.value == itemName;

  Widget returnIconFor(String? itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case createRequestDisplayName:
        return _customIcon(Icons.create, itemName);
      case requestsPageDisplayName:
        return _customIcon(Icons.mail, itemName);
      case crateContractPageDisplayName:
        return _customIcon(Icons.my_library_add, itemName);
      case contractsPageDisplayName:
        return _customIcon(Icons.my_library_books_rounded, itemName);
      case companiesPageDisplayName:
        return _customIcon(Icons.apartment_sharp, itemName);
      case clientsPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case myProfilePageDisplayName:
        return _customIcon(Icons.person, itemName);
      case myContractPageDisplayName:
        return _customIcon(Icons.my_library_books_outlined, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String? itemName) {
    if (isActive(itemName)) return Icon(icon, size: 30, color: dark);
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
