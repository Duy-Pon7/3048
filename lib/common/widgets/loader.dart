import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: AppPalette.secondary600,
          size: size ?? SizeConstants.dimen_20.w,
        ),
      ),
    );
  }
}
