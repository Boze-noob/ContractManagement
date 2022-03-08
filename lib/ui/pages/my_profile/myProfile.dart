import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool passwordConfirmationVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _DisplayNameWidget(),
              _EmailWidget(),
              _PasswordWidget(),
              _ButtonRowWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DisplayNameWidget extends StatelessWidget {
  const _DisplayNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userModel.displayName,
          // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
          onChanged: (text) => context.editProfileBloc.add(EditUserProfileUpdateEvent(model: editUserProfileState.model.copyWith(firstName: Optional(text)))),
          style: TextStyle(
            fontFamily: AppFonts.quicksandBold,
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: 'Display name',
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: AppFonts.quicksandRegular,
            ),
          ),
        );
      },
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, editUserProfileState) {
        return TextFormField(
          initialValue: editUserProfileState.userModel.email,
          // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
          onChanged: (text) => context.editProfileBloc.add(EditUserProfileUpdateEvent(model: editUserProfileState.model.copyWith(email: Optional(text)))),
          style: TextStyle(
            fontFamily: AppFonts.quicksandBold,
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: AppFonts.quicksandRegular,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFormField(
          //TODO mozemo iz authInstance izvuc password mislim
          initialValue: state.userModel.password,
          // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
          onChanged: (text) => context.editProfileBloc.add(EditUserProfileUpdateEvent(model: editUserProfileState.model.copyWith(firstName: Optional(text)))),
          style: TextStyle(
            fontFamily: AppFonts.quicksandBold,
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: AppFonts.quicksandRegular,
            ),
          ),
        );
      },
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
          onTap: () => ,
          color: Colors.transparent,
          borderRadius: 20,
        ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return Button(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 14, fontFamily: AppFonts.quicksandBold, color: context.theme.primaryColorDark),
                ),
                isLoading: state.status == EditProfileStateStatus.submitting,
                color: active,
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                onTap: () {
                  context.editProfileBloc.add(EditUserProfileValidateEvent());
                });
          },
        )
      ],
    );
  }
}
