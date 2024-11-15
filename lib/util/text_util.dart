import 'package:flutter/material.dart';

import 'my_color.dart';

class TextUtil {

  /// fontSize = 32
  static TextStyle get32(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(color: color);
  }

  /// fontSize = 24
  static TextStyle get24(BuildContext context, Color color) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(color: color);
  }

  /// fontSize = 20
  static TextStyle get20(BuildContext context, Color color) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(color: color);
  }

  /// fontSize = 18
  static TextStyle get18(BuildContext context, Color color) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(color: color);
  }

  /// fontSize = 16
  static TextStyle get16(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(color: color);
  }

  /// fontSize = 15
  static TextStyle get15(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(color: color);
  }

  /// fontSize = 14
  static TextStyle get14(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(color: color);
  }

  /// fontSize = 13
  static TextStyle get13(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(color: color);
  }

  /// fontSize = 12
  static TextStyle get12(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(color: color);
  }

  /// fontSize = 11
  static TextStyle get11(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(color: color);
  }

  static TextTheme setTextTheme() {
    return const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: MyColor.gray90,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: MyColor.gray90,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: MyColor.gray90,
      ),
    );
  }
}
