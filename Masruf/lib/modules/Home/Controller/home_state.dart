part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final StatisticsModel? statisticsModel;
  final List<ExpensesModel> expensesList;

  const HomeState({
    this.isLoading = false,
    this.expensesList = const [],
    this.errorMessage,
    this.statisticsModel,
  });

  @override
  List<Object?> get props => [
        isLoading,
        expensesList,
        errorMessage,
        statisticsModel,
      ];

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    StatisticsModel? statisticsModel,
    List<ExpensesModel>? expensesList,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        statisticsModel: statisticsModel ?? this.statisticsModel,
        expensesList: expensesList ?? this.expensesList,
      );
}