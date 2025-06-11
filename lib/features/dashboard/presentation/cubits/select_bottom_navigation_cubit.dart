import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../account/presentation/pages/account_page.dart';
import '../../../notification/presentation/pages/notification_page.dart';

class SelectBottomNavigationCubit extends Cubit<int> {
  SelectBottomNavigationCubit() : super(0);

  final screens = <Widget>[
    Center(
      child: Text('Trang chủ'),
    ),
    Center(
      child: Text('Công việc'),
    ),
    NotificationPage(),
    AccountPage(),
  ];

  final items = {
    Icons.home: 'Trang chủ',
    Icons.work: 'Công việc',
    Icons.notifications: 'Thông báo',
    Icons.account_circle: 'Tài khoản',
  };

  void selectIndex(int val) => emit(val);
}
