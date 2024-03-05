import 'package:flutter/material.dart';

RegExp alphaRegExp = RegExp(r'^[a-zA-Z]+$');

extension StringExtension on String? {
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  Color toColor({Color? defaultColor}) {
    return fromHex(validate());
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
