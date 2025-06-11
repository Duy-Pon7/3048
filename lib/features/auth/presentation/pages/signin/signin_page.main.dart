part of 'signin_page.dart';

class _SigninPageState extends State<SigninPage> {
  final _emailCon = TextEditingController();
  final _passwordCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _listener(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      EasyLoading.show(
        status: 'Đang tải',
        maskType: EasyLoadingMaskType.black,
      );
    } else if (state is AuthMessageSuccess) {
      _emailCon.clear();
      _passwordCon.clear();
      EasyLoading.dismiss();
      EasyLoading.showToast(
        state.message,
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    } else if (state is AuthUserSuccess) {
      EasyLoading.dismiss();
      Navigator.pushReplacement(
        context,
        DashboardPage.route(),
      );
    } else if (state is AuthFailure) {
      EasyLoading.dismiss();
      EasyLoading.showToast(state.message,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  void _onSubmit(bool isSaveToken) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLogin(
            email: _emailCon.text.trim(),
            password: _passwordCon.text.trim(),
            isSaveToken: isSaveToken,
          ));
    }
  }

  @override
  void initState() {
    _emailCon.text = widget.email ?? '';
    _passwordCon.text = widget.password ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AuthBaseWidget(
        visibleAppBar: false,
        childWidget: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              ScreenUtil.screenWidth * 0.04,
            ),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<ObscureTextCubit>(),
                ),
                BlocProvider(
                  create: (context) => sl<CheckedCubit>(),
                ),
              ],
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: _listener,
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
                          height: ScreenUtil.screenHeight * 0.04,
                        ),
                        Text(
                          'Đăng nhập tài khoản',
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
                        _emailField(),
                        SizedBox(
                          height: ScreenUtil.screenHeight * 0.02,
                        ),
                        _passwordField(),
                        SizedBox(
                          height: ScreenUtil.screenHeight * 0.01,
                        ),
                        _forgetPassText(),
                        SizedBox(
                          height: ScreenUtil.screenHeight * 0.01,
                        ),
                        _loginButton(context),
                        SizedBox(
                          height: ScreenUtil.screenHeight * 0.02,
                        ),
                        _signupText(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() => BasicField(
        hintText: 'Email',
        controller: _emailCon,
        textInputAction: TextInputAction.next,
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
      );

  Widget _passwordField() => BlocBuilder<ObscureTextCubit, bool>(
        builder: (context, state) {
          return BasicField(
            obscureText: state,
            hintText: 'Mật khẩu',
            controller: _passwordCon,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: InkWell(
              onTap: () => context
                  .read<ObscureTextCubit>()
                  .toggleObscureText(),
              child: Icon(
                state ? Icons.visibility : Icons.visibility_off,
                color: AppPalette.neutural600,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mật khẩu không được rỗng!';
              }

              if (value.length < 4) {
                return 'Mật khẩu ít nhất 4 ký tự';
              }

              return null;
            },
          );
        },
      );

  Widget _forgetPassText() => Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<CheckedCubit, bool>(
                  builder: (context, state) {
                    return Checkbox.adaptive(
                      activeColor: AppPalette.secondary500,
                      value: state,
                      onChanged: (value) => context
                          .read<CheckedCubit>()
                          .toggleCheckStatus(value),
                    );
                  },
                ),
                Text(
                  'Ghi nhớ đăng nhập',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                context,
                SendEmailPage.route(AuthEnum.isResetPassword),
              );
            },
            child: Text(
              'Quên mật khẩu ?',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      );

  Widget _loginButton(BuildContext context) => BasicButton(
        onPressed: () => _onSubmit(
          context.read<CheckedCubit>().state,
        ),
        text: 'Đăng nhập',
        radius: SizeConstants.dimen_16.w,
      );

  Widget _signupText() => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.push(
              context, SendEmailPage.route(AuthEnum.isSignup));
        },
        child: RichText(
          text: TextSpan(
            text: 'Chưa có tài khoản? ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppPalette.secondary500,
                  fontWeight: FontWeight.w600,
                ),
            children: [
              TextSpan(
                text: ' Đăng ký',
                style:
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppPalette.secondary500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppPalette.secondary500,
                        ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }
}
