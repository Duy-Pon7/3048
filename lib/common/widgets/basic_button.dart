import 'package:flutter/material.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.backgroundColor = AppPalette.secondary500,
    this.radius,
  });
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          radius ?? 8,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            width ?? ScreenUtil.screenWidth,
            height ?? ScreenUtil.screenHeight * 0.06,
          ),
          shadowColor: AppPalette.transparent,
          backgroundColor: AppPalette.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
