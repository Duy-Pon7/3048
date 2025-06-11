import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';
import 'package:work_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:work_flow/common/widgets/basic_field.dart';

import '../enum/auth_enum.dart';
import '../widget/auth_base_widget.dart';
import 'verify_otp_page.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key, required this.type});
  static route(AuthEnum type) => MaterialPageRoute(
      builder: (context) => SendEmailPage(
            type: type,
          ));
  final AuthEnum type;

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  final _emailCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context
          .read<AuthBloc>()
          .add(AuthSendEmail(email: _emailCon.text.trim()));
    }
  }

  void _onListener(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      EasyLoading.show(
        status: 'Đang tải',
        maskType: EasyLoadingMaskType.black,
      );
    } else if (state is AuthMessageSuccess) {
      EasyLoading.dismiss();
      EasyLoading.showToast(state.message,
          toastPosition: EasyLoadingToastPosition.bottom);
      Navigator.pushReplacement(
          context,
          VerifyOtpPage.route(
            _emailCon.text.trim(),
            widget.type,
          ));
      _emailCon.clear();
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
                    widget.type == AuthEnum.isResetPassword
                        ? AppImage.logopass
                        : AppImage.logootp,
                    fit: BoxFit.cover,
                    width: ScreenUtil.screenWidth * 0.5,
                  ),
                  SizedBox(
                    height: ScreenUtil.screenWidth * 0.04,
                  ),
                  Text(
                    widget.type.desciption,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.02,
                  ),
                  BasicField(
                    hintText: 'Email',
                    controller: _emailCon,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email không được rỗng!';
                      }

                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Vui lòng nhập email đúng định dạng example@gmail.com';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.screenHeight * 0.02,
                  ),
                  BasicButton(
                    onPressed: _onSubmit,
                    text: widget.type.desciption,
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
    _emailCon.dispose();
    super.dispose();
  }
}
