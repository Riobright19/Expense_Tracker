import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/bloc/expense_bloc/expense_cubit.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements ExpenseRepository {}

void main() {
  late MockRepository repository;
  late ExpenseCubit cubit;

  setUp(() {
    repository = MockRepository();
    cubit = ExpenseCubit(repository);
  });

  final expenses = [
    Expense(id: "1", title: "Test", amount: 100, date: DateTime.now()),
  ];

  blocTest<ExpenseCubit, ExpenseState>(
    'emits [Loading, Loaded] when loading expenses',
    build: () {
      when(() => repository.getExpenses()).thenAnswer((_) async => expenses);
      return cubit;
    },
    act: (cubit) => cubit.loadExpenses(),
    expect: () => [ExpenseLoading(), ExpenseLoaded(expenses)],
  );
}
