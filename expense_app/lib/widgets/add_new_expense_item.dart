// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:expense_app/models/expense_model.dart';

class AddNewExpenseItem extends StatefulWidget {
  const AddNewExpenseItem({
    super.key,
    required this.onAddExpense,
  });

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<AddNewExpenseItem> createState() => _AddNewExpenseItemState();
}

class _AddNewExpenseItemState extends State<AddNewExpenseItem> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showPresentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (dialogContext) {
            return CupertinoAlertDialog(
              title: Text(
                'Invalid Input',
              ),
              content: Text(
                'Please Make sure a valid title, amount, date and category is selected',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Okay',
                  ),
                ),
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Invalid Input',
            ),
            content: Text(
              'Please Make sure a valid title, amount, date and category is selected',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Okay',
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _submitExpenseDate() {
    final amount = double.tryParse(_amountController.text);
    final isAmountInValid = amount == null || amount <= 0;
    final title = _titleController.text.trim();
    if (title.isEmpty ||
        isAmountInValid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      _showDialog();
      return;
    }
    final expense = ExpenseModel(
      title: title,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    Widget addNewExpenseItem =
        LayoutBuilder(builder: (builderContext, constraints) {
      final width = constraints.maxWidth;
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 24, 16, keyboardSpace + 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: InputDecoration(
                          label: Text(
                            'Title',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          label: Text(
                            'Amount',
                          ),
                          prefix: Text(
                            '₹ ',
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: InputDecoration(
                    label: Text(
                      'Title',
                    ),
                  ),
                ),
              if (width >= 600)
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      hint: Text('Select Category'),
                      items: Category.values.map(
                        (category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : dateFormatter.format(
                                    _selectedDate!,
                                  ),
                          ),
                          IconButton(
                            onPressed: _showPresentDatePicker,
                            icon: Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          label: Text(
                            'Amount',
                          ),
                          prefix: Text(
                            '₹ ',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : dateFormatter.format(
                                    _selectedDate!,
                                  ),
                          ),
                          IconButton(
                            onPressed: _showPresentDatePicker,
                            icon: Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              if (width >= 600)
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseDate();
                      },
                      child: Text(
                        'Save',
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      hint: Text('Select Category'),
                      items: Category.values.map(
                        (category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseDate();
                      },
                      child: Text(
                        'Save',
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
    return addNewExpenseItem;
  }
}
