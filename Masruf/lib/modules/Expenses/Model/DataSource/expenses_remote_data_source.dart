import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../Models/expense_model.dart';
import '../Repository/expenses_repository.dart';

class ExpensesRemoteDataSource implements ExpensesRepository {
  @override
  Future<Either<Failure, int>> deleteExpense(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpenses() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, ExpensesModel>> getItemByID(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> insertExpense(ExpensesModel model) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<ExpensesModel>>> onSearch({required String key, required Object? value}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> updateExpense({required ExpensesModel model}) {
    throw UnimplementedError();
  }
}
