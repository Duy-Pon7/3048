import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/theme/app_text.dart';

class AppTheme {
  static _border({
    Color color = AppPalette.borderEnable,
    double borderWidth = 0.8,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          width: borderWidth,
          color: color,
        ),
        borderRadius: BorderRadius.circular(12),
      );

  static final themeMode = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppPalette.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: AppText.getTextTheme(),
    scaffoldBackgroundColor: AppPalette.background,
    colorSchemeSeed: AppPalette.secondary600,
    dividerColor: AppPalette.divider,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.backgroundInput,
      enabledBorder: _border(borderWidth: 0.5),
      focusedBorder: _border(color: AppPalette.secondary500),
      errorBorder: _border(color: AppPalette.primary500),
      focusedErrorBorder: _border(color: AppPalette.secondary500),
    ),
  );
}
