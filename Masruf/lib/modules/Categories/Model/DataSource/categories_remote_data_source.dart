import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../models/drop_down_model.dart';
import '../Repository/categories_repository.dart';

class CategoriesRemoteDataSource implements CategoriesRepository {
  @override
  Future<Either<Exception, DropdownModel>> getCategoryByID(int id) {
    // TODO: implement getCategoryByID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DropdownModel>>> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<DropdownModel>>> onSearch(
      {required String key, required Object? value}) {
    // TODO: implement onSearch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DropdownModel>> insertCategory(DropdownModel model) {
    debugPrint('from remote db');

    // TODO: implement insertCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DropdownModel>> updateCategory({required DropdownModel model,required String key}) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
