import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/network_checker.dart';
import '../../../Expenses/Model/Models/expense_model.dart';
import '../DataSource/home_local_data_source.dart';
import '../DataSource/home_remote_data_source.dart';
import '../Models/test_statistics_model.dart';
import 'home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final NetworkCheckerNotifier networkCheckerNotifier;
  final HomeRepository remote = HomeRemoteDataSource();
  final HomeRepository local = HomeLocalDataSource();

  HomeRepositoryImp({required this.networkCheckerNotifier});

  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpensesTableList() =>
      networkCheckerNotifier.isConnected
          ? remote.getExpensesTableList()
          : local.getExpensesTableList();

  @override
  Future<Either<Failure, StatisticsModel>> getStatisticsData() =>
      networkCheckerNotifier.isConnected
          ? remote.getStatisticsData()
          : local.getStatisticsData();
}
