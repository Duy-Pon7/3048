import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:work_flow/core/local/share_prefs_service.dart';
import 'package:work_flow/core/theme/app_theme.dart';
import 'package:work_flow/core/utils/is_expire_token.dart';
import 'package:work_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:work_flow/features/auth/presentation/pages/signin/signin_page.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/features/dashboard/presentation/pages/dashboard_page.dart';

void main() async {
  WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  FlutterNativeSplash.remove();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: WorkFlowApp(),
    ),
  );
}

class WorkFlowApp extends StatelessWidget {
  const WorkFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Flow',
      home: (sl<SharePrefsService>().getSaveSession() == null ||
              sl<SharePrefsService>().getSaveSession() == false ||
              sl<SharePrefsService>().getAuthToken() == null ||
              isExpireToken(
                sl<SharePrefsService>().getAuthToken(),
              ))
          ? SigninPage()
          : DashboardPage(),
      theme: AppTheme.themeMode,
      builder: EasyLoading.init(),
    );
  }
}
