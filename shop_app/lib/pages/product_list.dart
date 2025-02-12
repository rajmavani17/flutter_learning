import 'package:flutter/material.dart';
import 'package:shop_app/utils/dummy_data.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final filters = ['All', 'Bata', 'Adidas', 'Nike', 'WildCraft', 'Tracker'];
  late String selectedFilter;

  late int currentPage = 0;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueGrey,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                      selectedFilter = filter;
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Color.fromRGBO(196, 211, 197, 1)
                          : Color.fromRGBO(239, 238, 249, 1),
                      side: BorderSide(
                        color: Colors.blueGrey,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      label: Text(
                        filter,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 650) {
                  return ProductGridView();
                } else {
                  return ProductListView();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGridView extends StatefulWidget {
  const ProductGridView({super.key});

  @override
  State<ProductGridView> createState() => ProductGridViewState();
}

class ProductGridViewState extends State<ProductGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.5),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ProductDetailPage(product: product);
                }),
              );
            },
            child: ProductCard(
              title: product['title'] as String,
              price: product['price'] as double,
              image: product['imageUrl'] as String,
              backgroundColor: index.isOdd
                  ? Color.fromRGBO(140, 208, 243, 1)
                  : Color.fromRGBO(210, 235, 240, 1),
            ),
          );
        });
  }
}

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ProductDetailPage(product: product);
              }),
            );
          },
          child: ProductCard(
            title: product['title'] as String,
            price: product['price'] as double,
            image: product['imageUrl'] as String,
            backgroundColor: index.isOdd
                ? Color.fromRGBO(140, 208, 243, 1)
                : Color.fromRGBO(210, 235, 240, 1),
          ),
        );
      },
    );
  }
}
