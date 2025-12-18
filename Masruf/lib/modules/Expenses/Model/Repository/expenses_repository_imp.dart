import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/network_checker.dart';
import '../Models/expense_model.dart';
import '../DataSource/expenses_local_data_source.dart';
import '../DataSource/expenses_remote_data_source.dart';
import 'expenses_repository.dart';

class ExpensesRepositoryImp implements ExpensesRepository {
  final NetworkCheckerNotifier networkCheckerNotifier;
  final ExpensesRepository remote = ExpensesRemoteDataSource();
  final ExpensesRepository local = ExpensesLocalDataSource();

  ExpensesRepositoryImp({required this.networkCheckerNotifier});

  @override
  Future<Either<Failure, int>> deleteExpense(int id) =>
      networkCheckerNotifier.isConnected
          ? remote.deleteExpense(id)
          : local.deleteExpense(id);

  @override
  Future<Either<Failure, List<ExpensesModel>>> getExpenses() {
    debugPrint('getExpenses called  ${networkCheckerNotifier.isConnected}');
    return networkCheckerNotifier.isConnected
          ? remote.getExpenses()
          : local.getExpenses();
  }

  @override
  Future<Either<Exception, ExpensesModel>> getItemByID(int id) =>
      networkCheckerNotifier.isConnected
          ? remote.getItemByID(id)
          : local.getItemByID(id);

  @override
  Future<Either<Failure, int>> insertExpense(ExpensesModel model) =>
      networkCheckerNotifier.isConnected
          ? remote.insertExpense(model)
          : local.insertExpense(model);

  @override
  Future<Either<Exception, List<ExpensesModel>>> onSearch(
          {required String key, required Object? value}) =>
      networkCheckerNotifier.isConnected
          ? remote.onSearch(key: key, value: value)
          : local.onSearch(key: key, value: value);

  @override
  Future<Either<Failure, int>> updateExpense({required ExpensesModel model}) =>
      networkCheckerNotifier.isConnected
          ? remote.updateExpense(model: model)
          : local.updateExpense(model: model);
}
