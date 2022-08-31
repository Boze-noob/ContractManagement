import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/clients/widgets/clients_table.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => ClientsBloc(
          clientsRepo: context.serviceProvider.clientsRepo,
        )..add(ClientsLoadEvent()),
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
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                }),
                child: ListView(
                  children: [
                    Clientstable(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
