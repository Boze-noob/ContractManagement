import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class CreateContractWidget extends StatefulWidget {
  const CreateContractWidget({Key? key}) : super(key: key);

  @override
  _CreateContractWidgetState createState() => _CreateContractWidgetState();
}

class _CreateContractWidgetState extends State<CreateContractWidget> {
  late List<bool> _isChecked;
  late bool _btnFlag;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(ContractItemsType.values.length, false);
    _btnFlag = context.createContractBloc.state.createContractModel.contractItems.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        CustomText(
          text: 'Enter additional information',
          weight: FontWeight.bold,
          color: Colors.black,
          size: context.textSizeXL,
        ),
        SizedBox(
          height: 40,
        ),
        _ContractName(),
        SizedBox(
          height: 20,
        ),
        _ContractDescription(),
        SizedBox(
          height: 5,
        ),
        BlocBuilder<CreateContractBloc, CreateContractState>(
          builder: (context, state) {
            for (int position in state.createContractModel.contractItems) {
              _isChecked[position] = true;
            }
            return ListView.builder(
              itemCount: ContractItemsType.values.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(ContractItemsType.getValue(index).translate()),
                  value: _isChecked[index],
                  onChanged: (val) {
                    setState(
                      () {
                        _isChecked[index] = val!;
                        List<int> contractItemsIndexes = state.createContractModel.contractItems.toList();
                        if (val == true) {
                          contractItemsIndexes.add(index);
                          context.createContractBloc.add(
                            CreateContractUpdateEvent(
                              createContractModel: state.createContractModel.copyWith(contractItems: contractItemsIndexes),
                            ),
                          );
                        } else {
                          contractItemsIndexes.remove(index);
                          context.createContractBloc.add(
                            CreateContractUpdateEvent(
                              createContractModel: state.createContractModel.copyWith(contractItems: contractItemsIndexes),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        ),
        SizedBox(
          height: 50,
        ),
        BlocBuilder<CreateContractBloc, CreateContractState>(
          builder: (context, state) {
            return Button(
              text: _btnFlag ? 'Create contract' : 'Update contract',
              borderRadius: 20,
              color: active,
              shrinkWrap: true,
              onTap: () => context.createContractBloc.add(CreateContractSubmitEvent()),
            );
          },
        ),
      ],
    );
  }
}

class _ContractName extends StatefulWidget {
  const _ContractName({Key? key}) : super(key: key);

  @override
  __ContractNameState createState() => __ContractNameState();
}

class __ContractNameState extends State<_ContractName> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContractBloc, CreateContractState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: context.screenWidth / 2),
          child: TextFormField(
            initialValue: state.createContractModel.contractName,
            // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
            onChanged: (text) => context.createContractBloc.add(CreateContractUpdateEvent(createContractModel: state.createContractModel.copyWith(contractName: text))),
            style: TextStyle(
              fontFamily: AppFonts.quicksandBold,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Contract name',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.quicksandRegular,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}

class _ContractDescription extends StatefulWidget {
  const _ContractDescription({Key? key}) : super(key: key);

  @override
  __ContractDescriptionState createState() => __ContractDescriptionState();
}

class __ContractDescriptionState extends State<_ContractDescription> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContractBloc, CreateContractState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: context.screenWidth / 2),
          child: TextFormField(
            initialValue: state.createContractModel.contractDescription,
            // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
            onChanged: (text) => context.createContractBloc.add(CreateContractUpdateEvent(createContractModel: state.createContractModel.copyWith(contractDescription: text))),
            style: TextStyle(
              fontFamily: AppFonts.quicksandBold,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Contract description',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.quicksandRegular,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
