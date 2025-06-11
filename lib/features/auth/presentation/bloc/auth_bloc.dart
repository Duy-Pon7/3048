import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/auth/domain/usecases/get_auth.dart';
import 'package:work_flow/features/auth/domain/usecases/login.dart';
import 'package:work_flow/features/auth/domain/usecases/reset_password.dart';
import 'package:work_flow/features/auth/domain/usecases/send_email.dart';
import 'package:work_flow/features/auth/domain/usecases/signup.dart';
import 'package:work_flow/features/auth/domain/usecases/verify_otp.dart';

import '../../../../common/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Signup _signup;
  final SendEmail _sendEmail;
  final VerifyOtp _verifyOtp;
  final ResetPassword _resetPassword;
  final GetAuth _getAuth;

  AuthBloc({
    required Login login,
    required Signup signup,
    required SendEmail sendEmail,
    required VerifyOtp verifyOtp,
    required ResetPassword resetPassword,
    required GetAuth getAuth,
  })  : _login = login,
        _signup = signup,
        _sendEmail = sendEmail,
        _verifyOtp = verifyOtp,
        _resetPassword = resetPassword,
        _getAuth = getAuth,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignup>(_onAuthSignup);
    on<AuthSendEmail>(_onAuthSendEmail);
    on<AuthVerifyOtp>(_onAuthVerifyOtp);
    on<AuthResetPassword>(_onAuthResetPassword);
    on<AuthGetSession>(_onAuthGetSession);
    on<AuthUpdateSession>(_onAuthUpdateSession);
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _login.call(LoginParams(
      email: event.email,
      password: event.password,
      isSaveToken: event.isSaveToken,
    ));

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) async => emit(AuthMessageSuccess(message: success)));
  }

  void _onAuthSignup(AuthSignup event, Emitter<AuthState> emit) async {
    final res = await _signup.call(SignupParams(
        email: event.email,
        birthday: event.birthday,
        gender: event.gender,
        fullname: event.fullname,
        password: event.password,
        passwordConfimation: event.passwordConfimation,
        phone: event.phone));
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthUserSuccess(user: user)));
  }

  void _onAuthSendEmail(AuthSendEmail event, Emitter<AuthState> emit) async {
    final res = await _sendEmail.call(event.email);
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (message) => emit(AuthMessageSuccess(message: message)));
  }

  void _onAuthVerifyOtp(AuthVerifyOtp event, Emitter<AuthState> emit) async {
    final res = await _verifyOtp.call(VerifyOtpParams(
      email: event.email,
      otp: event.otp,
    ));
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (message) => emit(AuthSuccess()),
    );
  }

  void _onAuthResetPassword(
      AuthResetPassword event, Emitter<AuthState> emit) async {
    final res = await _resetPassword.call(ResetPasswordParams(
      email: event.email,
      newPass: event.newPass,
      newPassConfirm: event.newPassConfirm,
    ));

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthUserSuccess(user: user)),
    );
  }

  void _onAuthGetSession(AuthGetSession event, Emitter<AuthState> emit) async {
    final res = await _getAuth.call(NoParams());

    res.fold(
      (failure) => emit(AuthMessageSuccess(message: failure.message)),
      (user) => emit(AuthUserSuccess(user: user)),
    );
  }

  void _onAuthUpdateSession(AuthUpdateSession event, Emitter<AuthState> emit) {
    emit(AuthUserSuccess(user: event.user));
  }
}
