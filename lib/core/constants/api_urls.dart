class AuthApiUrls {
  AuthApiUrls._();

  static const String login = '/auth/login';
  static const String signup = '/users/register';
  static const String sendEmail = '/auth/resend-otp';
  static const String verifyOtp = '/auth/verification-otp';
  static const String resetPassword = '/auth/update-password';
  static const String getAuth = '/auth';
}

class UserApiUrls {
  UserApiUrls._();

  static const String reviseInfo = '/users/update';
  static const String chanegPassword = '/auth/change-password';
}

class NotificationApiUrls {
  NotificationApiUrls._();

  static const String getNotifications = '/notifications';
}
