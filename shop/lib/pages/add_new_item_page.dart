import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop/data/category_data.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/grocery_item_model.dart';

class AddNewItemPage extends StatefulWidget {
  const AddNewItemPage({super.key});

  @override
  State<AddNewItemPage> createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final _formKey = GlobalKey<FormState>();

  String _enteredTitle = '';
  int _enteredQuantity = 1;
  CategoryModel _selectedCategory = categories[Categories.vegetables]!;
  bool isSendingData = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isSendingData = true;
      });
      final url = Uri.https(
          'shopping-list-app-8ca63-default-rtdb.asia-southeast1.firebasedatabase.app',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredTitle,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.title,
          },
        ),
      );
      if (!context.mounted) {
        return;
      }
      final Map<String, dynamic> data = json.decode(response.body);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(
        GroceryItemModel(
          id: data['name'],
          name: _enteredTitle,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a New Item',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Enter a Valid Title of at least length 2';
                  }
                  if (value.trim().length > 50) {
                    return 'Enter a Valid Title of length less than 50';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  label: Text('Title'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Quantity',
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Valid Quantity';
                        }
                        if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Enter a Valid Quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value ?? '1');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: (category.value.image),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  category.key.name,
                                ),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSendingData
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: isSendingData ? null : _saveItem,
                    child: isSendingData
                        ? SizedBox(
                            height: 15,
                            width: 16,
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
