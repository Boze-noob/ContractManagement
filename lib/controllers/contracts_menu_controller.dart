import 'package:get/get.dart';
import 'package:contract_management/_all.dart';

class ContractsMenuController extends GetxController {
  static ContractsMenuController instance = Get.find();
  var activeItem = activeContracts.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;
}
