import 'package:expense_tracker/app_barrel.dart';

part 'expense_state.dart';
part 'expense_event.dart';

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
