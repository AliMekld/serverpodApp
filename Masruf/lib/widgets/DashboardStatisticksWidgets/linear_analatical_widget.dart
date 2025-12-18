import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../../modules/Home/Model/Models/statistics_model.dart';
import '../../utilities/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/constants/assets.dart';

class LinerAnalyticsWidget extends StatefulWidget {
  final bool enableZooming, showMarkers, formatLabelToCurrency;
  final List<String> titles;
  final String? chartTitle;
  final TextStyle? chartTitleStyle;
  final List<List<StatisticsDetailModel>> series;
  final List<Color>? palette;
  final String? Function(StatisticsDetailModel, int)? xValueMapper;
  final num? Function(StatisticsDetailModel, int)? yValueMapper;
  final String? Function(StatisticsDetailModel, int)? dataLabelMapper;

  const LinerAnalyticsWidget({
    super.key,
    required this.series,
    required this.titles,
    this.chartTitle,
    this.chartTitleStyle,
    this.enableZooming = true,
    this.showMarkers = true,
    this.formatLabelToCurrency = true,
    this.palette,
    this.xValueMapper,
    this.yValueMapper,
    this.dataLabelMapper,
  });

  @override
  State<LinerAnalyticsWidget> createState() => _LinerAnalyticsWidgetState();
}

class _LinerAnalyticsWidgetState extends State<LinerAnalyticsWidget> {
  List<Color> get _palette => [
        ColorsPalette.of(context).primaryColor,
        ColorsPalette.of(context).secondaryColor,
      ];

  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePanning: true,
    enableDoubleTapZooming: true,
    enableSelectionZooming: true,
    selectionRectColor: Colors.green,
    enablePinching: true,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SfCartesianChart(
          zoomPanBehavior: widget.enableZooming ? _zoomPanBehavior : null,
          crosshairBehavior: CrosshairBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            shouldAlwaysShow: true,
            lineColor: ColorsPalette.of(context).secondaryColor,
            lineWidth: 1.5,
          ),
          borderWidth: 2,
          borderColor: Colors.transparent,
          palette: widget.palette ?? _palette,
          selectionGesture: ActivationMode.singleTap,
          primaryYAxis: NumericAxis(
            labelStyle: TextStyleHelper.of(context).bodySmall12R,
          ),
          primaryXAxis: CategoryAxis(
            arrangeByIndex: true,
            labelStyle: TextStyleHelper.of(context).bodySmall12R,
          ),
          title: ChartTitle(
            alignment: ChartAlignment.far,
            text: widget.chartTitle ?? '',
            textStyle: widget.chartTitleStyle,
          ),
          enableSideBySideSeriesPlacement: true,
          legend: Legend(
            iconWidth: 16.w,
            iconHeight: 16.h,
            isVisible: true,
            alignment: ChartAlignment.center,
            isResponsive: true,
            textStyle: TextStyleHelper.of(context).bodyMedium14R,
            position: LegendPosition.top,
            overflowMode: LegendItemOverflowMode.scroll,
            borderWidth: 2,
            shouldAlwaysShowScrollbar: true,
          ),
          series: widget.series.mapIndexed((index, e) {
            /// TODO CHOSE ONE FROM THOSE
            /// you can select each type from those
            /// CURRENT[SplineAreaSeries] as in figma
            /// OLD [LineSeries]
            /// ColumnSeries
            /// SplineSeries
            /// StackedBarSeries
            /// StackedColumnSeries
            /// StepAreaSeries
            /// WaterfallSeries
            /// FastLineSeries
            return SplineAreaSeries<StatisticsDetailModel, String>(
              opacity: 0.6,
              borderWidth: 3,
              animationDelay: 0,
              animationDuration: 0,
              borderColor: widget.palette?[index] ?? _palette[index],
              borderDrawMode: BorderDrawMode.top,
              name: widget.titles[index],
              initialIsVisible: true,
              legendIconType: LegendIconType.circle,
              legendItemText: widget.titles[index],
              dataSource: e,
              markerSettings: MarkerSettings(
                isVisible: widget.showMarkers,
                color: ColorsPalette.of(context).successColor,
              ),
              xValueMapper: widget.xValueMapper ??
                  (StatisticsDetailModel data, _) => data.lable,
              yValueMapper: widget.yValueMapper ??
                  (StatisticsDetailModel data, _) => data.value,
              dataLabelMapper: widget.dataLabelMapper ??
                  (StatisticsDetailModel data, _) => data.value.toString(),
              emptyPointSettings: const EmptyPointSettings(
                mode: EmptyPointMode.drop,
              ),
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                color: ColorsPalette.of(context).backgroundColor,
                textStyle: TextStyleHelper.of(context).lableSmall11M,
                showZeroValue: true,
                useSeriesColor: true,
                borderRadius: 24.r,
                showCumulativeValues: true,
              ),
            );
          }).toList(),
        ),
        if (widget.enableZooming)
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: ColorsPalette.of(context).primaryColor,
                  onPressed: () {
                    _zoomPanBehavior.zoomIn();
                    setState(() {});
                  },
                  icon: SvgPicture.asset(
                    Assets.imagesPlus,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      ColorsPalette.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                // const Spacer(),
                TextButton(

                  onPressed: () {
                    _zoomPanBehavior.reset();
                  },
                  child: Text(
                    'zoom',
                    style: TextStyleHelper.of(context).bodyLarge16R,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _zoomPanBehavior.zoomOut();
                    setState(() {});
                  },
                  color: ColorsPalette.of(context).primaryColor,
                  icon: SvgPicture.asset(
                    Assets.imagesMinus,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      ColorsPalette.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ).widthBox(200.w),
          ),
      ],
    );
  }
}
