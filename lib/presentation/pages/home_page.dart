import 'package:expense_tracker/app_barrel.dart';

class ExpenseScreen extends StatefulWidget {
  final Function(String) onLanguageChange;
  const ExpenseScreen({super.key, required this.onLanguageChange});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final uuid = const Uuid();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final expense = Expense(
      id: uuid.v4(),
      title: titleController.text.trim(),
      amount: double.parse(amountController.text.trim()),
      date: DateTime.now(),
    );

    context.read<ExpenseCubit>().addExpense(expense);

    titleController.clear();
    amountController.clear();
  }

  Future<void> _showEditExpenseDialog(
    BuildContext context, {
    required AppLocalizations loc,
    required Expense expense,
  }) async {
    final editFormKey = GlobalKey<FormState>();
    final editTitleController = TextEditingController(text: expense.title);
    final editAmountController = TextEditingController(
      text: expense.amount.toString(),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(loc.title),
          content: Form(
            key: editFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: editTitleController,
                  decoration: InputDecoration(labelText: loc.title),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.requiredField;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: editAmountController,
                  decoration: InputDecoration(labelText: loc.amount),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.requiredField;
                    }
                    if (double.tryParse(value) == null) {
                      return loc.invalidNumber;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (!editFormKey.currentState!.validate()) return;

                final updated = Expense(
                  id: expense.id,
                  title: editTitleController.text.trim(),
                  amount: double.parse(editAmountController.text.trim()),
                  date: expense.date,
                );

                context.read<ExpenseCubit>().updateExpense(updated);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          PopupMenuButton<String>(
            onSelected: widget.onLanguageChange,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'es', child: Text('Español')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: loc.title),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.requiredField;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(labelText: loc.amount),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.requiredField;
                      }
                      if (double.tryParse(value) == null) {
                        return loc.invalidNumber;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(loc.addExpense),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ExpenseError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<ExpenseCubit>().loadExpenses(),
                          child: Text(loc.retry),
                        ),
                      ],
                    ),
                  );
                }

                if (state is ExpenseLoaded) {
                  if (state.expenses.isEmpty) {
                    return Center(child: Text(loc.noExpenses));
                  }

                  return ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (_, index) {
                      final e = state.expenses[index];
                      return ListTile(
                        title: Text(e.title),
                        subtitle: Text("₹${e.amount}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditExpenseDialog(
                                context,
                                loc: loc,
                                expense: e,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<ExpenseCubit>().deleteExpense(
                                  e.id,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
