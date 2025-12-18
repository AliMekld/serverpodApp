import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/Models/expense_model.dart';
import '../Model/Repository/expenses_repository.dart';

part 'expenses_state.dart';
part 'expenses_event.dart';

class ExpensesBloc extends Bloc<ExpensesEvents, ExpensesState> {
  final ExpensesRepository _repo;

  ExpensesBloc(this._repo) : super(const ExpensesState()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
    on<InsertExpenseEvent>(_onInsertExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<FilterExpensesEvent>(_onFilterExpenses);
    on<ChangeExpensesFilterKeyTypeEvent>(_onChangeFilterKeyType);
  }

  final TextEditingController searchController = TextEditingController();

  Future<void> _onLoadExpenses(
    LoadExpensesEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.getExpenses();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) => emit(state.copyWith(isLoading: false, expensesList: r,errorMessage: null)),
    );
  }

  Future<void> _onInsertExpense(
    InsertExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final model = event.model;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.insertExpense(model);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<ExpensesModel>.from(state.expensesList);
        newList.add(model.copyWith(id: r));
        emit(state.copyWith(isLoading: false, expensesList: newList,errorMessage: null));
      },
    );
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final model = event.model;
    final index = event.index;
    if (index == -1) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.updateExpense(model: model);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<ExpensesModel>.from(state.expensesList);
        newList[index] = model;
        emit(state.copyWith(isLoading: false, expensesList: newList,errorMessage: null));
      },
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final id = event.id;
    if (id == -1) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.deleteExpense(id);
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.model.message)),
      (r) {
        final newList = List<ExpensesModel>.from(state.expensesList);
        newList.removeWhere((e) => e.id == id);
        emit(state.copyWith(isLoading: false, expensesList: newList,errorMessage: null));
      },
    );
  }

  Future<void> _onFilterExpenses(
    FilterExpensesEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repo.onSearch(
      key: state.keyType?.keyName ?? '',
      value: event.value,
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.toString())),
      (r) => emit(state.copyWith(isLoading: false, expensesList: r,errorMessage: null)),
    );
  }

  void _onChangeFilterKeyType(
    ChangeExpensesFilterKeyTypeEvent event,
    Emitter<ExpensesState> emit,
  ) {
    emit(state.copyWith(keyType: event.key));
  }
}

enum ExpensesKeyType {
  id(keyName: 'id'),
  name(keyName: 'expenseName'),
  value(keyName: 'expenseValue'),
  date(keyName: 'expenseDate'),
  category(keyName: 'categoryID');

  final String keyName;

  const ExpensesKeyType({required this.keyName});
}
