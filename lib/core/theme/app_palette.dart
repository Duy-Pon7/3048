import 'package:flutter/material.dart';

class AppPalette {
  // Primary
  static const primary50 = Color(0xfffff0f2);
  static const primary100 = Color(0xffffdee3);
  static const primary500 = Color(0xffff2947);

  // Secondary
  static const secondary100 = Color(0xffdff2ff);
  static const secondary500 = Color(0xff985308);
  static const secondary600 = Color(0xff0083cb);
  // Neutural
  static const neutural600 = Color(0xff6d6163);
  static const neutural950 = Color(0xff262223);
  static const neutural200 = Color(0xffc8c0c0);

  // Tertiary
  static final tertiary30 = Color(0xff3C3C434D);

  // Input
  static const borderEnable = Color(0xff54545657);
  static const backgroundInput = Colors.white;
  static final hintText = Color(0xff3C3C434D).withValues(alpha: 0.3);

  // Other
  static const background = Colors.white;
  static const gradientBackground = [
    secondary100,
    primary100,
  ];
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const pinCodeBorder = Color(0xff5D4037);
  static const pinCodeUnselectedBackground = Color(0xffF0F0F0);
  static final divider = Colors.grey.shade200;
}
