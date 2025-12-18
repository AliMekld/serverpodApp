import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class ExpensesModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;
  final int? id;
  final String? expenseName;
  final double? expenseValue;
  final DateTime? expenseDate;
  final int? categoryID;
  final String? categoryName;
  final String? categoryEname;

  ExpensesModel({
    this.id,
    this.expenseName,
    this.expenseValue,
    this.expenseDate,
    this.categoryID,
    this.isSelected = false,
    this.categoryEname,
    this.categoryName,
  });

  ///
  factory ExpensesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpensesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesModelToJson(this);

  ///
  Map<String, dynamic> toLocalJson() => {
        'id': id,
        'expenseName': expenseName?.toString(),
        'expenseValue': expenseValue?.toString(),
        'expenseDate': expenseDate?.toIso8601String(),
        'categoryID': categoryID?.toString(),
        'categoryName': categoryName?.toString(),
        'categoryEname': categoryEname?.toString(),
      };
}
