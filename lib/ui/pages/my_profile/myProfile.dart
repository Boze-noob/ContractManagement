import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

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
    return BlocProvider(
      create: (context) => EditProfileBloc(accountRepo: context.serviceProvider.accountRepo)
        ..add(
          EditProfileInitEvent(
            userModel:
                context.currentUserBloc.state.userModel ?? UserModel(displayName: '', email: '', role: '', id: ''),
          ),
        ),
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStateStatus.error) {
            showInfoMessage("Error happen", context);
          } else if (state.status == EditProfileStateStatus.submitSuccess) {
            showInfoMessage("Profile successfully updated", context, duration: 5);
            context.currentUserBloc.add(CurrentUserUpdateEvent(userModel: state.userModel));
          } else if (state.status == EditProfileStateStatus.userSuccessfullyDeleted) {
            context.authBloc.add(AuthInitEvent());
          }
        },
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
            BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, state) {
                if (state.status == EditProfileStateStatus.loading) {
                  return Padding(
                    padding: EdgeInsets.only(top: context.screenHeight / 2),
                    child: Loader(
                      width: 100,
                      height: 100,
                      color: active,
                    ),
                  );
                } else {
                  return ListView(
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
                                  text: 'ACCOUNT INFORMATION',
                                  size: context.textSizeL,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _DisplayNameWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _EmailWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _PhoneNumberWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _LocationWidget(),
                                SizedBox(
                                  height: 30,
                                ),
                                CustomText(
                                  text: 'CHANGE PASSWORD',
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                  size: context.textSizeL,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _PasswordWidget(),
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DisplayNameWidget extends StatelessWidget {
  const _DisplayNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Row(children: [
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            child: CustomText(
              text: 'Display name:',
              size: context.textSizeM,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              initialValue: state.userModel.displayName,
              maxLength: 20,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.editProfileBloc
                  .add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
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
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ]);
      },
    );
  }
}

class _PhoneNumberWidget extends StatelessWidget {
  const _PhoneNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Row(children: [
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            child: CustomText(
              text: 'Phone number:',
              size: context.textSizeM,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              initialValue: state.userModel.phoneNumber,
              maxLength: 20,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.editProfileBloc
                  .add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(phoneNumber: text))),
              style: TextStyle(
                fontFamily: AppFonts.quicksandBold,
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Phone number',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.quicksandRegular,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ]);
      },
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              child: CustomText(
                text: 'Email:',
                size: context.textSizeM,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                initialValue: state.userModel.email,
                maxLength: 30,
                // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
                onChanged: (text) => context.editProfileBloc
                    .add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(email: text))),
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
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
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
                initialValue: state.userModel.location,
                maxLength: 40,
                // validator: (text) => context.editUserProfileValidator.email(editUserProfileState.model.copyWith(email: Optional(text))),
                onChanged: (text) => context.editProfileBloc
                    .add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(location: text))),
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
      },
    );
  }
}

class _PasswordWidget extends StatefulWidget {
  const _PasswordWidget({Key? key}) : super(key: key);
  @override
  State<_PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<_PasswordWidget> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              child: CustomText(
                text: 'Password:',
                size: context.textSizeM,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
                onChanged: (text) => context.editProfileBloc.add(
                  EditProfileUpdateEvent(
                    userModel: state.userModel.copyWith(password: text),
                  ),
                ),
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
                  suffixIcon: IconButton(
                    icon: _isPasswordVisible == false ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    onPressed: () => setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    }),
                  ),
                  border: OutlineInputBorder(),
                ),
                obscureText: _isPasswordVisible,
              ),
            ),
          ],
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
          child: CustomText(
            text: 'Delete account',
            color: delete,
            weight: FontWeight.bold,
            size: context.textSizeM,
          ),
          color: Colors.grey.withOpacity(0.2),
          borderRadius: 20,
          shrinkWrap: true,
          onTap: () => context.editProfileBloc.add(
            EditProfileDeleteEvent(uid: context.currentUserBloc.state.userModel!.id),
          ),
        ),
        Spacer(),
        Button(
          child: Text(
            'Clear',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.quicksandBold,
              color: Color(0xFF9A9A9A),
            ),
          ),
          onTap: () => context.editProfileBloc.add(
            EditProfileInitEvent(
                userModel:
                    context.currentUserBloc.state.userModel ?? UserModel(displayName: '', email: '', role: '', id: '')),
          ),
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
                  style: TextStyle(fontSize: 14, fontFamily: AppFonts.quicksandBold, color: Colors.white),
                ),
                isLoading: state.status == EditProfileStateStatus.submitting,
                color: active,
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                onTap: () {
                  context.editProfileBloc.add(EditProfileSubmitEvent());
                });
          },
        )
      ],
    );
  }
}
