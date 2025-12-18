import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/Models/income_model.dart';
import '../Model/Repository/income_repository.dart';

part 'income_state.dart';
part 'income_event.dart';

class IncomeBloc extends Bloc<IncomeEvents, IncomeState> {
  final IncomeRepository _repo;

  IncomeBloc(this._repo) : super(const IncomeState()) {
    on<LoadIncomeEvent>(_onLoadIncome);
    on<InsertIncomeEvent>(_onInsertIncome);
    on<UpdateIncomeEvent>(_onUpdateIncome);
    on<DeleteIncomeEvent>(_onDeleteIncome);
    on<FilterIncomeEvent>(_onFilterIncome);
    on<ChangeIncomeFilterKeyTypeEvent>(_onChangeFilterKeyType);
  }

  final TextEditingController searchController = TextEditingController();

  Future<void> _onLoadIncome(
    LoadIncomeEvent event,
    Emitter<IncomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.getIncomeFromLocalDataBase();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) => emit(state.copyWith(isLoading: false, incomeList: r)),
    );
  }

  Future<void> _onInsertIncome(
    InsertIncomeEvent event,
    Emitter<IncomeState> emit,
  ) async {
    final model = event.model;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.insertIncome(model);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<IncomeModel>.from(state.incomeList);
        newList.add(model.copyWith(id: r));
        emit(state.copyWith(isLoading: false, incomeList: newList));
      },
    );
  }

  Future<void> _onUpdateIncome(
    UpdateIncomeEvent event,
    Emitter<IncomeState> emit,
  ) async {
    final model = event.model;
    final index = event.index;
    if (index == -1) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.updateIncome(model: model);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<IncomeModel>.from(state.incomeList);
        newList[index] = model;
        emit(state.copyWith(isLoading: false, incomeList: newList));
      },
    );
  }

  Future<void> _onDeleteIncome(
    DeleteIncomeEvent event,
    Emitter<IncomeState> emit,
  ) async {
    final id = event.id;
    if (id == -1) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.deleteIncome(id);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<IncomeModel>.from(state.incomeList);
        newList.removeWhere((e) => e.id == id);
        emit(state.copyWith(isLoading: false, incomeList: newList));
      },
    );
  }

  Future<void> _onFilterIncome(
    FilterIncomeEvent event,
    Emitter<IncomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.onSearch(
      key: state.keyType?.keyName ?? '',
      value: event.value,
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.toString())),
      (r) => emit(state.copyWith(isLoading: false, incomeList: r)),
    );
  }

  void _onChangeFilterKeyType(
    ChangeIncomeFilterKeyTypeEvent event,
    Emitter<IncomeState> emit,
  ) {
    emit(state.copyWith(keyType: event.key));
  }
}

enum IncomeKeyType {
  id(keyName: 'id'),
  incomeName(keyName: 'incomeName'),
  incomeDate(keyName: 'incomeDate'),
  incomeValue(keyName: 'incomeValue');

  final String keyName;

  const IncomeKeyType({required this.keyName});
}
