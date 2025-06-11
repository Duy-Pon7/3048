import 'package:flutter/material.dart';

import '../../core/utils/screen_util.dart';

class InputWithLabelWidget extends StatelessWidget {
  const InputWithLabelWidget({
    super.key,
    required this.label,
    required this.childWidget,
  });

  final String label;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: ScreenUtil.screenHeight * 0.01,
        ),
        childWidget,
      ],
    );
  }
}
