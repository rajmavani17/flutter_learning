import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                radius: 35,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_sharp),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Delete Product",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: Text(
                          'Are you sure you want to remove the product?',
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 121, 169, 251),
                            ),
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .deleteProduct(cartItem);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 245, 117, 117),
                            ),
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size : ${cartItem['sizes']}'),
            );
          }),
    );
  }
}
