import 'package:contract_management/_all.dart';

class MyContractPage extends StatefulWidget {
  MyContractPage({Key? key}) : super(key: key);

  @override
  State<MyContractPage> createState() => _MyContractPageState();
}

class _MyContractPageState extends State<MyContractPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
                () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
