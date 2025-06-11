import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';
import 'package:work_flow/features/auth/domain/usecases/signup.dart';
import 'package:work_flow/features/auth/presentation/cubits/obscure_text_cubit.dart';
import 'package:work_flow/common/widgets/basic_field.dart';
import 'package:work_flow/features/auth/presentation/pages/signup/signup_page.dart';

import '../../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../bloc/auth_bloc.dart';
import '../../cubits/checked_cubit.dart';
import '../../enum/auth_enum.dart';
import '../../widget/auth_base_widget.dart';
import '../send_email_page.dart';

part 'signin_page.main.dart';

class SigninPage extends StatefulWidget {
  static route({String? email, String? password}) =>
      MaterialPageRoute(
          builder: (context) => SigninPage(
                email: email,
                password: password,
              ));

  const SigninPage({super.key, this.email, this.password});
  final String? email;
  final String? password;

  @override
  State<SigninPage> createState() => _SigninPageState();
}
