import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Language/app_localization.dart';
import '../../../core/network_checker.dart';
import '../../../core/theme/typography.dart';
import '../../../utilities/constants/Strings.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/DashboardStatisticksWidgets/linear_analatical_widget.dart';
import '../../../widgets/DashboardStatisticksWidgets/pie_chart_widget.dart';
import '../../../widgets/loading_widget.dart';
import 'Controller/home_bloc.dart';
import 'Model/Models/statistics_model.dart';
import 'Model/Models/test_statistics_model.dart';
import 'Model/Repository/home_repository_imp.dart';
import 'View/Widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          HomeRepositoryImp(networkCheckerNotifier: context.read<NetworkCheckerNotifier>()))
        ..add(LoadHomeDataEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return LoadingWidget(
            isLoading: state.isLoading,
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Text(
                    Strings.dashboard.tr,
                    style: TextStyleHelper.of(context).headlinelarge32R,
                  ),
                  onPressed: () {},
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.4,
                      child: CardWidget(
                          width: context.width,
                          height: 382.h,
                          child: CustomPieChartWidget(
                            data: state.statisticsModel?.copyWith(
                                  detailslist: [
                                    StatisticsDetailModel(
                                      id: 1,
                                      lable: Strings.income.tr,
                                      totalValue:
                                          state.statisticsModel?.totalIncome ?? 0,
                                    ),
                                    StatisticsDetailModel(
                                      id: 2,
                                      lable: Strings.expenses.tr,
                                      totalValue:
                                          state.statisticsModel?.totalExpenses ?? 0,
                                    )
                                  ],
                                ) ??
                                const StatisticsModel(),
                          )),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.58,
                      child: CardWidget(
                        width: context.width,
                        height: 382.h,
                        child: const LinerAnalyticsWidget(
                          series: [],
                          titles: [],
                        ).addPaddingAll(padding: 8.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.58,
                      child: CardWidget(
                        width: context.width,
                        height: 382.h,
                        child: const LinerAnalyticsWidget(
                          series: [],
                          titles: [],
                        ).addPaddingAll(padding: 8.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.4,
                      child: CardWidget(
                          width: context.width,
                          height: 382.h,
                          child: CustomPieChartWidget(
                            data: state.statisticsModel?.copyWith(
                                  detailslist: [
                                    StatisticsDetailModel(
                                      id: 1,
                                      lable: Strings.income.tr,
                                      totalValue:
                                          state.statisticsModel?.totalIncome ?? 0,
                                    ),
                                    StatisticsDetailModel(
                                      id: 2,
                                      lable: Strings.expenses.tr,
                                      totalValue:
                                          state.statisticsModel?.totalExpenses ?? 0,
                                    )
                                  ],
                                ) ??
                                const StatisticsModel(),
                          )),
                    ),
                  ],
                ),
              ],
            ).withVerticalScrollWhen(true),
          );
        },
      ),
    );
  }
}
