import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../../utilities/extensions.dart';

///todo make this widget generic but first lets create normal one
/// package data_table_2: ^2.5.15

///what this widget needs
/// 1- some model that represents rows
/// 2- some model that represents columns
/// 3-decoration of table
/// 4-maybe pagination
class GenericTableWidget<T> extends StatefulWidget {
  final List<DataRow2> rowsList;
  final double? minWidth;
  final List<CustomDataColumn> columnsList;
  final Function(bool? v)? onSelectAll;

  const GenericTableWidget({
    super.key,
    required this.rowsList,
    required this.columnsList,
    this.minWidth,
    this.onSelectAll,
  });

  @override
  State<StatefulWidget> createState() => _GenericTableWidgetState();
}

class _GenericTableWidgetState extends State<GenericTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dataTableTheme: const DataTableThemeData()),
      child: DataTable2(
        showBottomBorder: true,
        showHeadingCheckBox: widget.onSelectAll != null,
        columnSpacing: 4,
        empty: Text(
          'Empty!',
          style: TextStyleHelper.of(context).bodyLarge16R,
        ),
        onSelectAll: widget.onSelectAll,
        headingCheckboxTheme: CheckboxThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          checkColor: WidgetStatePropertyAll(
            ColorsPalette.of(context).secondaryColor,
          ),
          fillColor: WidgetStatePropertyAll(
            ColorsPalette.of(context).primaryColor,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        minWidth: widget.minWidth ?? 1200,
        headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        headingRowColor: WidgetStatePropertyAll(
          ColorsPalette.of(context).primaryColor,
        ),
        border: TableBorder.all(
          color: ColorsPalette.of(context).primaryTextColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),

        /// mapping model into table culumn
        columns: widget.columnsList
            .map(
              (e) => DataColumn2(
                label: Text(
                  e.title,
                  style: TextStyleHelper.of(context)
                      .bodyLarge16R
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ).centerWhen(true),
                numeric: e.numeric ?? false,
                fixedWidth: e.fixedWidth,
                size: e.columnSize ?? ColumnSize.M,
                onSort: (i, b) => e.onSort != null ? e.onSort!(i, b) : null,
              ),
            )
            .toList(),

        rows: widget.rowsList,

        sortArrowBuilder: (ascending, sorted) {
          return Icon(
            ascending
                ? Icons.keyboard_arrow_down_rounded
                : Icons.arrow_upward_rounded,
            color: sorted
                ? ColorsPalette.of(context).secondaryColor
                : ColorsPalette.of(context).secondaryTextColor,
            applyTextScaling: true,
            size: 24,
          );
        },
      ),
    );
  }
}

class CustomDataColumn {
  final ColumnSize? columnSize;
  final String title;
  final bool? numeric;
  final Function(int index, bool ascn)? onSort;
  final double? fixedWidth;

  CustomDataColumn({
    required this.title,
    this.numeric = false,
    this.onSort,
    this.columnSize,
    this.fixedWidth,
  });
}
