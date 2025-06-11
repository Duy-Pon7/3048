import 'package:flutter/material.dart';
import 'package:work_flow/common/widgets/basic_appbar.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class AccountBaseWidget extends StatelessWidget {
  const AccountBaseWidget({
    super.key,
    required this.childWidget,
    this.visibleAppBar = true,
    this.titleAppbar,
  });
  final Widget childWidget;
  final bool visibleAppBar;
  final String? titleAppbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar
          ? BasicAppbar(
              title: titleAppbar,
            )
          : null,
      body: AnimatedContainer(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: ScreenUtil.screenHeight,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppPalette.gradientBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        duration: Duration(
          milliseconds: 400,
        ),
        child: childWidget,
      ),
    );
  }
}
