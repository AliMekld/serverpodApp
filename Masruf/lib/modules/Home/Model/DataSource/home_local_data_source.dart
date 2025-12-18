import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/error_model.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/LocalDataBase/generic_local_crud_methods.dart';
import '../../../../core/LocalDataBase/sql_queries.dart';
import '../../../Expenses/Model/Models/expense_model.dart';
import '../Models/test_statistics_model.dart';
import '../Repository/home_repository.dart';

class HomeLocalDataSource implements HomeRepository {
  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpensesTableList() async {
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
  Future<Either<Failure, StatisticsModel>> getStatisticsData() async {
    try {
      final response = await GenericLocalCrudMethods(
              fromMap: StatisticsModel.fromJson)
          .getItem(
        tableName: SqlQueries.statisticsTable,
      );
      return Right(response);
    } catch (e) {
      return Left(
          CachingException(ErrorModel(statusCode: 0, message: e.toString())));
    }
  }
}
