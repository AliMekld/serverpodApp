import 'package:dartz/dartz.dart';

import '../../../../core/Api/Errors/exceptions.dart';

import '../../../../core/network_checker.dart';
import '../../../../models/drop_down_model.dart';

import '../DataSource/categories_local_data_source.dart';
import '../DataSource/categories_remote_data_source.dart';
import 'categories_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  final  NetworkCheckerNotifier networkCheckerNotifier;
  final CategoriesRepository remote = CategoriesRemoteDataSource();
  final CategoriesRepository local = CategoriesLocalDataSource();
  CategoriesRepositoryImp({required this.networkCheckerNotifier});

  @override
  Future<Either<Exception, DropdownModel>> getCategoryByID(int id) async{
    await networkCheckerNotifier.checkConnection();
    return networkCheckerNotifier.isConnected
          ? remote.getCategoryByID(id)
          : local.getCategoryByID(id);
  }

  @override
  Future<Either<Failure, List<DropdownModel>>> getData() async{
    await networkCheckerNotifier.checkConnection();

    return networkCheckerNotifier.isConnected  ? remote.getData() : local.getData();
  }

  @override
  Future<Either<Exception, List<DropdownModel>>> onSearch(
          {required String key, required Object? value}) async{
    await networkCheckerNotifier.checkConnection();

    return networkCheckerNotifier.isConnected
          ? remote.onSearch(key: key, value: value)
          : local.onSearch(key: key, value: value);
  }

  @override
  Future<Either<Failure, DropdownModel>> insertCategory(DropdownModel model) async{
    await networkCheckerNotifier.checkConnection();

    return networkCheckerNotifier.isConnected
          ? remote.insertCategory(model)
          : local.insertCategory(model);
  }

  @override
  Future<Either<Failure, DropdownModel>> updateCategory(
          {required DropdownModel model, required String key})async {
    await networkCheckerNotifier.checkConnection();

    return networkCheckerNotifier.isConnected
          ? remote.updateCategory(model: model, key: key)
          : local.updateCategory(model: model, key: key);
  }
}
