import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/common/widgets/password_input_widget.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/utils/logout.dart';
import 'package:work_flow/features/account/presentation/blocs/user/user_bloc.dart';

import '../../widgets/account_base_widget.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => ChangePassPage());

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final currentPassCon = TextEditingController();
  final newPassCon = TextEditingController();
  final newPassConfimCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onListener(BuildContext context, UserState state) {
    if (state is UserLoading) {
      EasyLoading.show(
        status: 'Đang tải...',
        maskType: EasyLoadingMaskType.black,
      );
    } else if (state is UserFailure) {
      EasyLoading.dismiss();
      EasyLoading.showToast(
        state.message,
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    } else if (state is UserSuccess) {
      EasyLoading.dismiss();
      onLogout(
        context: context,
        title: 'Thành công',
        message: 'Bạn vừa đổi mật khẩu. Vui lòng đăng nhập lại!',
        canCancel: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AccountBaseWidget(
        titleAppbar: 'Đổi mật khẩu',
        childWidget: SingleChildScrollView(
          padding: EdgeInsets.all(SizeConstants.dimen_16.w),
          child: BlocProvider(
            create: (context) => sl<UserBloc>(),
            child: BlocConsumer<UserBloc, UserState>(
              listener: _onListener,
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PasswordInputWidget(
                        hintText: 'Mật khẩu hiện tại',
                        controller: currentPassCon,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: SizeConstants.dimen_8.h,
                      ),
                      PasswordInputWidget(
                        hintText: 'Mật khẩu mới',
                        controller: newPassCon,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: SizeConstants.dimen_8.h,
                      ),
                      PasswordInputWidget(
                        hintText: 'Xác nhận mật khẩu mới',
                        controller: newPassConfimCon,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: SizeConstants.dimen_8.h,
                      ),
                      BasicButton(
                        radius: SizeConstants.dimen_12.w,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(
                                  UserChangePass(
                                    currentPass:
                                        currentPassCon.text.trim(),
                                    newPass: newPassCon.text.trim(),
                                    newPassConfirm:
                                        newPassConfimCon.text.trim(),
                                  ),
                                );
                          }
                        },
                        text: 'Đổi mật khẩu',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
