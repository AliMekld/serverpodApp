import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../Expenses/Model/Models/expense_model.dart';
import '../Models/test_statistics_model.dart';
import '../Repository/home_repository.dart';

class HomeRemoteDataSource implements HomeRepository {
  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpensesTableList() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, StatisticsModel>> getStatisticsData() {
    throw UnimplementedError();
  }
}
