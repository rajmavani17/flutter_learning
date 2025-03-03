import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/category_data.dart';
import 'package:shop/models/category_model.dart';

import 'package:shop/models/grocery_item_model.dart';
import 'package:shop/pages/add_new_item_page.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({super.key});

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  List<GroceryItemModel> _groceryItems = [];
  bool isLoading = false;
  bool isUpdatingData = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _loadItems();
  }

  Future<void> _loadItems() async {
    final List<GroceryItemModel> loadedItems = [];

    try {
      final url = Uri.https(
          'shopping-list-app-8ca63-default-rtdb.asia-southeast1.firebasedatabase.app',
          'shopping-list.json');
      final response = await http.get(url);

      final listData = json.decode(response.body);
      if (response.statusCode >= 400) {
        throw Exception('An Unexcepted Error Occurred\nPlease try Again.');
      }
      if (listData == null || listData.isEmpty) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        GroceryItemModel model = GroceryItemModel(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        );
        loadedItems.add(model);
      }
      setState(() {
        isLoading = false;
        _groceryItems = loadedItems;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    return;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewItemPage(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
      isLoading = false;
    });
  }

  void _removeItem(GroceryItemModel item) async {
    final index = _groceryItems.indexOf(item);
    bool isUndoed = false;
    setState(() {
      _groceryItems.remove(item);
    });

    final snackBarFuture = ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: Duration(
              seconds: 3,
            ),
            content: Row(
              children: [
                Flexible(
                  child: Text(
                    "After Closing the Item will be permanentely deleted",
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // _groceryItems.insert(index, item);
                  isUndoed = true;
                }),
          ),
        )
        .closed;
    SnackBarClosedReason reason = await snackBarFuture;
    print(reason);
    final url = Uri.https(
        'shopping-list-app-8ca63-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list/${item.id}.json/');

    if (!isUndoed) {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        setState(() {
          _groceryItems.insert(index, item);
        });
      }
    } else if (isUndoed) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  void _editItemCall(GroceryItemModel item) async {
    setState(() {
      isUpdatingData = true;
    });
    final url = Uri.https(
        'shopping-list-app-8ca63-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list/${item.id}.json/');

    final response = await http.put(
      url,
      body: json.encode(
        {
          'name': item.name,
          'quantity': item.quantity,
          'category': item.category.title,
        },
      ),
    );

    final resData = json.decode(response.body);
    int index = _groceryItems.indexWhere((data) {
      return item.id == data.id;
    });
    final category = categories.entries
        .firstWhere((catItem) => catItem.value.title == resData['category'])
        .value;
    setState(() {
      isUpdatingData = false;
      _groceryItems.removeAt(index);
      _groceryItems.insert(
        index,
        GroceryItemModel(
          id: item.id,
          name: resData['name'],
          quantity: resData['quantity'],
          category: category,
        ),
      );
    });

    if (!context.mounted) {
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void _editItem(GroceryItemModel item) {
    final formKey = GlobalKey<FormState>();
    String updatedTitle = item.name;
    int updatedQuantity = item.quantity;
    CategoryModel updatedCategory = item.category;

    showModalBottomSheet(
      context: context,
      elevation: 1,
      useSafeArea: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: updatedTitle,
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
                  onChanged: (value) {
                    updatedTitle = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                    label: Text('Title'),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Quantity',
                    label: Text('Quantity'),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: updatedQuantity.toString(),
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
                  onChanged: (value) {
                    updatedQuantity = int.parse(value);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  value: updatedCategory,
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
                      updatedCategory = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                  ),
                  onPressed: isUpdatingData
                      ? null
                      : () {
                          _editItemCall(
                            GroceryItemModel(
                              id: item.id,
                              name: updatedTitle,
                              quantity: updatedQuantity,
                              category: updatedCategory,
                            ),
                          );
                        },
                  child: isUpdatingData
                      ? SizedBox(
                          height: 15,
                          width: 16,
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text('Item Name')),
              Expanded(child: Text('Quantity')),
            ],
          ),
          leading: SizedBox(
            width: 75,
            child: Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          trailing: Text(
            'Actions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (context, index) {
              final item = _groceryItems[index];
              return Dismissible(
                key: ValueKey(item.id),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you wish to delete this item?"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              _removeItem(item);
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 255, 207, 207)),
                            ),
                            child: const Text(
                              "DELETE",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 207, 255, 210)),
                            ),
                            child: const Text(
                              "CANCEL",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                          child: Text(
                        item.name,
                        textAlign: TextAlign.center,
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                        '${item.quantity}',
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                  leading: SizedBox(
                    width: 75,
                    child: Center(
                      child: SizedBox(
                        child: (item.category.image),
                      ),
                    ),
                  ),
                  trailing: SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _editItem(item);
                          },
                          icon: Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _removeItem(item);
                          },
                          icon: Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    if (isLoading) {
      content = Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (!isLoading && _groceryItems.isEmpty) {
      content = Center(
        child: Text('No Items added yet!!'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shopping List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
