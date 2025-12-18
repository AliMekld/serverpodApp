import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../Models/income_model.dart';
import '../Repository/income_repository.dart';

class IncomeRemoteDataSource implements IncomeRepository {
  @override
  Future<Either<Failure, int>> deleteIncome(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<IncomeModel>>> getIncomeFromLocalDataBase() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, IncomeModel>> getItemByID(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> insertIncome(IncomeModel model) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<IncomeModel>>> onSearch({required String key, required Object? value}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> updateIncome({required IncomeModel model}) {
    throw UnimplementedError();
  }
}
