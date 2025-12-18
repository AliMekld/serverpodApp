part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final String? errorMessage;
  final bool? loading;
  final List<DropdownModel> categoriesList;
  final CategoriesKeyType? keyType;

  const CategoriesState(
      {this.errorMessage,
      this.loading,
      this.categoriesList = const [],
      this.keyType});

  CategoriesState copyWith(
      {String? errorMessage,
      bool? loading,
      CategoriesKeyType? keyType,
      List<DropdownModel>? categoriesList}) {
    return CategoriesState(
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
      categoriesList: categoriesList ?? this.categoriesList,
      keyType: keyType ?? this.keyType,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        loading,
        categoriesList,
        keyType,
      ];
}
