import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Repository/auth_repository.dart';

class AuthRemoteDataSource implements AuthRepository {
  @override
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (credential.user?.email != null) {
        debugPrint(credential.user?.email?.toString() ?? 'no email');
      }
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
