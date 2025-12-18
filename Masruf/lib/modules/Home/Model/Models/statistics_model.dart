import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class StatisticsDetailModel {
  final int? id;
  final String? lable;
  final double? value;
  final int? qty;
  final int? totalQty;
  final double? totalValue;
  final List<StatisticsDetailModel> values;

  const StatisticsDetailModel({
    this.id,
    this.lable,
    this.qty = 1,
    this.totalQty = 1,
    this.value = 0.0,
    this.totalValue = 0.0,
    this.values = const [],
  });
  factory StatisticsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsDetailModelToJson(this);
}
