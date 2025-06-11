enum AuthEnum {
  isResetPassword,
  isSignup,
}

extension AuthEnumX on AuthEnum {
  String get desciption {
    switch (this) {
      case AuthEnum.isResetPassword:
        return 'Quên mật khẩu';
      case AuthEnum.isSignup:
        return 'Đăng ký tài khoản';
    }
  }
}
