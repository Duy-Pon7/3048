import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';

class AppText {
  AppText._();

  static TextTheme get _interTextTheme => GoogleFonts.interTextTheme();

  static TextStyle get _neuturalTitleLarge =>
      _interTextTheme.titleLarge!.copyWith(
        fontSize: SizeConstants.dimen_20.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get _neuturalTitleMedium =>
      _interTextTheme.titleMedium!.copyWith(
        fontSize: SizeConstants.dimen_18.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get _neuturalBodyLarge =>
      _interTextTheme.bodyLarge!.copyWith(
        fontSize: SizeConstants.dimen_16.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get _neuturalBodyMeidum =>
      _interTextTheme.bodyLarge!.copyWith(
        fontSize: SizeConstants.dimen_14.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get _neuturalBodySmall =>
      _interTextTheme.bodySmall!.copyWith(
        fontSize: SizeConstants.dimen_12.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get _neuturalLabelLarge =>
      _interTextTheme.labelLarge!.copyWith(
        fontSize: SizeConstants.dimen_16.sp,
        color: AppPalette.neutural950,
        fontWeight: FontWeight.w400,
      );

  static TextTheme getTextTheme() => TextTheme(
        titleLarge: _neuturalTitleLarge,
        titleMedium: _neuturalTitleMedium,
        bodyLarge: _neuturalBodyLarge,
        bodyMedium: _neuturalBodyMeidum,
        bodySmall: _neuturalBodySmall,
        labelLarge: _neuturalLabelLarge,
      );
}