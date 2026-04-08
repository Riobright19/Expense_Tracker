import 'package:expense_tracker/app_barrel.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final List<Expense> _storage = [];

  @override
  Future<List<Expense>> getExpenses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _storage;
  }

  @override
  Future addExpense(Expense expense) async {
    _storage.add(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    final index = _storage.indexWhere((e) => e.id == expense.id);
    if (index == -1) {
      throw StateError('Expense with id ${expense.id} not found');
    }
    _storage[index] = ExpenseModel.fromEntity(expense);
  }

  @override
  Future deleteExpense(String id) async {
    _storage.removeWhere((e) => e.id == id);
  }
}
