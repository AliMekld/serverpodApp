import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../../modules/Income/Model/Models/income_model.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../Dialogs/income_dialog_detail_widget.dart';
import '../DialogsHelper/dialog_widget.dart';
import '../GenericTable/table_helper.dart';
import '../GenericTable/table_widget.dart';
import 'expense_table.dart';

// ignore: must_be_immutable
class IncomeTable<T extends IncomeModel> extends StatefulWidget {
  /// todo nrmy da fe el zebala wncreate table ndeef b3d manzakr ezay el tables bttcreate
  List<IncomeModel> incomeList;
  final BuildContext context;
  final Function(IncomeModel) onEditIncome;
  final Function(int) onDeleteIncome;

  IncomeTable({
    required this.context,
    super.key,
    required this.incomeList,
    required this.onEditIncome,
    required this.onDeleteIncome,
  });

  @override
  State<IncomeTable> createState() => _IncomeTableState();
}

class _IncomeTableState<T extends IncomeModel> extends State<IncomeTable<T>> {
  /// a columns List
  List<CustomDataColumn> getCulumnsList(BuildContext context) => [
        CustomDataColumn(
          title: AppLocalizations.of(context)?.translate(Strings.id) ?? '',
          columnSize: ColumnSize.S,
          numeric: true,
          onSort: (index, asend) {
            setState(() {
              widget.incomeList.sort.call((a, b) {
                final aId = a.id ?? 0;
                final bId = b.id ?? 0;
                return asend ? aId.compareTo(bId) : bId.compareTo(aId);
              });
            });
          },
        ),
        CustomDataColumn(
            title: Strings.incomeName.tr, columnSize: ColumnSize.L),
        CustomDataColumn(
            title: Strings.incomeValue.tr, columnSize: ColumnSize.L),
        CustomDataColumn(
            title: Strings.incomeDate.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.delete.tr, columnSize: ColumnSize.S),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<IncomeModel>(
      minWidth: getCulumnsList(context).length * 96.w,
      onSelectAll: (v) {
        widget.incomeList =
            widget.incomeList.map((e) => e.copyWith(isSelected: v??false)).toList();
        setState(() {});
      },
      columnsList: getCulumnsList(context),
      rowsList: _getRows(),
    );
  }

  List<DataRow2> _getRows() {
    return widget.incomeList
        .mapIndexed((i, e) => TableHelper<IncomeModel>(
              context: context,
              onDoubleTap: (index) {
                if (widget.incomeList[index].id != null) {
                  DialogHelper.customDialog(
                      child: IncomeDialogDetailWidget(
                    onEditIcome: (model) => widget.onEditIncome(model),
                    id: widget.incomeList[index].id,
                  )).showDialog(context);
                }
              },
              isSelected: widget.incomeList[i].isSelected,
              onSelect: (v) {
                widget.incomeList[i].isSelected = v;
                setState(() {});
              },
              dataList: widget.incomeList,
              getCells: (w) => _getCells(w, widget.context),
            ).getRow(i))
        .toList();
  }

  List<DataCell> _getCells(IncomeModel incomeModel, BuildContext context) {
    return [
      DataCell(
        Text(
          '${incomeModel.id?.toString().trim()}',
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(incomeModel.incomeName ?? '',
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(
          incomeModel.incomeValue?.toString() ?? '',
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(
          incomeModel.incomeDate?.dmy ?? '',
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        IconButton(
          hoverColor: ColorsPalette.of(context).errorColor,
          onPressed: () {
            if (incomeModel.id != null) {
              DialogHelper.delete(
                  message: Strings.deleteCategoryWarningMessage.tr,
                  onConfirm: () {
                    widget.onDeleteIncome(incomeModel.id!);
                    context.pop();
                  }).showDialog(context);
            }
          },
          icon: Icon(
            Icons.delete,
            size: 28.r,
            color: ColorsPalette.of(context).iconColor,
          ),
        ).centerWhen(true),
      )
    ];
  }
}
