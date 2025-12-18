import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/Language/app_localization.dart';
import '../../../core/network_checker.dart';
import '../../../core/theme/typography.dart';
import '../Controller/categories_bloc.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/tables/categories_table.dart';

import '../../../utilities/constants/Strings.dart';
import '../../../widgets/custom_drop_down_widget.dart';
import '../Model/Repository/categories_repository_imp.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routerName = 'CategoriesScreen';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return BlocProvider<CategoriesBloc>(
      create: (context) =>
          CategoriesBloc( CategoriesRepositoryImp(networkCheckerNotifier:  context.read<NetworkCheckerNotifier>()))..add(LoadCategoriesEvent()),
      child: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final con = context.read<CategoriesBloc>();
          final state = context.watch<CategoriesBloc>().state;

          return LoadingWidget(
            isLoading: state.loading ?? false,
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
                            Strings.expensesCategories.tr,
                            style: TextStyleHelper.of(context).bodyLarge16R,
                          ),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 220,
                            controller: con.searchController,
                            onSaved: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadCategoriesEvent());
                              } else {
                                con.add(FilterLoadedCategoriesEvent(v));
                              }
                            },
                          ),
                          CustomDropdownWidget(
                            width: 220,
                            items: CategoriesKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.expensesCategories.tr,
                            style: TextStyleHelper.of(context).headlineSmall24R,
                          ),
                          const Spacer(),
                          CustomTextFieldWidget(
                            hintText: Strings.search.tr,
                            width: 320.w,
                            controller: con.searchController,
                            onChanged: (v) {
                              if (v?.isEmpty ?? false) {
                                con.add(LoadCategoriesEvent());
                              } else {
                                con.add(FilterLoadedCategoriesEvent(v));
                              }
                            },
                          ),
                          16.0.widthBox,
                          CustomDropdownWidget(
                            width: 180.w,
                            items: CategoriesKeyType.values
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.keyName.tr,
                                    )))
                                .toList(),
                            onChanged: (v) =>
                                con.add(ChangeFilterKeyTypeEvent(v)),
                            selectedItem: state.keyType,
                            bgColor: Colors.white,
                          ),
                        ],
                      ),
                16.0.heightBox,
                CategoriesTable(
                  onDeleteCategory: (id) => con.add(DeleteCategoryEvent(id)),
                  onEditCategory: (m) => con.add(InsertCategoryEvent(m)),
                  categoriesList: con.state.categoriesList,

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
