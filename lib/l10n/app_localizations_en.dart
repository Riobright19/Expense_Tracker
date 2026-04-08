// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Expense Tracker';

  @override
  String get title => 'Title';

  @override
  String get amount => 'Amount';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get noExpenses => 'No expenses added yet';

  @override
  String get retry => 'Retry';

  @override
  String get invalidNumber => 'Enter valid number';

  @override
  String get requiredField => 'This field is required';
}
