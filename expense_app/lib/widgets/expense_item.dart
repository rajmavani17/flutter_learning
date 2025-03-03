import 'package:expense_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expenseItem,
  });

  final ExpenseModel expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '₹ ${expenseItem.amount.toStringAsFixed(2)}',
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expenseItem.category],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      expenseItem.category.name,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      expenseItem.formattedDate,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
