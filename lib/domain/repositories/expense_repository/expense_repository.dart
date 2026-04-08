import 'package:expense_tracker/app_barrel.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future addExpense(Expense expense);
  Future updateExpense(Expense expense);
  Future deleteExpense(String id);
}
