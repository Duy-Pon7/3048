import 'package:flutter/material.dart';
import 'package:work_flow/core/theme/app_palette.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dữ liệu trống',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppPalette.neutural600,
            ),
      ),
    );
  }
}
