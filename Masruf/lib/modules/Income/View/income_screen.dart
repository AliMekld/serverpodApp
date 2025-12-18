import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Language/app_localization.dart';
import '../../../core/network_checker.dart';
import '../../../core/theme/typography.dart';
import '../../../utilities/constants/Strings.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/custom_drop_down_widget.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/tables/income_table.dart';
import '../Controller/income_bloc.dart';
import '../Model/Repository/income_repository_imp.dart';

class IncomeScreen extends StatelessWidget {
  static const String routerName = 'IncomeScreen';
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return BlocProvider<IncomeBloc>(
      create: (context) => IncomeBloc(IncomeRepositoryImp(
          networkCheckerNotifier: context.read<NetworkCheckerNotifier>()))
        ..add(LoadIncomeEvent()),
      child: BlocConsumer<IncomeBloc, IncomeState>(
        listener: (context, state) {
           if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          final con = context.read<IncomeBloc>();
          return LoadingWidget(
            isLoading: state.isLoading,
            child: Column(
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
                            Strings.income.tr,
                            style: TextStyleHelper.of(context).bodyLarge16R,
                          ),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 220,
                            controller: con.searchController,
                            onSaved: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadIncomeEvent());
                              } else {
                                con.add(FilterIncomeEvent(v));
                              }
                            },
                          ),
                          CustomDropdownWidget(
                            width: 220,
                            items: IncomeKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeIncomeFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.income.tr,
                            style: TextStyleHelper.of(context).headlineSmall24R,
                          ),
                          const Spacer(),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 320.w,
                            controller: con.searchController,
                            onChanged: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadIncomeEvent());
                              } else {
                                con.add(FilterIncomeEvent(v));
                              }
                            },
                          ),
                          16.0.widthBox,
                          CustomDropdownWidget(
                            width: 180.w,
                            items: IncomeKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeIncomeFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      ),
                16.0.heightBox,
                IncomeTable(
                  onDeleteIncome: (id) => con.add(DeleteIncomeEvent(id)),
                  onEditIncome: (model) {
                     final index = state.incomeList
                        .indexWhere((e) => e.id == model.id);
                    if (index == -1) {
                      con.add(InsertIncomeEvent(model));
                    } else {
                      con.add(UpdateIncomeEvent(model, index));
                    }
                  },
                  incomeList: state.incomeList,
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
