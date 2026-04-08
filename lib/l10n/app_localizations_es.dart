// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Rastreador de Gastos';

  @override
  String get title => 'Título';

  @override
  String get amount => 'Cantidad';

  @override
  String get addExpense => 'Agregar Gasto';

  @override
  String get noExpenses => 'No hay gastos aún';

  @override
  String get retry => 'Reintentar';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get requiredField => 'Campo obligatorio';
}
