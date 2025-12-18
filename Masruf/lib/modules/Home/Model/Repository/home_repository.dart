import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../Expenses/Model/Models/expense_model.dart';
import '../Models/test_statistics_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, StatisticsModel>> getStatisticsData();
  Future<Either<Failure, List<ExpensesModel>>> getExpensesTableList();
}
