import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/blocs/navigator/navigator_state.dart' as navigatorState;

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
          SizedBox(
            height: 50,
          ),
          BlocProvider(
            create: (context) => NavigatorBloc(),
            child: BlocBuilder<NavigatorBloc, navigatorState.NavigatorState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.navigatorBloc.add(NavigatorUpdateEvent(0));
                              context.createContractBloc.add(CreateContractInitEvent());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              // ignore: unrelated_type_equality_checks
                              color: state.index == 0 ? Colors.purple.withOpacity(0.7) : Colors.white,
                              child: Text(
                                'Active contract',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: state.index == 0 ? Colors.white : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.navigatorBloc.add(NavigatorUpdateEvent(1));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              // ignore: unrelated_type_equality_checks
                              color: state.index == 1 ? Colors.purple.withOpacity(0.7) : Colors.white,
                              child: Text(
                                'Contract request',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: state.index == 1 ? Colors.white : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    (() {
                      if (state.index == 0)
                        return ActiveContractWidget();
                      else
                        return NewContractWidget();
                    }())
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
