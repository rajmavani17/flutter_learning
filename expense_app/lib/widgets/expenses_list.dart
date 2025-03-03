import 'package:expense_app/models/expense_model.dart';
import 'package:expense_app/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onDismissed,
  });

  final List<ExpenseModel> expensesList;
  final void Function(ExpenseModel expense) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) {
        final expense = expensesList[index];
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
          ),
          key: ValueKey(expense),
          onDismissed: (direction) {
            onDismissed(expense);
          },
          child: ExpenseItem(
            expenseItem: expense,
          ),
        );
      },
    );
  }
}
