import 'package:flutter/material.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/logout.dart';
import 'package:work_flow/core/utils/screen_util.dart';
import 'package:work_flow/features/account/presentation/pages/individual_info/individual_info_page.dart';

import '../widgets/account_base_widget.dart';
import 'account_option_widget.dart';
import 'change_pass/change_pass_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountBaseWidget(
      visibleAppBar: false,
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImage.logo,
            fit: BoxFit.cover,
            width: ScreenUtil.screenWidth * 0.5,
          ),
          SizedBox(
            height: SizeConstants.dimen_8.h,
          ),
          AccountOptionWidget(
            onTap: () => Navigator.push(
              context,
              IndividualInfoPage.route(),
            ),
            icon: Icons.info,
            label: 'Thông tin cá nhân',
          ),
          AccountOptionWidget(
            onTap: () {},
            icon: Icons.work_history,
            label: 'Lịch sử',
          ),
          AccountOptionWidget(
            onTap: () => Navigator.push(
              context,
              ChangePassPage.route(),
            ),
            icon: Icons.password,
            label: 'Đổi mật khẩu',
          ),
          AccountOptionWidget(
            onTap: () => onLogout(context: context),
            iconColor: AppPalette.primary500,
            textColor: AppPalette.primary500,
            icon: Icons.logout,
            label: 'Đăng xuất',
          ),
        ],
      ),
    );
  }
}
