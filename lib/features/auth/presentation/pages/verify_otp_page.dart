import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';
import 'package:work_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:work_flow/features/auth/presentation/enum/auth_enum.dart';

import '../widget/auth_base_widget.dart';
import 'reset_password_page.dart';
import 'signup/signup_page.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage(
      {super.key, required this.email, required this.type});
  static route(String email, AuthEnum type) => MaterialPageRoute(
      builder: (context) => VerifyOtpPage(
            email: email,
            type: type,
          ));

  final String email;
  final AuthEnum type;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _pinCodeCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    } else if (state is AuthFailure) {
      EasyLoading.dismiss();
      EasyLoading.showToast(state.message,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (state is AuthSuccess) {
      EasyLoading.dismiss();
      if (widget.type == AuthEnum.isSignup) {
        Navigator.pushReplacement(
          context,
          SignupPage.route(widget.email),
        );
      } else {
        Navigator.pushReplacement(
          context,
          ResetPasswordPage.route(widget.email),
        );
      }
    }
    ;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthVerifyOtp(
            email: widget.email,
            otp: _pinCodeCon.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AuthBaseWidget(
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
                    _logo(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.03,
                    ),
                    _labelText(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.02,
                    ),
                    _pincodeField(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.01,
                    ),
                    _continueButton(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.01,
                    ),
                    _resendButton(),
                  ],
                ),
              );
            },
          ),
        ),
      )),
    );
  }

  Widget _logo() => Image.asset(
        AppImage.logootp,
        fit: BoxFit.cover,
        width: ScreenUtil.screenWidth * 0.5,
      );

  Widget _labelText() => Text(
        'Xác thực địa chỉ Email',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      );

  Widget _pincodeField() => PinCodeTextField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Mã pin không được rỗng!';
          }
          return null;
        },
        controller: _pinCodeCon,
        autoDisposeControllers: false,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: ScreenUtil.screenHeight * 0.08,
          fieldWidth: ScreenUtil.screenWidth * 0.14,
          activeFillColor: AppPalette.white,
          inactiveFillColor: AppPalette.pinCodeUnselectedBackground,
          selectedFillColor: AppPalette.white,
          inactiveColor: AppPalette.transparent,
          activeColor: AppPalette.secondary500,
          selectedColor: AppPalette.pinCodeBorder,
        ),
        animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        errorTextSpace: 24,
        errorAnimationDuration: 8,
        appContext: context,
      );

  Widget _continueButton() => BasicButton(
        onPressed: _onSubmit,
        text: 'Xác nhận',
        radius: SizeConstants.dimen_12.w,
      );

  Widget _resendButton() => GestureDetector(
        onTap: () => context
            .read<AuthBloc>()
            .add(AuthSendEmail(email: widget.email)),
        child: RichText(
          text: TextSpan(
            text: 'Bạn không nhận được mã? ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            children: [
              TextSpan(
                text: 'Gửi lại',
                style:
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppPalette.secondary600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppPalette.secondary600,
                        ),
              ),
            ],
          ),
        ),
      );
  @override
  void dispose() {
    _pinCodeCon.dispose();
    super.dispose();
  }
}
