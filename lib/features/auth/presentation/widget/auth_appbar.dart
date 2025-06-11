import 'package:flutter/material.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class AuthAppbar extends StatelessWidget implements PreferredSize {
  const AuthAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: ScreenUtil.screenWidth * 0.3,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.screenWidth * 0.02),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: AppPalette.secondary500,
                size: SizeConstants.dimen_24.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
