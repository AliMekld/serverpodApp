// ignore_for_file: deprecated_member_use

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../core/theme/color_pallet.dart';

class TableHelper<T> extends DataTableSource {
  final Function(bool value)? onSelect;
  BuildContext context;
  final TextStyle? style;
  final bool isSelected;
  final List<T> dataList;
  final List<DataCell> Function(T item) getCells;
  final Function(int index)? onDoubleTap;
  TableHelper({
    this.onSelect,
    required this.dataList,
    required this.getCells,
    this.style,
    this.isSelected = false,
    this.onDoubleTap,
    required this.context,
  });
  @override
  DataRow2 getRow(int index) {
    return DataRow2.byIndex(
      onDoubleTap: () {
        if (onDoubleTap != null) {
          onDoubleTap!(index);
        }
      },
      selected: isSelected,
      color: index.isEven
          ? WidgetStatePropertyAll(
              isSelected
                  ? ColorsPalette.of(context).waitingColor .withValues(alpha:0.2)
                  : ColorsPalette.of(context)
                      .secondaryTextColor
                      .withValues(alpha:0.4),
            )
          : WidgetStatePropertyAll(
              isSelected
                  ? ColorsPalette.of(context).waitingColor .withValues(alpha:0.2)
                  : ColorsPalette.of(context)
                      .secondaryTextColor
                      .withValues(alpha:0.8),
            ),
      onSelectChanged: onSelect != null
          ? (v) {
              onSelect!(v!);
            }
          : null,
      // decoration: BoxDecoration(color: Colors.white),
      index: index,
      onLongPress: null,
      cells: getCells(dataList[index]),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => dataList.length;
}
