import 'dart:math';

import 'package:expense_app/models/expense_model.dart';
import 'package:expense_app/widgets/add_new_expense_item.dart';
import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<ExpenseModel> expenses = [];

  void _addOpenExpensesOverlay() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return AddNewExpenseItem(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final index = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(15),
        content: Text(
          'Expense Deleted',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                expenses.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget expenseListContent = Center(
      child: Text(
        'No Expenses Found!!',
        style: TextStyle(
          fontSize: 32,
        ),
      ),
    );

    if (expenses.isNotEmpty) {
      expenseListContent = ExpensesList(
        expensesList: expenses,
        onDismissed: _removeExpense,
      );
    }

    final height = (MediaQuery.of(context).size.height);
    final width = (MediaQuery.of(context).size.width);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _addOpenExpensesOverlay,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: width < 750
          ? Column(
              children: [
                Chart(expenses: expenses),
                Expanded(
                  child: expenseListContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: expenses),
                ),
                Expanded(
                  child: expenseListContent,
                ),
              ],
            ),
    );
  }
}
