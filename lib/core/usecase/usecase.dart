import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';

abstract interface class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParams {}
