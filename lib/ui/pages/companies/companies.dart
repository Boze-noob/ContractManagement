import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/companies/widgets/companies_table.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CompaniesPage extends StatefulWidget {
  CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  String dropdownValue = 'One';

  //TODO potrebno validaciju odradit
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
          Expanded(
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
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Button(
                          text: 'Add company',
                          shrinkWrap: true,
                          textColor: Color(Colors.white.value),
                          color: active,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              child: Container(
                                width: context.screenWidth / 2,
                                child: Form(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        CustomText(
                                          text: 'Enter required parameters',
                                          size: 22,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(icon: const Icon(Icons.email), hintText: 'Enter email', labelText: 'Email', fillColor: active),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            icon: const Icon(Icons.password),
                                            hintText: 'Enter password',
                                            labelText: 'Password',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                          items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CompaniesTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
