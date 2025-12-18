import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../Categories/View/categories_view.dart';
import '../Expenses/View/expenses_screen.dart';
import '../Home/home_screen.dart';
import '../Income/View/income_screen.dart';
import '../Profile/profile_screen.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../../widgets/Dialogs/settings_dialog.dart';
import '../../widgets/DialogsHelper/dialog_widget.dart';
import '../../widgets/custom_side_bar_widget.dart';

import '../../utilities/constants/assets.dart';
import 'main_layout_cubit.dart';

class MainLayout extends StatelessWidget {
  final String routeName;
  final Widget child;
  const MainLayout({
    super.key,
    required this.routeName,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        // buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
        final con = context.read<MainLayoutCubit>();

        return Scaffold(
          backgroundColor: ColorsPalette.of(context).backgroundColor,
          appBar: context.isMobile
              ? AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 28.r,
                      ),
                      onPressed: () => const DialogHelper.customDialog(
                              child: SettingsDialog())
                          .showDialog(context),
                    )
                  ],
                )
              : null,
          body: context.isMobile
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomNavigationRail(),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, top: 24, left: 16, right: 16),
                      child: child,
                    ).expand
                  ],
                ),
          floatingActionButtonLocation: context.isMobile
              ? FloatingActionButtonLocation.centerDocked
              : null,
          floatingActionButton: con.isCreateButtonVisible
              ? FloatingActionButton(
            onPressed: () =>con.onAddBasedOnScreen(context),
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: context.isMobile
              ? BottomNavigationBar(
                  elevation: 0.5,
                  backgroundColor: ColorsPalette.of(context).primaryColor,
                  currentIndex: state.currentIndex ?? 0,
                  selectedItemColor: ColorsPalette.of(context).primaryTextColor,
                  unselectedItemColor:
                      ColorsPalette.of(context).secondaryTextColor,
                  unselectedLabelStyle: TextStyleHelper.of(context)
                      .bodySmall12R
                      .copyWith(color: ColorsPalette.of(context).iconColor),
                  selectedLabelStyle: TextStyleHelper.of(context)
                      .bodyMedium14R
                      .copyWith(
                          color: ColorsPalette.of(context).primaryTextColor),
                  onTap: (v) {
                    con.onChangeSelected(v);
                    context.goNamed(menuList[v].route);
                  },
                  items: [
                    ...menuList.map(
                      (e) => BottomNavigationBarItem(
                        backgroundColor: ColorsPalette.of(context).buttonColor,
                        icon: SvgPicture.asset(
                          e.imgSvg,
                          height: 24.h,
                          width: 24.w,
                          colorFilter: ColorFilter.mode(
                            ColorsPalette.of(context).buttonColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: e.title.tr,
                      ),
                    ),
                  ],
                )
              : null,
        );
      }),
    );
  }
}

List<MenuModel> get menuList => _menuList;
List<MenuModel> _menuList = [
  MenuModel(
    index: 0,
    title: Strings.home,
    imgSvg: Assets.imagesHome,
    route: HomeScreen.routerName,
  ),
  MenuModel(
    index: 1,
    title: Strings.expenses,
    imgSvg: Assets.imagesExpenses,
    route: ExpensesScreen.routerName,
  ),
  MenuModel(
    index: 2,
    title: Strings.expensesCategories,
    imgSvg: Assets.imagesMenu,
    route: CategoriesScreen.routerName,
  ),
  MenuModel(
    index: 3,
    title: Strings.income,
    imgSvg: Assets.imagesIncome,
    route: IncomeScreen.routerName,
  ),
  MenuModel(
    index: 4,
    title: Strings.profile,
    imgSvg: Assets.imagesProfile,
    route: ProfileScreen.routerName,
  ),
];

class MenuModel {
  final int index;
  final String route;
  final String title;
  final String imgSvg;

  MenuModel(
      {required this.index,
      required this.route,
      required this.title,
      required this.imgSvg});
}
