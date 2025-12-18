import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, void>> register({
    required String email,
    required String password,
  });
}
