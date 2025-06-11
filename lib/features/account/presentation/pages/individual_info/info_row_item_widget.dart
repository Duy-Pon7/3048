import 'package:flutter/material.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class InfoRowItemWidget extends StatelessWidget {
  const InfoRowItemWidget({
    super.key,
    required this.label,
    required this.content,
  });
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: ScreenUtil.screenWidth * 0.3,
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
