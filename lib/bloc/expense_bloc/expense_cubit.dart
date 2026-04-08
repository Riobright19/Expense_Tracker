import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_state.dart';
export 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    emit(ExpenseLoading());
    try {
      final expenses = await repository.getExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (_) {
      emit(ExpenseError("Failed to load expenses"));
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await repository.addExpense(expense);
      await loadExpenses();
    } catch (_) {
      emit(ExpenseError("Failed to add expense"));
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await repository.updateExpense(expense);
      await loadExpenses();
    } catch (_) {
      emit(ExpenseError("Failed to add expense"));
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await repository.deleteExpense(id);
      await loadExpenses();
    } catch (_) {
      emit(ExpenseError("Failed to delete expense"));
    }
  }
}
