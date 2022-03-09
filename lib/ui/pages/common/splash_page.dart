import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Loader(
            width: 100,
            height: 100,
            color: active,
          ),
        ),
      ),
    );
  }
}
