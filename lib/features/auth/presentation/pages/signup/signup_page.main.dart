part of 'signup_page.dart';

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _onPickDate() async {
    FocusScope.of(context).unfocus();
    DateTime? result = await dateTimePicker(
        context: context, currentDate: _birthday);
    if (result != null) {
      _birthday = result;
      _birthdayCon.text = DateFormat('dd/MM/yyyy').format(result);
    }
  }

  final _fullnameCon = TextEditingController();
  final _phoneCon = TextEditingController();
  DateTime? _birthday;
  final _birthdayCon = TextEditingController();
  final _passCon = TextEditingController();
  final _passConfirmCon = TextEditingController();

  void _onSignup(int gender) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(AuthSignup(
          email: widget.email.trim(),
          birthday: DateFormat('yyyy-MM-dd')
              .format(_birthday ?? DateTime.now()),
          gender: gender,
          fullname: _fullnameCon.text.trim(),
          password: _passCon.text.trim(),
          passwordConfimation: _passConfirmCon.text.trim(),
          phone: _phoneCon.text.trim()));
    }
  }

  void _lisnter(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      EasyLoading.show(
        status: 'Đang tải',
        maskType: EasyLoadingMaskType.black,
      );
    } else if (state is AuthFailure) {
      EasyLoading.dismiss();
      EasyLoading.showToast(state.message,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (state is AuthUserSuccess) {
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
        context,
        SigninPage.route(
            email: widget.email.trim(),
            password: _passCon.text.trim()),
        (route) => false,
      );
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
        child: BlocProvider(
          create: (context) => sl<SelectGendersCubit>(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: _lisnter,
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    _logo(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.02,
                    ),
                    Text(
                      'Đăng ký tài khoản',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.016,
                    ),
                    _fullnameField(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.016,
                    ),
                    _phoneField(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.016,
                    ),
                    _passwordField(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.016,
                    ),
                    _passwordConfirmation(),
                    SizedBox(
                      height: ScreenUtil.screenHeight * 0.016,
                    ),
                    _signupButton(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }

  Widget _logo() => Image.asset(
        AppImage.logo,
        fit: BoxFit.cover,
        width: ScreenUtil.screenWidth * 0.3,
      );

  Widget _fullnameField() => BasicField(
        hintText: 'Họ và tên',
        keyboardType: TextInputType.text,
        controller: _fullnameCon,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Họ và tên không được rỗng!';
          }

          if (value.trim().length < 4) {
            return 'Họ và tên phải có ít nhất 4 ký tự';
          }

          return null;
        },
      );

  Widget _phoneField() => BasicField(
        hintText: 'Số điện thoại',
        controller: _phoneCon,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Số điện thoại không được rỗng!';
          }

          final phoneRegex = RegExp(r'^\d{10,11}$');
          if (!phoneRegex.hasMatch(value)) {
            return 'Số điện thoại phải gồm 10 đến 11 chữ số';
          }

          return null;
        },
      );

  Widget _birthdayField() => BasicField(
        readOnly: true,
        hintText: 'Ngày sinh',
        controller: _birthdayCon,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(
          Icons.calendar_today,
          color: AppPalette.secondary500,
        ),
        suffixIcon: InkWell(
          onTap: () async => await _onPickDate(),
          child: Icon(
            Icons.calendar_month,
            color: AppPalette.neutural600,
          ),
        ),
      );

  Widget _genderDropdown() => BlocBuilder<SelectGendersCubit, int>(
        builder: (context, state) {
          return BasicDropdownWidget<int>(
            items: context.read<SelectGendersCubit>().genders,
            value: context.read<SelectGendersCubit>().state,
            onChanged: (int? value) => context
                .read<SelectGendersCubit>()
                .selectGender(value),
            iconData: Icons.people,
          );
        },
      );

  Widget _passwordField() => BlocProvider(
        create: (context) => sl<ObscureTextCubit>(),
        child: BlocBuilder<ObscureTextCubit, bool>(
          builder: (context, state) {
            return BasicField(
              obscureText: state,
              hintText: 'Mật khẩu',
              controller: _passCon,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap: context
                    .read<ObscureTextCubit>()
                    .toggleObscureText,
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
        ),
      );

  Widget _passwordConfirmation() => BlocProvider(
        create: (context) => sl<ObscureTextCubit>(),
        child: BlocBuilder<ObscureTextCubit, bool>(
          builder: (context, state) {
            return BasicField(
              obscureText: state,
              hintText: 'Nhập lại mật khẩu',
              controller: _passConfirmCon,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap: context
                    .read<ObscureTextCubit>()
                    .toggleObscureText,
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

                if (value != _passCon.text.trim()) {
                  return 'Xác nhận mật khẩu không trùng khớp';
                }

                return null;
              },
            );
          },
        ),
      );

  Widget _signupButton(BuildContext context) => BasicButton(
        onPressed: () => _onSignup(
          context.read<SelectGendersCubit>().state,
        ),
        text: 'Đăng ký',
        radius: 16,
      );

  @override
  void dispose() {
    _fullnameCon.dispose();
    _phoneCon.dispose();
    _passCon.dispose();
    _passConfirmCon.dispose();
    _birthdayCon.dispose();
    super.dispose();
  }
}
