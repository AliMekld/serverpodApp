// this class is responsible for creating a generic crud methods on local data base
// it works now for get / get all

import 'database_helper.dart';

class GenericLocalCrudMethods<T> {
  final T Function(Map<String, dynamic>) fromMap;
  GenericLocalCrudMethods({required this.fromMap});

  Future<List<T>> getListFrom({required String tableName}) async {
    List<T> tList = [];
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> dynamicList = await databaseHelper.seleectFrom(
        tableName: tableName,
      );
      tList = List<T>.from(dynamicList.map((e) => fromMap(e))).toList();
      return tList;
    } catch (e) {
      throw Exception(e);
    }
  }

  ///=============================[onSearchItem]======================================///

  Future<T> onSearchItem({
    required String tableName,
    required String key,
    required int value,
  }) async {
    T item;
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      Map<String, dynamic> dynamicItem = await databaseHelper.searchIn(
        tableName: tableName,
        whereKey: key,
        whereValue: value,
      );
      item = fromMap(dynamicItem);
      return item;
    } catch (e) {
      throw Exception(e);
    }
  }

  ///=============================[onSearch]======================================///
  Future<List<T>> onSearch({
    required String tableName,
    String? key,
    required Object? value,
  }) async {
    List<T> tList = [];
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> dynamicList =
          await databaseHelper.onFilterList(
        whereKey: key,
        whereValue: value,
        tableName: tableName,
      );
      tList = List<T>.from(dynamicList.map((e) => fromMap(e))).toList();
      return tList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<T> getItem({
    required String tableName,
  }) async {
    T item;
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> list = await databaseHelper.seleectFrom(
        tableName: tableName,
        limit: 1,
      );
      item = fromMap(list.last);
      return item;
    } catch (e) {
      throw Exception(e);
    }
  }
}
