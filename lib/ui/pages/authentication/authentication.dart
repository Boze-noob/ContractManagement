import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _editTextEmail = TextEditingController();

  TextEditingController _editTextPassword = TextEditingController();

  bool _rememberMeCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.Error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage ?? 'Error happen'),
          ));
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Login"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Welcome back to the admin panel.",
                      color: lightGrey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _editTextEmail,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "abc@domain.com",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  controller: _editTextPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: _rememberMeCheckBox,
                            onChanged: (value) {
                              setState(() {
                                _rememberMeCheckBox = !_rememberMeCheckBox;
                              });
                            }),
                        CustomText(
                          text: "Remeber Me",
                        ),
                      ],
                    ),
                  ],
                ),

                 */
                SizedBox(
                  height: 15,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (BuildContext context, state) {
                    return InkWell(
                      onTap: () {
                        if (_editTextPassword.text.isNotEmpty && _editTextEmail.text.isNotEmpty) {
                          context.read<AuthBloc>().add(AuthSignInEvent(
                              email: _editTextEmail.text,
                              password: _editTextPassword.text,
                              rememberMe: _rememberMeCheckBox));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(color: active, borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          text: "Login",
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
