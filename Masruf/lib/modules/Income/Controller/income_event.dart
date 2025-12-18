part of 'income_bloc.dart';

sealed class IncomeEvents {}

class LoadIncomeEvent extends IncomeEvents {}

class InsertIncomeEvent extends IncomeEvents {
  final IncomeModel model;
  InsertIncomeEvent(this.model);
}

class UpdateIncomeEvent extends IncomeEvents {
  final IncomeModel model;
  final int index;
  UpdateIncomeEvent(this.model, this.index);
}

class DeleteIncomeEvent extends IncomeEvents {
  final int id;
  DeleteIncomeEvent(this.id);
}

class FilterIncomeEvent extends IncomeEvents {
  final Object? value;
  FilterIncomeEvent(this.value);
}

class ChangeIncomeFilterKeyTypeEvent extends IncomeEvents {
  final IncomeKeyType? key;
  ChangeIncomeFilterKeyTypeEvent(this.key);
}
