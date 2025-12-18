// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_down_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DropdownModelCWProxy {
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// DropdownModel(...).copyWith(id: 12, name: "My name")
  /// ```
  DropdownModel call({
    int? id,
    String? name,
    String? eName,
    bool selected,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDropdownModel.copyWith(...)`.
class _$DropdownModelCWProxyImpl implements _$DropdownModelCWProxy {
  const _$DropdownModelCWProxyImpl(this._value);

  final DropdownModel _value;

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored.
  ///
  /// Example:
  /// ```dart
  /// DropdownModel(...).copyWith(id: 12, name: "My name")
  /// ```
  DropdownModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? eName = const $CopyWithPlaceholder(),
    Object? selected = const $CopyWithPlaceholder(),
  }) {
    return DropdownModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      eName: eName == const $CopyWithPlaceholder()
          ? _value.eName
          // ignore: cast_nullable_to_non_nullable
          : eName as String?,
      selected: selected == const $CopyWithPlaceholder() || selected == null
          ? _value.selected
          // ignore: cast_nullable_to_non_nullable
          : selected as bool,
    );
  }
}

extension $DropdownModelCopyWith on DropdownModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDropdownModel.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$DropdownModelCWProxy get copyWith => _$DropdownModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropdownModel _$DropdownModelFromJson(Map<String, dynamic> json) =>
    DropdownModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      eName: json['eName'] as String?,
    );

Map<String, dynamic> _$DropdownModelToJson(DropdownModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'eName': instance.eName,
    };
