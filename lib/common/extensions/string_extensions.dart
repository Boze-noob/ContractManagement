import 'package:intl/intl.dart';

extension StringExtensions on String {
  bool get hasValue => !(isEmpty || trim().isEmpty);
  String cut(maxLength) => maxLength == null
      ? this
      : length < maxLength
          ? this
          : '${substring(0, maxLength)}...';
  String initials({String delimiter = ' '}) =>
      hasValue ? split(delimiter).map<String>((x) => x.isNotEmpty ? x[0] : '').join() : '';
  bool get isEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
  bool get hasUppercase => contains(RegExp(r'[A-Z]'));
  bool get hasDigits => contains(RegExp(r'[0-9]'));
  bool get isPhoneNumber => contains(RegExp(r'^(?:[+])?[0-9\s]+$'));
  bool get isNumeric => double.tryParse(this) != null;
  bool get hasLowercase => contains(RegExp(r'[a-z]'));
  bool get hasSpecialCharacters => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  String get value => this;

  String thousandsFormatter() {
    if (this != '') {
      return NumberFormat('#,###,###').format(int.parse(this));
    }
    return '';
  }

  String moneyThousandsFormatter() {
    if (this != '') {
      return NumberFormat('#,###,###.00').format(double.parse(this));
    }
    return '';
  }

  int get getNumber => int.parse(this);
}

extension StringNullableExtensions on String? {
  bool get isNullOrEmpty => !hasValue;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  bool get hasValue => !(this == null || this!.isEmpty || this!.trim().isEmpty);
  bool get isEmail =>
      hasValue &&
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(this!);
  String cut(int maxLength) => this == null
      ? ''
      : this!.length < maxLength
          ? this!
          : '${this!.substring(0, maxLength)}...';

  String initials({String delimiter = ' '}) =>
      hasValue ? this!.split(delimiter).map<String>((x) => x.isNotEmpty ? x[0] : '').join() : '';
  bool get hasUppercase => hasValue && this!.contains(RegExp(r'[A-Z]'));
  bool get hasDigits => hasValue && this!.contains(RegExp(r'[0-9]'));
  bool get isPhoneNumber => hasValue && this!.contains(RegExp(r'^(?:[+])?[0-9\s]+$'));
  bool get isNumeric => hasValue && double.tryParse(this!) != null;
  bool get hasLowercase => hasValue && this!.contains(RegExp(r'[a-z]'));
  bool get hasSpecialCharacters => hasValue && this!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  String get value => this ?? '';
}
