import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';

import 'tab_item_widget.dart';

class BadgeItemWidget extends StatelessWidget {
  const BadgeItemWidget(
      {super.key,
      required this.icon,
      required this.label,
      required this.isActive});
  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      stackFit: StackFit.expand,
      badgeContent: Text(
        '3',
        style: TextStyle(color: Colors.white),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: AppPalette.primary500,
        shape: badges.BadgeShape.circle,
        borderRadius: BorderRadius.circular(
          SizeConstants.dimen_8.w,
        ),
        elevation: 0,
      ),
      position: badges.BadgePosition.topEnd(
        top: 0,
        end: SizeConstants.dimen_26.w,
      ),
      child: TabItemWidget(
        icon: icon,
        label: label,
        isActive: isActive,
      ),
    );
  }
}
