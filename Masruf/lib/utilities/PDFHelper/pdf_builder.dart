import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pdf_widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfBuilder {
  ///
  static Future openDocument(File file) async {
    final url = file.path;
    await OpenFile.open(url, type: 'pdf');
  }

  ///
  static createPDF(pw.Widget page) async {
    final header = await PdfWidgets().getheader();
    final footer = PdfWidgets().buildFooter();

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      margin: pw.EdgeInsets.all(16.dm),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      textDirection: pw.TextDirection.rtl,
      maxPages: 1000,
      header: (context) => header,
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.portrait,
      footer: (context) => footer,
      build: (c) => [page],
      mainAxisAlignment: pw.MainAxisAlignment.start,
    ));
    return saveDocument(name: 'myExpense.pdf', pdf: pdf);
  }

  ///
  static saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File(join(dir.path, name));
    await file.writeAsBytes(bytes, flush: true);
    await openDocument(file);
    return file;
  }
}
