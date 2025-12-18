import 'package:dartz/dartz.dart';
import '../../../../core/Api/Errors/error_model.dart';
import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../core/LocalDataBase/database_helper.dart';
import '../../../../core/LocalDataBase/generic_local_crud_methods.dart';
import '../../../../core/LocalDataBase/sql_queries.dart';
import '../../../../models/drop_down_model.dart';
import '../Repository/categories_repository.dart';

class CategoriesLocalDataSource implements CategoriesRepository {
  /// get All without Filtering
  static Future<Either<Failure, List<DropdownModel>>>
      getCategoriesFromLocalDataBase({
    String? key,
    Object? value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.categoriesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(
          CachingException(ErrorModel(statusCode: 0, message: e.toString())));
    }
  }

  @override
  Future<Either<Exception, DropdownModel>> getCategoryByID(int id) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.categoriesTable,
        key: 'id',
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<DropdownModel>>> onSearch({
    required String key,
    required Object? value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.categoriesTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Failure, List<DropdownModel>>> getData() async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.categoriesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(
          CachingException(ErrorModel(statusCode: 0, message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, DropdownModel>> insertCategory(
      DropdownModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.insert(
        model: model.toJson(),
        tableName: SqlQueries.categoriesTable,
      );

      /// this simulate backend return
      return Right(model.copyWith(id: response));
    } on Failure catch (e) {
      return Left(CachingException(ErrorModel(
        statusCode: 0,
        message: e.toString(),
      )));
    }
  }
  @override
  Future<Either<Failure, DropdownModel>> updateCategory({required DropdownModel model,required String key}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    try {
      int response = await databaseHelper.update(
        whereKey:key ,
        whereValue: model.id?.toString()??'',
        model: model.toJson(),
        tableName: SqlQueries.categoriesTable,
      );

      /// this simulate backend return
      return Right(model.copyWith(id: response));
    } on Failure catch (e) {
      return Left(CachingException(ErrorModel(
        statusCode: 0,
        message: e.toString(),
      )));
    }
  }

}
