import 'package:dartz/dartz.dart';

import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../models/drop_down_model.dart';

abstract class CategoriesRepository{
  ///================>> GET CATEGORIES DATA
  Future<Either<Failure, List<DropdownModel>>> getData();
  ///================>> GET CATEGORY BY ID
  Future<Either<Exception, DropdownModel>> getCategoryByID(
      int id);
  Future<Either<Exception, List<DropdownModel>>> onSearch({
    required String key,
    required Object? value,
  });
  Future<Either<Failure, DropdownModel>> insertCategory(DropdownModel model);
  Future<Either<Failure, DropdownModel>> updateCategory({required DropdownModel model,required String key});

}