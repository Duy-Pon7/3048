import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_flow/common/widgets/basic_button.dart';
import 'package:work_flow/common/widgets/empty_data.dart';
import 'package:work_flow/common/widgets/loader.dart';
import 'package:work_flow/core/constants/app_errors.dart';
import 'package:work_flow/core/constants/size_constants.dart';
import 'package:work_flow/core/di/service_locator.dart';
import 'package:work_flow/core/enums/gender.dart';
import 'package:work_flow/core/extensions/size_extension.dart';
import 'package:work_flow/features/auth/presentation/bloc/auth_bloc.dart';

import '../../widgets/account_base_widget.dart';
import 'info_row_item_widget.dart';
import 'revise_info_page.dart';

class IndividualInfoPage extends StatefulWidget {
  const IndividualInfoPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => IndividualInfoPage());

  @override
  State<IndividualInfoPage> createState() => _IndividualInfoPageState();
}

class _IndividualInfoPageState extends State<IndividualInfoPage> {
  @override
  void initState() {
    sl<AuthBloc>().add(AuthGetSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AccountBaseWidget(
      titleAppbar: 'Thông tin',
      childWidget: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }
          if (state is AuthUserSuccess) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConstants.dimen_16.w,
                    vertical: SizeConstants.dimen_8.h,
                  ),
                  padding: EdgeInsets.all(SizeConstants.dimen_16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(SizeConstants.dimen_16.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InfoRowItemWidget(
                        label: 'Họ và tên',
                        content: state.user?.fullname ?? AppErrors.emptyData,
                      ),
                      Divider(
                        height: SizeConstants.dimen_12.h,
                      ),
                      InfoRowItemWidget(
                        label: 'Giới tính',
                        content: toGender(state.user?.gender ?? 0).description,
                      ),
                      Divider(
                        height: SizeConstants.dimen_12.h,
                      ),
                      InfoRowItemWidget(
                        label: 'Ngày sinh',
                        content: state.user?.birthday == null
                            ? AppErrors.emptyData
                            : DateFormat('dd-MM-yyyy').format(
                                state.user!.birthday!,
                              ),
                      ),
                      Divider(
                        height: SizeConstants.dimen_12.h,
                      ),
                      InfoRowItemWidget(
                        label: 'Email',
                        content: state.user?.email ?? AppErrors.emptyData,
                      ),
                      Divider(
                        height: SizeConstants.dimen_12.h,
                      ),
                      InfoRowItemWidget(
                        label: 'Số điện thoại',
                        content: state.user?.phone ?? AppErrors.emptyData,
                      ),
                      Divider(
                        height: SizeConstants.dimen_12.h,
                      ),
                      BasicButton(
                        radius: SizeConstants.dimen_16.w,
                        onPressed: () => Navigator.push(
                          context,
                          ReviseInfoPage.route(),
                        ),
                        text: 'Chỉnh sửa',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return EmptyData();
        },
      ),
    );
  }
}
