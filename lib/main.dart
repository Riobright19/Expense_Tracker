import 'package:expense_tracker/bloc/expense_bloc/expense_cubit.dart';
import 'package:expense_tracker/data/repository_impl.dart';
import 'package:expense_tracker/l10n/app_localizations.dart';
import 'package:expense_tracker/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final repository = ExpenseRepositoryImpl();
  runApp(MyApp(repository));
}

class MyApp extends StatefulWidget {
  final ExpenseRepositoryImpl repository;
  const MyApp(this.repository, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(String code) {
    setState(() => _locale = Locale(code));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseCubit(widget.repository)..loadExpenses(),
      child: MaterialApp(
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('es')],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: ExpenseScreen(onLanguageChange: _changeLanguage),
      ),
    );
  }
}
