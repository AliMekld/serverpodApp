import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../Models/income_model.dart';

abstract class IncomeRepository {
  Future<Either<Failure, List<IncomeModel>>> getIncomeFromLocalDataBase();

  Future<Either<Exception, IncomeModel>> getItemByID(int id);

  Future<Either<Exception, List<IncomeModel>>> onSearch({
    required String key,
    required Object? value,
  });

  Future<Either<Failure, int>> insertIncome(IncomeModel model);
  Future<Either<Failure, int>> updateIncome({required IncomeModel model});
  Future<Either<Failure, int>> deleteIncome(int id);
}
