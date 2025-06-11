import 'package:flutter/material.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/features/auth/presentation/widget/auth_appbar.dart';

class AuthBaseWidget extends StatelessWidget {
  const AuthBaseWidget({
    super.key,
    required this.childWidget,
    this.visibleAppBar = true,
  });
  final Widget childWidget;
  final bool visibleAppBar;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: visibleAppBar ? AuthAppbar() : null,
      body: AnimatedContainer(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: size.height,
        ),
        decoration: BoxDecoration(color: AppPalette.background),
        duration: Duration(
          milliseconds: 400,
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: childWidget,
        ),
      ),
    );
  }
}
