// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpensesModelCWProxy {
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// ExpensesModel(...).copyWith(id: 12, name: "My name")
  /// ```
  ExpensesModel call({
    int? id,
    String? expenseName,
    double? expenseValue,
    DateTime? expenseDate,
    int? categoryID,
    bool isSelected,
    String? categoryEname,
    String? categoryName,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExpensesModel.copyWith(...)`.
class _$ExpensesModelCWProxyImpl implements _$ExpensesModelCWProxy {
  const _$ExpensesModelCWProxyImpl(this._value);

  final ExpensesModel _value;

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// ExpensesModel(...).copyWith(id: 12, name: "My name")
  /// ```
  ExpensesModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? expenseName = const $CopyWithPlaceholder(),
    Object? expenseValue = const $CopyWithPlaceholder(),
    Object? expenseDate = const $CopyWithPlaceholder(),
    Object? categoryID = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
    Object? categoryEname = const $CopyWithPlaceholder(),
    Object? categoryName = const $CopyWithPlaceholder(),
  }) {
    return ExpensesModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      expenseName: expenseName == const $CopyWithPlaceholder()
          ? _value.expenseName
          // ignore: cast_nullable_to_non_nullable
          : expenseName as String?,
      expenseValue: expenseValue == const $CopyWithPlaceholder()
          ? _value.expenseValue
          // ignore: cast_nullable_to_non_nullable
          : expenseValue as double?,
      expenseDate: expenseDate == const $CopyWithPlaceholder()
          ? _value.expenseDate
          // ignore: cast_nullable_to_non_nullable
          : expenseDate as DateTime?,
      categoryID: categoryID == const $CopyWithPlaceholder()
          ? _value.categoryID
          // ignore: cast_nullable_to_non_nullable
          : categoryID as int?,
      isSelected:
          isSelected == const $CopyWithPlaceholder() || isSelected == null
              ? _value.isSelected
              // ignore: cast_nullable_to_non_nullable
              : isSelected as bool,
      categoryEname: categoryEname == const $CopyWithPlaceholder()
          ? _value.categoryEname
          // ignore: cast_nullable_to_non_nullable
          : categoryEname as String?,
      categoryName: categoryName == const $CopyWithPlaceholder()
          ? _value.categoryName
          // ignore: cast_nullable_to_non_nullable
          : categoryName as String?,
    );
  }
}

extension $ExpensesModelCopyWith on ExpensesModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExpensesModel.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpensesModelCWProxy get copyWith => _$ExpensesModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesModel _$ExpensesModelFromJson(Map<String, dynamic> json) =>
    ExpensesModel(
      id: (json['id'] as num?)?.toInt(),
      expenseName: json['expenseName'] as String?,
      expenseValue: (json['expenseValue'] as num?)?.toDouble(),
      expenseDate: json['expenseDate'] == null
          ? null
          : DateTime.parse(json['expenseDate'] as String),
      categoryID: (json['categoryID'] as num?)?.toInt(),
      categoryEname: json['categoryEname'] as String?,
      categoryName: json['categoryName'] as String?,
    );

Map<String, dynamic> _$ExpensesModelToJson(ExpensesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expenseName': instance.expenseName,
      'expenseValue': instance.expenseValue,
      'expenseDate': instance.expenseDate?.toIso8601String(),
      'categoryID': instance.categoryID,
      'categoryName': instance.categoryName,
      'categoryEname': instance.categoryEname,
    };
