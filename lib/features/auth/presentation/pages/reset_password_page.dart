import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_flow/common/widgets/password_input_widget.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/core/constants/app_successes.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/utils/screen_util.dart';

import '../bloc/auth_bloc.dart';
import '../widget/auth_base_widget.dart';
import 'signin/signin_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.email});
  static route(String email) => MaterialPageRoute(
      builder: (context) => ResetPasswordPage(
            email: email,
          ));
  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passCon = TextEditingController();
  final _passConfirmCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(AuthResetPassword(
            email: widget.email,
            newPass: _passCon.text.trim(),
            newPassConfirm: _passConfirmCon.text.trim(),
          ));
    }
  }

  void _onListener(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      EasyLoading.show(
        status: 'Đang tải',
        maskType: EasyLoadingMaskType.black,
      );
    } else if (state is AuthUserSuccess) {
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
          context, SigninPage.route(), (route) => false);
      EasyLoading.showToast(AppSuccesses.resetPasswordSuccess,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (state is AuthFailure) {
      EasyLoading.dismiss();
      EasyLoading.showToast(state.message,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
        childWidget: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          ScreenUtil.screenWidth * 0.04,
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: _onListener,
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    AppImage.logo,
                    fit: BoxFit.cover,
                    width: ScreenUtil.screenWidth * 0.5,
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.02,
                  ),
                  Text(
                    'Quên mật khẩu',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.02,
                  ),
                  PasswordInputWidget(
                    hintText: 'Nhập mật khẩu mới',
                    controller: _passCon,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.02,
                  ),
                  PasswordInputWidget(
                    hintText: 'Xác nhận mật khẩu',
                    controller: _passConfirmCon,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.03,
                  ),
                  BasicButton(
                    onPressed: _onSubmit,
                    text: 'Hoàn tất',
                    radius: SizeConstants.dimen_12.w,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _passCon.dispose();
    _passConfirmCon.dispose();
    super.dispose();
  }
}
