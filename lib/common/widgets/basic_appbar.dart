import 'package:flutter/material.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class BasicAppbar extends StatelessWidget implements PreferredSize {
  const BasicAppbar(
      {super.key, this.title, this.leadingText, this.leadingWidth});
  final String? title;
  final String? leadingText;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: leadingText == null
          ? null
          : (leadingWidth ?? ScreenUtil.screenWidth * 0.3),
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      centerTitle: title != null,
      title: title == null
          ? null
          : Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil.screenWidth * 0.02),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: AppPalette.secondary600,
                size: SizeConstants.dimen_24.w,
              ),
              SizedBox(
                width: ScreenUtil.screenWidth * 0.02,
              ),
              leadingText == null
                  ? SizedBox.fromSize()
                  : Expanded(
                      child: Text(
                        leadingText!,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppPalette.secondary600,
                                ),
                      ),
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
