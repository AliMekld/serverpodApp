import 'package:flutter/services.dart';
import '../../core/Language/app_localization.dart';
import '../constants/Strings.dart';
import '../../widgets/tables/expense_table.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../constants/assets.dart';

class PDFConfig {
  static Font? _ttf;
  static Uint8List? iconImage;
  static Future<void> loadFont() async {
    // Wait for the font data to load
    final fontData =
        await rootBundle.load(Assets.fontsNotoKufiArabicVariableFontWght);
    // Convert the font data to a Font object
    _ttf = Font.ttf(fontData.buffer.asByteData());
    iconImage = (await rootBundle.load(
      Assets.imagesAppLogo,
    ))
        .buffer
        .asUint8List();
  }

  ///
  static TextStyle k8TextStyle = TextStyle(font: _ttf, fontSize: 8);
  static TextStyle k12TextStyle = TextStyle(font: _ttf, fontSize: 12);
  static TextStyle k14TextStyle = TextStyle(font: _ttf, fontSize: 14);
  static TextStyle k16TextStyle = TextStyle(font: _ttf, fontSize: 16);
  static TextStyle k18TextStyle = TextStyle(font: _ttf, fontSize: 18);
  static TextStyle k20TextStyle = TextStyle(font: _ttf, fontSize: 20);
  static TextStyle k24TextStyle = TextStyle(font: _ttf, fontSize: 24);
  static TextStyle k28TextStyle = TextStyle(font: _ttf, fontSize: 28);
  static TextStyle k36TextStyle = TextStyle(font: _ttf, fontSize: 36);
}

/// [header]
class PdfWidgets {
  get getDivider => Divider(height: 1);

  Future<Widget> getheader() async {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.appName.tr,
          style: PDFConfig.k16TextStyle.copyWith(fontSize: 12),
          textDirection: TextDirection.rtl,
        ),
        Text(
          'تقرير المصروفات',
          style: PDFConfig.k16TextStyle.copyWith(fontSize: 12),
          textDirection: TextDirection.rtl,
        ),
        Text(
          DateTime.now().dmy,
          style: PDFConfig.k16TextStyle.copyWith(fontSize: 12),
          textDirection: TextDirection.rtl,
        ),
      ],
    ));
  }

  Future<Widget> getTableheader(List<ReportModel> list) async {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: PdfColors.grey200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ...list.map((e) => Text(
                e.title ?? '-',
                style: PDFConfig.k16TextStyle,
                textDirection: e.textDirection ?? TextDirection.rtl,
                textAlign: TextAlign.center,
              ).expandFlex(e.flex ?? 1))
        ]));
  }

  buildRow(List<ReportModel> items) {
    return Row(children: [
      ...items.map(
        (e) => Text(
          e.title ?? '',
          style: e.textStyle ?? PDFConfig.k16TextStyle,
          textDirection: e.textDirection ?? TextDirection.rtl,
          textAlign: e.textAlign ?? TextAlign.center,
        ).expandFlex(e.flex ?? 1),
      ),
    ]);
  }

  /// [listItems]
  buildFooter() {
    return Row(children: [
      Divider().expand,
      Text(
        ' ( page - 1 ) ',
        style: PDFConfig.k16TextStyle,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
      Divider().expand,
    ]);
  }

  Future<Widget> getReportBodyListView(
      List<List<ReportModel>> reportList) async {
    return Container(
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: PdfColors.grey50,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            border: Border.all(
              color: PdfColors.grey900,
              width: 0.2,
            )),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return buildRow(reportList[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0.5);
          },
          itemCount: reportList.length,
        ).expand);
  }
}

/// [ROW]

extension PDFWidgetsExtension on Widget {
  Padding addPaddingVertical(double p) =>
      Padding(padding: EdgeInsets.symmetric(vertical: p), child: this);
  Widget expandFlex(int? flex) => flex == null
      ? this
      : Expanded(
          flex: flex,
          child: this,
        );
  Expanded get expand => Expanded(child: this);
}

class ReportModel {
  final String? title;
  final TextStyle? textStyle;
  final int? flex;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  ReportModel({
    this.title,
    this.textStyle,
    this.flex,
    this.textDirection,
    this.textAlign,
  });
}
