import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/features/dashboard/presentation/cubits/select_bottom_navigation_cubit.dart';

import 'badge_item_widget.dart';
import 'tab_item_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => DashboardPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectBottomNavigationCubit(),
      child: BlocBuilder<SelectBottomNavigationCubit, int>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              body: context
                  .read<SelectBottomNavigationCubit>()
                  .screens[state],
              bottomNavigationBar:
                  AnimatedBottomNavigationBar.builder(
                activeIndex: state,
                gapLocation: GapLocation.none,
                notchSmoothness: NotchSmoothness.softEdge,
                backgroundColor: AppPalette.white,
                onTap: (val) => context
                    .read<SelectBottomNavigationCubit>()
                    .selectIndex(val),
                itemCount: context
                    .read<SelectBottomNavigationCubit>()
                    .items
                    .length,
                splashColor: AppPalette.secondary100,
                tabBuilder: (int index, bool isActive) => index == 2
                    ? BadgeItemWidget(
                        icon: context
                            .read<SelectBottomNavigationCubit>()
                            .items
                            .keys
                            .toList()[index],
                        label: context
                            .read<SelectBottomNavigationCubit>()
                            .items
                            .values
                            .toList()[index],
                        isActive: isActive,
                      )
                    : TabItemWidget(
                        icon: context
                            .read<SelectBottomNavigationCubit>()
                            .items
                            .keys
                            .toList()[index],
                        label: context
                            .read<SelectBottomNavigationCubit>()
                            .items
                            .values
                            .toList()[index],
                        isActive: isActive,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
