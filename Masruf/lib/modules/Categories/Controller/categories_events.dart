part of 'categories_bloc.dart';

sealed class CategoriesEvents {}

class InsertCategoryEvent extends CategoriesEvents {
  final DropdownModel model;

  InsertCategoryEvent(this.model);
}
class UpdateCategoryEvent extends CategoriesEvents {
  final DropdownModel model;
  final int index;

  UpdateCategoryEvent(this.model,this.index);
}

class DeleteCategoryEvent extends CategoriesEvents {
  final int id;

  DeleteCategoryEvent(this.id);
}

class LoadCategoriesEvent extends CategoriesEvents {}

class FilterLoadedCategoriesEvent extends CategoriesEvents {
  final Object? value;
  FilterLoadedCategoriesEvent( this.value);
}
class ChangeFilterKeyTypeEvent extends CategoriesEvents{
  final CategoriesKeyType? key;
  ChangeFilterKeyTypeEvent(this.key);
}
class ChangeSelectedCategoryEvent extends CategoriesEvents{
  final int index;
  final bool value;
  ChangeSelectedCategoryEvent(this.index, this.value);
}
class ChangeSelectAllCategoryEvent extends CategoriesEvents{
  final bool? value;
  ChangeSelectAllCategoryEvent(this.value);
}


