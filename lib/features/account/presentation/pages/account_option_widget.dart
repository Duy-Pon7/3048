import 'package:flutter/material.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class AccountOptionWidget extends StatelessWidget {
  const AccountOptionWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    this.textColor = AppPalette.black,
    this.iconColor = AppPalette.secondary600,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConstants.dimen_16.w,
          vertical: SizeConstants.dimen_2.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.dimen_16.w,
          vertical: SizeConstants.dimen_4.h,
        ),
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
          color: AppPalette.white,
          border: Border.all(
            width: 1,
            color: AppPalette.hintText,
          ),
          borderRadius: BorderRadius.circular(SizeConstants.dimen_12.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: SizeConstants.dimen_24.w,
                  ),
                  SizedBox(
                    width: SizeConstants.dimen_12.w,
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: textColor,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: SizeConstants.dimen_24.w,
              color: AppPalette.neutural200,
            )
          ],
        ),
      ),
    );
  }
}
