// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IncomeModelCWProxy {
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// IncomeModel(...).copyWith(id: 12, name: "My name")
  /// ```
  IncomeModel call({
    int? id,
    String? incomeName,
    double? incomeValue,
    DateTime? incomeDate,
    bool isSelected,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIncomeModel.copyWith(...)`.
class _$IncomeModelCWProxyImpl implements _$IncomeModelCWProxy {
  const _$IncomeModelCWProxyImpl(this._value);

  final IncomeModel _value;

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// IncomeModel(...).copyWith(id: 12, name: "My name")
  /// ```
  IncomeModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? incomeName = const $CopyWithPlaceholder(),
    Object? incomeValue = const $CopyWithPlaceholder(),
    Object? incomeDate = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
  }) {
    return IncomeModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      incomeName: incomeName == const $CopyWithPlaceholder()
          ? _value.incomeName
          // ignore: cast_nullable_to_non_nullable
          : incomeName as String?,
      incomeValue: incomeValue == const $CopyWithPlaceholder()
          ? _value.incomeValue
          // ignore: cast_nullable_to_non_nullable
          : incomeValue as double?,
      incomeDate: incomeDate == const $CopyWithPlaceholder()
          ? _value.incomeDate
          // ignore: cast_nullable_to_non_nullable
          : incomeDate as DateTime?,
      isSelected:
          isSelected == const $CopyWithPlaceholder() || isSelected == null
              ? _value.isSelected
              // ignore: cast_nullable_to_non_nullable
              : isSelected as bool,
    );
  }
}

extension $IncomeModelCopyWith on IncomeModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIncomeModel.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$IncomeModelCWProxy get copyWith => _$IncomeModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) => IncomeModel(
      id: (json['id'] as num?)?.toInt(),
      incomeName: json['incomeName'] as String?,
      incomeValue: (json['incomeValue'] as num?)?.toDouble(),
      incomeDate: json['incomeDate'] == null
          ? null
          : DateTime.parse(json['incomeDate'] as String),
    );

Map<String, dynamic> _$IncomeModelToJson(IncomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incomeName': instance.incomeName,
      'incomeValue': instance.incomeValue,
      'incomeDate': instance.incomeDate?.toIso8601String(),
    };
