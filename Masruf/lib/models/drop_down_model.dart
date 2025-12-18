import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_down_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class DropdownModel extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
   final bool selected;
  final int? id;
  final String? name;
  final String? eName;

  const DropdownModel({
    this.id,
    this.name,
    this.eName,
    this.selected = false,
  });
  factory DropdownModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownModelFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownModelToJson(this);

  @override
  List<Object?> get props =>[
    id,
    name,
    eName,
  ];
}
