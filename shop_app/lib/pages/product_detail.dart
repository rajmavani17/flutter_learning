import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'sizes': selectedSize,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added succesfully'),
           
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Select a Size'),
           
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Image.asset(
            widget.product['imageUrl'] as String,
          ),
          Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Color.fromRGBO(239, 238, 249, 1),
                borderRadius: BorderRadius.circular(67)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize =
                                  (widget.product['sizes'] as List<int>)[index];
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedSize == size
                                ? Color.fromRGBO(196, 211, 197, 1)
                                : Color.fromRGBO(239, 238, 249, 1),
                            label: Text(
                              size.toString(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(350, 50),
                    ),
                    onPressed: onTap,
                    child: Text(
                      'Add to Cart',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
