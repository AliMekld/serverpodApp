part of 'expenses_bloc.dart';

sealed class ExpensesEvents {}

class LoadExpensesEvent extends ExpensesEvents {}
class LoadExpenseByIdEvent extends ExpensesEvents {
  final int id;
  LoadExpenseByIdEvent(this.id);
}

class InsertExpenseEvent extends ExpensesEvents {
  final ExpensesModel model;
  InsertExpenseEvent(this.model);
}

class UpdateExpenseEvent extends ExpensesEvents {
  final ExpensesModel model;
  final int index;
  UpdateExpenseEvent(this.model, this.index);
}

class DeleteExpenseEvent extends ExpensesEvents {
  final int id;
  DeleteExpenseEvent(this.id);
}

class FilterExpensesEvent extends ExpensesEvents {
  final Object? value;
  FilterExpensesEvent(this.value);
}

class ChangeExpensesFilterKeyTypeEvent extends ExpensesEvents {
  final ExpensesKeyType? key;
  ChangeExpensesFilterKeyTypeEvent(this.key);
}
