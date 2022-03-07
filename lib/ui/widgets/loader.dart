import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class Loader extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? color;

  const Loader({
    this.width,
    this.height,
    this.color,
  });

  const Loader.sm({
    this.width = 16,
    this.height = 16,
    this.color,
  });

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool run = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Container(
        height: widget.height,
        width: widget.width,
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(widget.color ?? theme.primaryColor),
        ),
      ),
    );
  }
}
