import 'package:expense_tracker/data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future addExpense(Expense expense);
  Future updateExpense(Expense expense);
  Future deleteExpense(String id);
}
