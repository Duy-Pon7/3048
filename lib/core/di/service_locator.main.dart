part of 'service_locator.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ScreenUtil.init();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => SharePrefsService(prefs: prefs))
    ..registerLazySingleton(
        () => CheckTokenInterceptor(sharePrefsService: sl()))
    ..registerLazySingleton(() => DioClient(checkTokenInterceptor: sl()));

  // Other
  await _authInit();
  await _dashboardInit();
  await _userInit();
  await _notificationInit();
}

Future<void> _authInit() async {
  sl
    ..registerFactory<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(dioClient: sl()))
    ..registerFactory<AuthRepository>(() =>
        AuthRepositoryImpl(authRemoteDatasource: sl(), sharePrefsService: sl()))
    ..registerFactory(() => Login(authRepository: sl()))
    ..registerFactory(() => Signup(authRepository: sl()))
    ..registerFactory(() => SendEmail(authRepository: sl()))
    ..registerFactory(() => VerifyOtp(authRepository: sl()))
    ..registerFactory(() => ResetPassword(authRepository: sl()))
    ..registerFactory(() => CheckedCubit())
    ..registerFactory(() => ObscureTextCubit())
    ..registerFactory(() => SelectGendersCubit())
    ..registerFactory(() => GetAuth(authRepository: sl()))
    ..registerLazySingleton(() => AuthBloc(
          login: sl(),
          signup: sl(),
          sendEmail: sl(),
          verifyOtp: sl(),
          resetPassword: sl(),
          getAuth: sl(),
        ));
}

Future<void> _dashboardInit() async {
  sl.registerLazySingleton(() => SelectBottomNavigationCubit());
}

Future<void> _userInit() async {
  sl
    ..registerFactory<UserRemoteDatasource>(
        () => UserRemoteDatasourceImpl(dioClient: sl()))
    ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(userRemoteDatasource: sl()))
    ..registerFactory(() => ReviseInfo(userRepository: sl()))
    ..registerFactory(() => ChangePassword(userRepository: sl()))
    ..registerFactory(() => UserBloc(reviseInfo: sl(), changePassword: sl()));
}

Future<void> _notificationInit() async {
  sl
    ..registerFactory<NotificationRemoteDatasource>(
        () => NotificationRemoteDatasourceImpl(dioClient: sl()))
    ..registerFactory<NotificationRepository>(
        () => NotificationRepositoryImpl(notificationRemoteDatasource: sl()))
    ..registerFactory(() => GetNotifications(notificationRepository: sl()))
    ..registerFactory(() => NotificationBloc(getNotifications: sl()));
}
