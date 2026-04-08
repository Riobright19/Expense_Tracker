import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/expense_model.dart';

abstract class ExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  ExpenseLoaded(this.expenses);

  //  ExpenseLoaded copyWith({List<Expense>? expenses, String? error}) {
  //   return ExpenseLoaded(expenses: expenses ?? this.expenses, error: error);
  // }

  @override
  List<Object?> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String message;
  ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
