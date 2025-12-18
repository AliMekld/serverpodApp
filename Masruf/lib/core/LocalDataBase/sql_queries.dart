class SqlQueries {
  SqlQueries._();

  ///=============================[queries]====================================
  static const String expensesTable = 'expensesTable';
  static const String categoriesTable = 'categoryTable';
  static const String incomeTable = 'incomeTable';
  // static const String statisticsDetail = "statisticsDetail";
  static const String statisticsTable = 'statisticsTable';

  ///==========>> CREATE EXPENSES TABLE <<================
  static String get createExpensesTable {
    return '''
    CREATE TABLE $expensesTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expenseName TEXT,
    expenseValue REAL,
    expenseDate TEXT,
    categoryID INTEGER,
    categoryName TEXT,
    categoryEname TEXT,
    FOREIGN KEY (categoryName) REFERENCES $categoriesTable (name),
    FOREIGN KEY (categoryEname) REFERENCES $categoriesTable (eName),
    FOREIGN KEY (categoryID) REFERENCES $categoriesTable (id)
    )
    ''';
  }

  static String get createIncomeTable {
    return '''
    CREATE TABLE $incomeTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    incomeName TEXT,
    incomeValue REAL,
    incomeDate TEXT
    )
    ''';
  }

  static String get createCategoriesTable {
    return '''
    CREATE TABLE $categoriesTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    eName TEXT
    )
    ''';
  }

  static String get createStatisticsTable {
    return '''
  CREATE TABLE $statisticsTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  totalIncome REAL,
  totalExpenses REAL,
  netSavings REAL,
  lastUpdated TEXT
); 
''';
  }

  /// create triggers to notify dashboard by updates
  /// update after crud on income
  static String createTriggerAfterInsertIncome(CrudType type) {
    return '''
CREATE TRIGGER update_dashboard_income_${type.crudName}
AFTER ${type.crudName} ON $incomeTable
BEGIN
  UPDATE $statisticsTable
  SET totalIncome = (SELECT SUM(incomeValue) FROM $incomeTable),
      netSavings = (SELECT SUM(incomeValue) FROM $incomeTable) - (SELECT SUM(expenseValue) FROM $expensesTable),
      lastUpdated = datetime('now');
END;
''';
  }

  static String createTriggerAfterCrudOnExpenses(CrudType type) {
    return '''
CREATE TRIGGER update_dashboard_expense_${type.crudName}
AFTER ${type.crudName} ON $expensesTable
BEGIN
  UPDATE $statisticsTable
  SET totalExpenses = (SELECT SUM(expenseValue) FROM $expensesTable),
      netSavings = (SELECT SUM(incomeValue) FROM $incomeTable) - (SELECT SUM(expenseValue) FROM $expensesTable),
      lastUpdated = datetime('now');
END;
''';
  }

  static String get inializeDashboard {
    return '''

    INSERT INTO $statisticsTable (totalIncome, totalExpenses, netSavings, lastUpdated)
    SELECT 
      (SELECT COALESCE(SUM(incomeValue), 0) FROM $incomeTable) AS totalIncome,
      (SELECT COALESCE(SUM(expenseValue), 0) FROM $expensesTable) AS totalExpenses,
      (SELECT COALESCE(SUM(incomeValue), 0) FROM $incomeTable) - (SELECT COALESCE(SUM(expenseValue), 0) FROM $expensesTable) AS netSavings,
      datetime('now') AS lastUpdated;
''';
  }
}

enum CrudType {
  insert('INSERT'),
  update('UPDATE'),
  delete('DELETE');

  final String crudName;

  const CrudType(this.crudName);
}
