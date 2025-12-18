// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatisticsDetailModelCWProxy {
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// StatisticsDetailModel(...).copyWith(id: 12, name: "My name")
  /// ```
  StatisticsDetailModel call({
    int? id,
    String? lable,
    int? qty,
    int? totalQty,
    double? value,
    double? totalValue,
    List<StatisticsDetailModel> values,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStatisticsDetailModel.copyWith(...)`.
class _$StatisticsDetailModelCWProxyImpl
    implements _$StatisticsDetailModelCWProxy {
  const _$StatisticsDetailModelCWProxyImpl(this._value);

  final StatisticsDetailModel _value;

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// StatisticsDetailModel(...).copyWith(id: 12, name: "My name")
  /// ```
  StatisticsDetailModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lable = const $CopyWithPlaceholder(),
    Object? qty = const $CopyWithPlaceholder(),
    Object? totalQty = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? totalValue = const $CopyWithPlaceholder(),
    Object? values = const $CopyWithPlaceholder(),
  }) {
    return StatisticsDetailModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      lable: lable == const $CopyWithPlaceholder()
          ? _value.lable
          // ignore: cast_nullable_to_non_nullable
          : lable as String?,
      qty: qty == const $CopyWithPlaceholder()
          ? _value.qty
          // ignore: cast_nullable_to_non_nullable
          : qty as int?,
      totalQty: totalQty == const $CopyWithPlaceholder()
          ? _value.totalQty
          // ignore: cast_nullable_to_non_nullable
          : totalQty as int?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as double?,
      totalValue: totalValue == const $CopyWithPlaceholder()
          ? _value.totalValue
          // ignore: cast_nullable_to_non_nullable
          : totalValue as double?,
      values: values == const $CopyWithPlaceholder() || values == null
          ? _value.values
          // ignore: cast_nullable_to_non_nullable
          : values as List<StatisticsDetailModel>,
    );
  }
}

extension $StatisticsDetailModelCopyWith on StatisticsDetailModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStatisticsDetailModel.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$StatisticsDetailModelCWProxy get copyWith =>
      _$StatisticsDetailModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDetailModel _$StatisticsDetailModelFromJson(
        Map<String, dynamic> json) =>
    StatisticsDetailModel(
      id: (json['id'] as num?)?.toInt(),
      lable: json['lable'] as String?,
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      totalQty: (json['totalQty'] as num?)?.toInt() ?? 1,
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      totalValue: (json['totalValue'] as num?)?.toDouble() ?? 0.0,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) =>
                  StatisticsDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StatisticsDetailModelToJson(
        StatisticsDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lable': instance.lable,
      'value': instance.value,
      'qty': instance.qty,
      'totalQty': instance.totalQty,
      'totalValue': instance.totalValue,
      'values': instance.values.map((e) => e.toJson()).toList(),
    };
