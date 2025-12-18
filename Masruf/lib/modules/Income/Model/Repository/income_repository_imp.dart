import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/network_checker.dart';
import '../Models/income_model.dart';
import '../DataSource/income_local_data_source.dart';
import '../DataSource/income_remote_data_source.dart';
import 'income_repository.dart';

class IncomeRepositoryImp implements IncomeRepository {
  final NetworkCheckerNotifier networkCheckerNotifier;
  final IncomeRepository remote = IncomeRemoteDataSource();
  final IncomeRepository local = IncomeLocalDataSource();

  IncomeRepositoryImp({required this.networkCheckerNotifier});

  @override
  Future<Either<Failure, int>> deleteIncome(int id) =>
      networkCheckerNotifier.isConnected
          ? remote.deleteIncome(id)
          : local.deleteIncome(id);

  @override
  Future<Either<Failure, List<IncomeModel>>> getIncomeFromLocalDataBase() =>
      networkCheckerNotifier.isConnected
          ? remote.getIncomeFromLocalDataBase()
          : local.getIncomeFromLocalDataBase();

  @override
  Future<Either<Exception, IncomeModel>> getItemByID(int id) =>
      networkCheckerNotifier.isConnected
          ? remote.getItemByID(id)
          : local.getItemByID(id);

  @override
  Future<Either<Failure, int>> insertIncome(IncomeModel model) =>
      networkCheckerNotifier.isConnected
          ? remote.insertIncome(model)
          : local.insertIncome(model);

  @override
  Future<Either<Exception, List<IncomeModel>>> onSearch(
          {required String key, required Object? value}) =>
      networkCheckerNotifier.isConnected
          ? remote.onSearch(key: key, value: value)
          : local.onSearch(key: key, value: value);

  @override
  Future<Either<Failure, int>> updateIncome({required IncomeModel model}) =>
      networkCheckerNotifier.isConnected
          ? remote.updateIncome(model: model)
          : local.updateIncome(model: model);
}
