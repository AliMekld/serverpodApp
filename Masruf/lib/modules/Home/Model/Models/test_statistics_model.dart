import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'statistics_model.dart';

part 'test_statistics_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class StatisticsModel {
  final int? id;
  final double? totalIncome;
  final double? totalExpenses;
  final double? netSavings;
  final DateTime? lastUpdated;
  final List<StatisticsDetailModel> detailslist;

  const StatisticsModel({
    this.id,
    this.lastUpdated,
    this.netSavings,
    this.totalExpenses,
    this.totalIncome,
    this.detailslist = const [],
  });
  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);
}
