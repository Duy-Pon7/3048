import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:work_flow/core/assets/app_image.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/common/widgets/basic_dropdown_widget.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/datetime_picker.dart';
import 'package:work_flow/core/utils/screen_util.dart';
import 'package:work_flow/common/widgets/basic_field.dart';

import '../../bloc/auth_bloc.dart';
import '../../cubits/obscure_text_cubit.dart';
import '../../cubits/select_genders_cubit.dart';
import '../../widget/auth_base_widget.dart';
import '../signin/signin_page.dart';

part 'signup_page.main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.email});
  static route(String email) => MaterialPageRoute(
      builder: (context) => SignupPage(
            email: email,
          ));
  final String email;

  @override
  State<SignupPage> createState() => _SignupPageState();
}
