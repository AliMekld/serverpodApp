import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../Models/expense_model.dart';

abstract class ExpensesRepository {
  Future<Either<Failure, List<ExpensesModel>>> getExpenses();
  
  Future<Either<Exception, ExpensesModel>> getItemByID(int id);
  
  Future<Either<Exception, List<ExpensesModel>>> onSearch({
    required String key,
    required Object? value,
  });

  Future<Either<Failure, int>> insertExpense(ExpensesModel model);
  Future<Either<Failure, int>> updateExpense({required ExpensesModel model});
  Future<Either<Failure, int>> deleteExpense(int id);
}
