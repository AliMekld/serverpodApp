part of 'income_bloc.dart';

class IncomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<IncomeModel> incomeList;
  final IncomeKeyType? keyType;

  const IncomeState({
    this.isLoading = false,
    this.incomeList = const [],
    this.errorMessage,
    this.keyType,
  });

  @override
  List<Object?> get props => [
        isLoading,
        incomeList,
        errorMessage,
        keyType,
      ];

  IncomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<IncomeModel>? incomeList,
    IncomeKeyType? keyType,
  }) =>
      IncomeState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        incomeList: incomeList ?? this.incomeList,
        keyType: keyType ?? this.keyType,
      );
}
