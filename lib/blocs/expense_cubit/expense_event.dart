part of 'expense_cubit.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;
  UpdateExpense(this.expense);
}

class DeleteExpense extends ExpenseEvent {
  final String id;
  DeleteExpense(this.id);
}
