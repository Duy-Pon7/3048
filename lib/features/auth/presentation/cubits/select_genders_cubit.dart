import 'package:flutter_bloc/flutter_bloc.dart';

class SelectGendersCubit extends Cubit<int> {
  Map<int, String> genders = {
    1: 'Nam',
    2: 'Nữ',
  };

  SelectGendersCubit() : super(1);

  void selectGender(int? val) => emit(val ?? 1);
}
