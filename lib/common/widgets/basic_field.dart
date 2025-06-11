import 'package:flutter/material.dart';
import 'package:work_flow/core/theme/app_palette.dart';

class BasicField extends StatelessWidget {
  const BasicField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
  });
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        controller: controller,
        textInputAction: textInputAction,
        cursorColor: AppPalette.secondary500,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppPalette.hintText),
          errorStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppPalette.primary500,
                  ),
          errorMaxLines: 2,
        ),
        validator: validator);
  }
}
