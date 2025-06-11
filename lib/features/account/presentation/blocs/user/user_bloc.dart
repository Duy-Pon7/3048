import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_flow/common/entities/user.dart';

import '../../../domain/usecases/change_password.dart';
import '../../../domain/usecases/revise_info.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ReviseInfo _reviseInfo;
  final ChangePassword _changePassword;

  UserBloc({
    required ReviseInfo reviseInfo,
    required ChangePassword changePassword,
  })  : _reviseInfo = reviseInfo,
        _changePassword = changePassword,
        super(UserInitial()) {
    on<UserEvent>((event, emit) => emit(UserLoading()));
    on<UserReviseInfo>(_onUserReviseInfo);
    on<UserChangePass>(_onUserChangePass);
  }

  void _onUserReviseInfo(UserReviseInfo event, Emitter<UserState> emit) async {
    final res = await _reviseInfo.call(
      ReviseInfoParam(
        fullname: event.fullname,
        gender: event.gender,
        email: event.email,
        phone: event.phone,
        birthday: event.birthday,
      ),
    );

    res.fold(
      (failure) => emit(UserFailure(message: failure.message)),
      (user) => emit(UserSuccess(user: user)),
    );
  }

  void _onUserChangePass(UserChangePass event, Emitter<UserState> emit) async {
    final res = await _changePassword.call(
      ChangePassParam(
        currentPass: event.currentPass,
        newPass: event.newPass,
        newPassConfirm: event.newPassConfirm,
      ),
    );

    res.fold(
      (failure) => emit(UserFailure(message: failure.message)),
      (message) => emit(UserSuccess(message: message)),
    );
  }
}
