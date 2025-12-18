part of 'expenses_bloc.dart';

class ExpensesState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<ExpensesModel> expensesList;
  final ExpensesKeyType? keyType;

  const ExpensesState({
    this.isLoading = false,
    this.expensesList = const [],
    this.errorMessage,
    this.keyType,
  });

  @override
  List<Object?> get props => [
        isLoading,
        expensesList,
        errorMessage,
        keyType,
      ];

  ExpensesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ExpensesModel>? expensesList,
    ExpensesKeyType? keyType,
  }) =>
      ExpensesState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        expensesList: expensesList ?? this.expensesList,
        keyType: keyType ?? this.keyType,
      );
}
