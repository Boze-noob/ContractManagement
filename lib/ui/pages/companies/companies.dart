import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/companies/widgets/companies_table.dart';
import 'package:flutter/gestures.dart';

class CompaniesPage extends StatefulWidget {
  CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  //TODO potrebno validaciju odradit
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompaniesBloc(
        companiesRepo: context.serviceProvider.companiesRepo,
      )..add(CompaniesGetEvent()),
      child: BlocListener<CompaniesBloc, CompaniesState>(
        listener: (context, state) {
          if (state.status == CompaniesStateStatus.error)
            showInfoMessage(state.errorMessage ?? 'Error happen', context);
          else if (state.status == CompaniesStateStatus.deletedSuccessfully) {
            showInfoMessage('Company deleted successfully', context);
            context.companiesBloc.add(CompaniesGetEvent());
          }
        },
        child: Container(
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
              BlocBuilder<CompaniesBloc, CompaniesState>(
                builder: (context, state) {
                  if (state.status == CompaniesStateStatus.loading)
                    return Loader(
                      width: 100,
                      height: 100,
                      color: active,
                    );
                  else
                    return Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CompaniesTable(
                              parentContext: context,
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
