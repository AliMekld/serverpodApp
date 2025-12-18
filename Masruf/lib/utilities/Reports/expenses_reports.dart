import '../../modules/Expenses/Model/Models/expense_model.dart';
import '../PDFHelper/pdf_widgets.dart';
import '../../widgets/tables/expense_table.dart';
import 'package:pdf/widgets.dart';

class ExpensesReportsBuilder {
  final List<ExpensesModel> expensesList;
  ExpensesReportsBuilder({required this.expensesList});

  buildReportPage() async {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 0.5)),
          await PdfWidgets().getTableheader([
            ReportModel(title: 'الرقم', flex: 1),
            ReportModel(title: 'الاسم', flex: 1),
            ReportModel(title: 'المبلغ', flex: 1),
            ReportModel(title: 'التاريح', flex: 1),
            ReportModel(title: 'الفئه', flex: 1),
          ]),
          await PdfWidgets().getReportBodyListView(
            List.generate(
                expensesList.length,
                (index) => [
                      ReportModel(
                        title: expensesList[index].id?.toString(),
                        flex: 1,
                      ),
                      ReportModel(
                        title: expensesList[index].expenseName ?? '',
                        flex: 1,
                      ),
                      ReportModel(
                        title:
                            expensesList[index].expenseValue?.toString() ?? '',
                        flex: 1,
                      ),
                      ReportModel(
                        title: expensesList[index].expenseDate?.dmy,
                        flex: 1,
                      ),
                      ReportModel(
                        title: expensesList[index].categoryName,
                        flex: 1,
                      ),
                    ]),
          ),
        ]);
  }
}
