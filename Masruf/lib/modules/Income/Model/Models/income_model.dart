import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class IncomeModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;
  final int? id;
  final String? incomeName;
  final double? incomeValue;
  final DateTime? incomeDate;

  IncomeModel({
    this.id,
    this.incomeName,
    this.incomeValue,
    this.incomeDate,
    this.isSelected = false,
  });

  ///
  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}
