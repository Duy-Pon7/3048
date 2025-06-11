import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_flow/common/widgets/basic_field.dart';
import 'package:work_flow/common/widgets/input_with_label_widget.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/theme/app_palette.dart';

import '../../features/auth/presentation/cubits/obscure_text_cubit.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.textInputAction,
    this.validator,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ObscureTextCubit>(),
      child: BlocBuilder<ObscureTextCubit, bool>(
        builder: (context, state) {
          return InputWithLabelWidget(
            label: hintText,
            childWidget: BasicField(
              obscureText: state,
              hintText: hintText,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: TextInputType.visiblePassword,
              validator: validator,
              // prefixIcon: Icon(
              //   Icons.password,
              //   color: AppPalette.secondary500,
              // ),
              suffixIcon: GestureDetector(
                onTap: context
                    .read<ObscureTextCubit>()
                    .toggleObscureText,
                child: Icon(
                  state ? Icons.visibility : Icons.visibility_off,
                  color: AppPalette.neutural600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
