import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/error_model.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/LocalDataBase/database_helper.dart';
import '../../../../core/LocalDataBase/generic_local_crud_methods.dart';
import '../../../../core/LocalDataBase/sql_queries.dart';
import '../Models/expense_model.dart';
import '../Repository/expenses_repository.dart';

class ExpensesLocalDataSource implements ExpensesRepository {
  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpenses() async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.expensesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(
          CachingException(ErrorModel(statusCode: 0, message: e.toString())));
    }
  }

  @override
  Future<Either<Exception, ExpensesModel>> getItemByID(int id) async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.expensesTable,
        key: 'id',
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<ExpensesModel>>> onSearch({
    required String key,
    required Object? value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.expensesTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Failure, int>> insertExpense(ExpensesModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.insert(
        model: model.toLocalJson(),
        tableName: SqlQueries.expensesTable,
      );
      return Right(response);
    } on Failure catch (e) {
      return Left(CachingException(ErrorModel(
        statusCode: 0,
        message: e.toString(),
      )));
    }
  }

  @override
  Future<Either<Failure, int>> updateExpense({required ExpensesModel model}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.update(
        whereKey: 'id',
        whereValue: '${model.id!}',
        model: model.toLocalJson(),
        tableName: SqlQueries.expensesTable,
      );
      return Right(response);
    } on Failure catch (e) {
      return Left(CachingException(ErrorModel(
        statusCode: 0,
        message: e.toString(),
      )));
    }
  }

  @override
  Future<Either<Failure, int>> deleteExpense(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.deleteFrom(
        tableName: SqlQueries.expensesTable,
        whereKey: 'id',
        whereValue: id,
      );
      return Right(response);
    } on Failure catch (e) {
      return Left(CachingException(ErrorModel(
        statusCode: 0,
        message: e.toString(),
      )));
    }
  }
}
