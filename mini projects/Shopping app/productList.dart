// ignore: depend_on_referenced_packages
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping/widgets/Cart.dart';
import 'package:shopping/globalVaiables.dart';
import 'package:shopping/pages/products_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Nike',
    'Puma',
    'Ascis',
    'Addidas',
  ];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final border = const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoe\nCollections ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search_outlined),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : Color.fromRGBO(255, 255, 255, 1),
                      side: BorderSide(color: Color.fromRGBO(248, 248, 248, 1)),
                      label: Text(
                        filter,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(67),
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
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    itemCount: contents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = contents[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Detailsofproducts(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCart(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imagesUrl'] as String,
                          backgroundcolor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: contents.length,
                    itemBuilder: (context, index) {
                      final product = contents[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Detailsofproducts(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCart(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imagesUrl'] as String,
                          backgroundcolor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
/* We can also use the LayoutBuilder for the reprsenting the apps strucuture whenever you are 
used to represent the same set of functionality in multiple environments 
but still stil we can go with grid view builder for website sty;e reprsentation .
And more thing we can also the MediaQuery for the adjusting the height and width of the components in our project 
or else we can also go with the LayoutBuilder widget we can also able to set the height and width to it by manually to it so tht it will 
fix it has the height and width to it but in some scenarois  it can be an overflow or else may be an 
underflow we can go with the GridLayoutBuilder for big time and lot of images and components to show in app or website .*/
