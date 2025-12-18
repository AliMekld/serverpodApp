import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/Language/app_localization.dart';
import '../../../core/network_checker.dart';
import '../../../core/theme/color_pallet.dart';
import '../../../core/theme/typography.dart';
import '../../../utilities/PDFHelper/pdf_builder.dart';
import '../../../utilities/Reports/expenses_reports.dart';
import '../../../utilities/constants/Strings.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/custom_drop_down_widget.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/tables/expense_table.dart';
import '../Controller/expenses_bloc.dart';
import '../Model/Repository/expenses_repository_imp.dart';

class ExpensesScreen extends StatelessWidget {
  static const String routerName = 'expensesScreen';
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return BlocProvider<ExpensesBloc>(
      create: (context) => ExpensesBloc(ExpensesRepositoryImp(
          networkCheckerNotifier: context.read<NetworkCheckerNotifier>()))
        ..add(LoadExpensesEvent()),
      child: BlocConsumer<ExpensesBloc, ExpensesState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            // Show error dialog/snackbar if needed
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          final con = context.read<ExpensesBloc>();

          return LoadingWidget(
            isLoading: state.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.isTabletOrMobile
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            Strings.expenses.tr,
                            style: TextStyleHelper.of(context).bodyLarge16R,
                          ),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 220,
                            controller: con.searchController,
                            onSaved: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadExpensesEvent());
                              } else {
                                con.add(FilterExpensesEvent(v));
                              }
                            },
                          ),
                          CustomDropdownWidget(
                            width: 220,
                            items: ExpensesKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeExpensesFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.expenses.tr,
                            style: TextStyleHelper.of(context).headlineSmall24R,
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                ExpensesReportsBuilder expensesReportsBuilder =
                                    ExpensesReportsBuilder(
                                  expensesList: state.expensesList,
                                );
                                await expensesReportsBuilder
                                    .buildReportPage()
                                    .then((f) {
                                  PdfBuilder.createPDF(f);
                                });
                              },
                              icon: Icon(
                                Icons.print,
                                color: ColorsPalette.of(context).secondaryColor,
                              )),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 320.w,
                            controller: con.searchController,
                            onChanged: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadExpensesEvent());
                              } else {
                                con.add(FilterExpensesEvent(v));
                              }
                            },
                          ),
                          16.0.widthBox,
                          CustomDropdownWidget(
                            width: 160.w,
                            items: ExpensesKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeExpensesFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      ),
                16.0.heightBox,
                ExpenseTable(
                  onDeleteExpense: (id) => con.add(DeleteExpenseEvent(id)),
                  onEditExpense: (model) {
                    final index = state.expensesList
                        .indexWhere((e) => e.id == model.id);
                    if (index == -1) {
                      con.add(InsertExpenseEvent(model));
                    } else {
                      con.add(UpdateExpenseEvent(model, index));
                    }
                  },
                  expensesList: state.expensesList,
                  context: context,
                ).expand,
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomPdfViewer extends StatelessWidget {
  final File filePath;

  const CustomPdfViewer({super.key, required this.filePath});
  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(filePath);
  }
}
