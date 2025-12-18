import 'package:dartz/dartz.dart';
import '../../../../../core/network_checker.dart';
import '../DataSource/auth_local_data_source.dart';
import '../DataSource/auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final NetworkCheckerNotifier networkCheckerNotifier;
  final AuthRepository remote = AuthRemoteDataSource();
  final AuthRepository local = AuthLocalDataSource();

  AuthRepositoryImp({required this.networkCheckerNotifier});

  @override
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) async {
    if (networkCheckerNotifier.isConnected) {
      return await remote.login(email: email, password: password);
    }
    return Left(Exception('No Internet Connection'));
  }

  @override
  Future<Either<Exception, void>> register({
    required String email,
    required String password,
  }) async {
    if (networkCheckerNotifier.isConnected) {
      return await remote.register(email: email, password: password);
    }
    return Left(Exception('No Internet Connection'));
  }
}
