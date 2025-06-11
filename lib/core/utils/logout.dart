import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/local/share_prefs_service.dart';
import 'package:work_flow/features/auth/presentation/pages/signin/signin_page.dart';

void onLogout(
    {required BuildContext context,
    String? title,
    String? message,
    bool canCancel = true}) async {
  late OkCancelResult result;

  if (canCancel) {
    result = await showOkCancelAlertDialog(
      context: context,
      title: title ?? 'Đăng xuất',
      message: message ?? 'Bạn muốn đăng xuất?',
      canPop: false,
      okLabel: 'Đăng xuất',
      cancelLabel: 'Hủy',
      style: AdaptiveStyle.adaptive,
      barrierDismissible: false,
    );
  } else {
    result = await showOkAlertDialog(
      context: context,
      title: title ?? 'Đăng xuất',
      message: message ?? 'Bạn muốn đăng xuất?',
      canPop: false,
      okLabel: 'Đăng xuất',
      style: AdaptiveStyle.adaptive,
      barrierDismissible: false,
    );
  }

  if (result == OkCancelResult.ok) {
    sl<SharePrefsService>().clear();
    Navigator.pushAndRemoveUntil(
      context,
      SigninPage.route(),
      (route) => false,
    );
  }
}
