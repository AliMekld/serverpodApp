import 'package:dartz/dartz.dart';
import '../Repository/auth_repository.dart';

class AuthLocalDataSource implements AuthRepository {
  @override
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> register({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }
}
