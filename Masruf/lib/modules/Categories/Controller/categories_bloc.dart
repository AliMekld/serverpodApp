import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/LocalDataBase/database_helper.dart';
import '../../../models/drop_down_model.dart';
import '../../../core/LocalDataBase/sql_queries.dart';
import '../Model/Repository/categories_repository.dart';

part 'categories_states.dart';
part 'categories_events.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesState> {
  final CategoriesRepository _repo;
  CategoriesBloc(this._repo) : super(const CategoriesState()) {
    on<InsertCategoryEvent>((event, emit) => _onInsertCategory(event, emit));
    on<UpdateCategoryEvent>((event, emit) => _onUpdateCategory(event, emit));
    on<DeleteCategoryEvent>((event, emit) => _onDeleteCategory(event, emit));
    on<LoadCategoriesEvent>((event, emit) => _loadCategories(event, emit));
    on<FilterLoadedCategoriesEvent>(
        (event, emit) => _filterLoadedCategories(event, emit));

    on<ChangeFilterKeyTypeEvent>(
        (event, emit) => _changeFilterKeyType(event, emit));
    on<ChangeSelectedCategoryEvent>(
        (event, emit) => _onChangeSelectedCategory(event, emit));
    on<ChangeSelectAllCategoryEvent>(
        (event, emit) => _onChangeSelectAllCategories(event, emit));
  }

  final TextEditingController searchController = TextEditingController();

  Future<void> _onDeleteCategory(
      DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    int id = event.id;
    if (id == -1) return;
    DatabaseHelper databaseHelper = DatabaseHelper();
    emit(state.copyWith(loading: true, errorMessage: null));
    int response = await databaseHelper.deleteFrom(
      tableName: SqlQueries.categoriesTable,
      whereKey: 'id',
      whereValue: id,
    );
    if (response != 0) {
      List<DropdownModel> tableList = state.categoriesList;
      tableList.removeWhere((e) => e.id == id);
      emit(state.copyWith(
          loading: false, errorMessage: null, categoriesList: tableList));
    } else {
      emit(state.copyWith(
          loading: false, errorMessage: 'failed to delete item'));
    }
  }

  void _onInsertCategory(//////////
      InsertCategoryEvent event, Emitter<CategoriesState> emit) async {
    DropdownModel model = event.model;
    List<DropdownModel> tableList = state.categoriesList;
    emit(state.copyWith(loading: true, errorMessage: null));
    final result = await _repo.insertCategory(model);
    result.fold((l) => emit(state.copyWith(errorMessage: l.model.message, loading: false)),
        (r) {
          tableList=[...tableList,model];
      emit(state.copyWith(
          loading: false, errorMessage: null, categoriesList: tableList));
    });
  }

  void _onUpdateCategory(
      UpdateCategoryEvent event, Emitter<CategoriesState> emit) async {
    DropdownModel model = event.model;
    int currentIndex = event.index;
    if (currentIndex == -1) return;
    final result = await _repo.updateCategory(model: model, key: 'id');
    result.fold(
        (l) => emit(state.copyWith(errorMessage: l.toString(), loading: false)),
        (r) {
      List<DropdownModel> tableList = state.categoriesList;
      tableList[currentIndex] = model;
      emit(state.copyWith(
          loading: false, errorMessage: null, categoriesList: tableList));
    });
  }

  Future _loadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    final result = await _repo.getData();
    result.fold(
        (l) =>
            emit(state.copyWith(loading: false, errorMessage: l.model.message)),
        (r) => emit(state.copyWith(categoriesList: r, loading: false)));
  }

  /// onSearch
  Future _filterLoadedCategories(
    FilterLoadedCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    final result = await _repo.onSearch(
      key: state.keyType?.keyName ?? '',
      value: event.value,
    );
    result.fold((l) => emit(state.copyWith(errorMessage: l.toString())),
        (r) => emit(state.copyWith(categoriesList: r)));
  }

  void _changeFilterKeyType(
    ChangeFilterKeyTypeEvent event,
    Emitter<CategoriesState> emit,
  ) =>
      emit(state.copyWith(keyType: event.key));

  void _onChangeSelectedCategory(
    ChangeSelectedCategoryEvent event,
    Emitter<CategoriesState> emit,
  ) {
    int index = event.index;
    bool value = event.value;
    List<DropdownModel> list = state.categoriesList;
    list[index] = list[index].copyWith(selected: value);
    emit(state.copyWith(categoriesList: list));
  }

  void _onChangeSelectAllCategories(
    ChangeSelectAllCategoryEvent event,
    Emitter<CategoriesState> emit,
  ) {
    bool value = event.value ?? false;
    List<DropdownModel> list = List.from(state.categoriesList);
    list = list.map((e) => e.copyWith(selected: value)).toList();
    emit(state.copyWith(categoriesList: list));
  }
}

enum CategoriesKeyType {
  id(keyName: 'id'),
  name(keyName: 'name'),
  eName(keyName: 'eName');

  final String keyName;

  const CategoriesKeyType({required this.keyName});
}
