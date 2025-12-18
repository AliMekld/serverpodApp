import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../../models/drop_down_model.dart';
import '../../modules/Categories/Controller/categories_bloc.dart';
import '../../modules/Categories/View/Widgets/categoty_dialog_detail_widget.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../DialogsHelper/dialog_widget.dart';
import '../GenericTable/table_helper.dart';
import '../GenericTable/table_widget.dart';
import '../../modules/Expenses/Model/Models/expense_model.dart';

// ignore: must_be_immutable
class CategoriesTable<T extends DropdownModel> extends StatefulWidget {
  final List<DropdownModel> categoriesList;
  final BuildContext context;
  final Function(DropdownModel) onEditCategory;
  final Function(int) onDeleteCategory;

  const CategoriesTable({
    required this.context,
    super.key,
    required this.categoriesList,
    required this.onEditCategory,
    required this.onDeleteCategory,
  });

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState<T extends DropdownModel>
    extends State<CategoriesTable<T>> {
  /// a columns List
  List<CustomDataColumn> getColumnsList(BuildContext context) => [
        CustomDataColumn(
          title: AppLocalizations.of(context)?.translate(Strings.id) ?? '',
          columnSize: ColumnSize.S,
          numeric: true,
          onSort: (index, asnd) {
            setState(() {
              widget.categoriesList.sort.call((a, b) {
                final aId = a.id ?? 0;
                final bId = b.id ?? 0;
                return asnd ? aId.compareTo(bId) : bId.compareTo(aId);
              });
            });
          },
        ),
        CustomDataColumn(title: Strings.name.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.eName.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.delete.tr, columnSize: ColumnSize.S),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<ExpensesModel>(
      minWidth: getColumnsList(context).length * 96.w,
      onSelectAll: (v) =>
          context.read<CategoriesBloc>().add(ChangeSelectAllCategoryEvent(v)),
      columnsList: getColumnsList(context),
      rowsList: _getRows(),
    );
  }

  List<DataRow2> _getRows() {
    return widget.categoriesList
        .mapIndexed((i, e) => TableHelper<DropdownModel>(
              context: context,
              onDoubleTap: (index) async {
                if (widget.categoriesList[i].id != null) {
                  await DialogHelper.customDialog(
                      child: CategoryDialogDetailWidget(
                    id: widget.categoriesList[i].id,
                    onInsertUpdateCategory: (model) {
                      if (model != null) {}
                      widget.onEditCategory(model!);
                    },
                  )).showDialog(context);
                }
              },
              isSelected: widget.categoriesList[i].selected,
              onSelect: (v) => context
                  .read<CategoriesBloc>()
                  .add(ChangeSelectedCategoryEvent(i, v)),
              dataList: widget.categoriesList,
              getCells: (w) => _getCells(w, widget.context),
            ).getRow(i))
        .toList();
  }

  List<DataCell> _getCells(DropdownModel expenseModel, BuildContext context) {
    return [
      DataCell(
        Text(
          '${expenseModel.id?.toString().trim()}',
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.name ?? '',
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.eName ?? '',
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        IconButton(
          hoverColor: ColorsPalette.of(context).errorColor,
          onPressed: () {
            if (expenseModel.id != null) {
              DialogHelper.delete(
                  message: Strings.deleteCategoryWarningMessage.tr,
                  onConfirm: () {
                    widget.onDeleteCategory(expenseModel.id!);
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
