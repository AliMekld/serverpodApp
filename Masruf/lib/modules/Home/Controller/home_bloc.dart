import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Expenses/Model/Models/expense_model.dart';
import '../Model/Models/test_statistics_model.dart';
import '../Model/Repository/home_repository.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final HomeRepository _repo;

  HomeBloc(this._repo) : super(const HomeState()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final statsResult = await _repo.getStatisticsData();
    final expensesResult = await _repo.getExpensesTableList();

    statsResult.fold(
      (l) =>
          emit(state.copyWith(errorMessage: l.model.message, isLoading: false)),
      (r) => emit(state.copyWith(
          statisticsModel: r, errorMessage: null, isLoading: false)),
    );

    expensesResult.fold(
      (l) =>
          emit(state.copyWith(errorMessage: l.model.message, isLoading: false)),
      (r) => emit(state.copyWith(
          expensesList: r, errorMessage: null, isLoading: false)),
    );
  }
}
