import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/error_model.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/LocalDataBase/database_helper.dart';
import '../../../../core/LocalDataBase/generic_local_crud_methods.dart';
import '../../../../core/LocalDataBase/sql_queries.dart';
import '../Models/income_model.dart';
import '../Repository/income_repository.dart';

class IncomeLocalDataSource implements IncomeRepository {
  @override
  Future<Either<Failure, List<IncomeModel>>> getIncomeFromLocalDataBase() async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.incomeTable,
      );
      return Right(response);
    } catch (e) {
      return Left(
          CachingException(ErrorModel(statusCode: 0, message: e.toString())));
    }
  }

  @override
  Future<Either<Exception, IncomeModel>> getItemByID(int id) async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.incomeTable,
        key: 'id',
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<IncomeModel>>> onSearch({
    required String key,
    required Object? value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.incomeTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Failure, int>> insertIncome(IncomeModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.insert(
        model: model.toJson(),
        tableName: SqlQueries.incomeTable,
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
  Future<Either<Failure, int>> updateIncome({required IncomeModel model}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.update(
        whereKey: 'id',
        whereValue: '${model.id!}',
        model: model.toJson(),
        tableName: SqlQueries.incomeTable,
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
  Future<Either<Failure, int>> deleteIncome(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.deleteFrom(
        tableName: SqlQueries.incomeTable,
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
