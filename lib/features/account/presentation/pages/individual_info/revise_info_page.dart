import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/common/widgets/basic_dropdown_widget.dart';
import 'package:work_flow/common/widgets/basic_field.dart';
import 'package:work_flow/common/widgets/input_with_label_widget.dart';
import 'package:work_flow/core/constants/app_successes.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/datetime_picker.dart';
import 'package:work_flow/features/account/presentation/blocs/user/user_bloc.dart';
import 'package:work_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:work_flow/features/auth/presentation/cubits/select_genders_cubit.dart';

import '../../../../../common/entities/user.dart';
import '../../widgets/account_base_widget.dart';

class ReviseInfoPage extends StatefulWidget {
  const ReviseInfoPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => ReviseInfoPage());

  @override
  State<ReviseInfoPage> createState() => _ReviseInfoPageState();
}

class _ReviseInfoPageState extends State<ReviseInfoPage> {
  final fullnameCon = TextEditingController();
  final birthdayCon = TextEditingController();
  DateTime? birthday;
  int? gender;
  final emailCon = TextEditingController();
  final phoneCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final User? user = (sl<AuthBloc>().state as AuthUserSuccess).user;
    if (user != null) {
      fullnameCon.text = user.fullname ?? '';
      birthday = user.birthday;
      birthdayCon.text =
          birthday != null ? DateFormat('dd/MM/yyyy').format(birthday!) : '';
      gender = user.gender;
      emailCon.text = user.email ?? '';
      phoneCon.text = user.phone ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    fullnameCon.dispose();
    emailCon.dispose();
    birthdayCon.dispose();
    phoneCon.dispose();
    super.dispose();
  }

  Future<void> _onPickDate() async {
    FocusScope.of(context).unfocus();
    DateTime? result =
        await dateTimePicker(context: context, currentDate: birthday);
    if (result != null) {
      birthday = result;
      birthdayCon.text = DateFormat('dd/MM/yyyy').format(result);
    }
  }

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
      sl<AuthBloc>().add(AuthUpdateSession(user: state.user));
      EasyLoading.dismiss();
      EasyLoading.showToast(
        AppSuccesses.reviseSuccess,
        toastPosition: EasyLoadingToastPosition.bottom,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AccountBaseWidget(
        titleAppbar: 'Chỉnh sửa',
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
                      _nameField(),
                      SizedBox(
                        height: SizeConstants.dimen_4.h,
                      ),
                      _genderDropdown(),
                      SizedBox(
                        height: SizeConstants.dimen_4.h,
                      ),
                      _birthdayField(),
                      SizedBox(
                        height: SizeConstants.dimen_4.h,
                      ),
                      _emailField(),
                      SizedBox(
                        height: SizeConstants.dimen_4.h,
                      ),
                      _phoneField(),
                      SizedBox(
                        height: SizeConstants.dimen_8.h,
                      ),
                      _saveButton(context),
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

  Widget _nameField() => InputWithLabelWidget(
        label: 'Họ và tên',
        childWidget: BasicField(
          hintText: 'Vd: Lê Đình Quý',
          controller: fullnameCon,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  Widget _genderDropdown() => BlocProvider(
        create: (context) => sl<SelectGendersCubit>()..selectGender(gender),
        child: BlocBuilder<SelectGendersCubit, int>(
          builder: (context, state) {
            return InputWithLabelWidget(
              label: 'Giới tính',
              childWidget: BasicDropdownWidget<int>(
                items: context.read<SelectGendersCubit>().genders,
                value: state,
                onChanged: (value) =>
                    context.read<SelectGendersCubit>().selectGender(value),
              ),
            );
          },
        ),
      );

  Widget _birthdayField() => InputWithLabelWidget(
        label: 'Ngày sinh',
        childWidget: BasicField(
          hintText: 'dd/mm/yyy',
          readOnly: true,
          keyboardType: TextInputType.datetime,
          suffixIcon: InkWell(
            onTap: () async => await _onPickDate(),
            child: Icon(
              Icons.edit,
              size: SizeConstants.dimen_20.w,
              color: AppPalette.neutural600,
            ),
          ),
          textInputAction: TextInputAction.next,
          controller: birthdayCon,
        ),
      );

  Widget _emailField() => InputWithLabelWidget(
        label: 'Email',
        childWidget: BasicField(
          hintText: 'Nhập email của bạn',
          controller: emailCon,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
      );

  Widget _phoneField() => InputWithLabelWidget(
        label: 'Số điện thoại',
        childWidget: BasicField(
          hintText: 'Nhập số điện thoại',
          controller: phoneCon,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
        ),
      );

  Widget _saveButton(BuildContext context) => BasicButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (_formKey.currentState!.validate()) {
            context.read<UserBloc>().add(
                  UserReviseInfo(
                    fullname: fullnameCon.text.trim(),
                    gender: gender ?? 1,
                    email: emailCon.text.trim(),
                    phone: phoneCon.text.trim(),
                    birthday: birthday == null
                        ? null
                        : DateFormat('yyyy-MM-dd').format(birthday!),
                  ),
                );
          }
        },
        text: 'Lưu thay đổi',
        radius: SizeConstants.dimen_12.w,
      );
}
