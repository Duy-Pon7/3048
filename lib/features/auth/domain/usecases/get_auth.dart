import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class GetAuth implements Usecase<User?, NoParams> {
  final AuthRepository authRepository;

  GetAuth({required this.authRepository});

  @override
  Future<Either<Failure, User?>> call(NoParams param) async {
    return await authRepository.getAuth();
  }
}
