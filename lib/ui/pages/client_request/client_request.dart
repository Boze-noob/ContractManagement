import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class ClientRequestPage extends StatelessWidget {
  ClientRequestPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Create request',
                        size: context.textSizeL,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _RequestTypeWidget(),
                      SizedBox(
                        height: 15,
                      ),
                      _DescriptionWidget(),
                      SizedBox(
                        height: 15,
                      ),
                      _LocationWidget(),
                      SizedBox(
                        height: 30,
                      ),
                      _ButtonRowWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _RequestTypeWidget extends StatefulWidget {
  _RequestTypeWidget({Key? key}) : super(key: key);

  @override
  State<_RequestTypeWidget> createState() => _RequestTypeWidgetState();
}

class _RequestTypeWidgetState extends State<_RequestTypeWidget> {
  var dropdownValue = RequestType.activate;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 10,
      ),
      Container(
        width: 100,
        child: CustomText(
          text: 'Request type:',
          size: context.textSizeM,
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: 20,
      ),
      DropdownButton<RequestType>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: TextStyle(color: active),
        underline: Container(
          height: 2,
          color: active,
        ),
        onChanged: (RequestType? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: RequestType.values.map<DropdownMenuItem<RequestType>>((RequestType value) {
          return DropdownMenuItem<RequestType>(
            value: value,
            child: Text(
              value.translate().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomText(
            text: 'Description:',
            size: context.textSizeM,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            //initialValue: state.userModel.email,
            // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
            //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(email: text))),
            style: TextStyle(
              fontFamily: AppFonts.quicksandBold,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.quicksandRegular,
              ),
              border: OutlineInputBorder(),
            ),
            maxLines: 8,
          ),
        ),
      ],
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomText(
            text: 'Location:',
            size: context.textSizeM,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            // initialValue: state.userModel.location,
            // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
            //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(location: text))),
            style: TextStyle(
              fontFamily: AppFonts.quicksandBold,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Location',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.quicksandRegular,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonRowWidget extends StatelessWidget {
  const _ButtonRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Button(
          child: Text(
            'Cancel',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.quicksandBold,
              color: Color(0xFF9A9A9A),
            ),
          ),
          /*
          onTap: () => context.editProfileBloc.add(
            EditProfileInitEvent(userModel: context.currentUserBloc.state.userModel ?? UserModel(displayName: '', email: '', role: '', id: '')),
          ),

           */
          color: Colors.transparent,
          borderRadius: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Button(
            child: Text(
              'Send',
              style: TextStyle(fontSize: 14, fontFamily: AppFonts.quicksandBold, color: Colors.white),
            ),
            //  isLoading: state.status == EditProfileStateStatus.submitting,
            color: active,
            borderRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            onTap: () {
              context.editProfileBloc.add(EditProfileSubmitEvent());
            }),
      ],
    );
  }
}
