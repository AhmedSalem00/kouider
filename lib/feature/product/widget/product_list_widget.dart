import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kouider/feature/product/cubit/product_cubit.dart';
import 'package:kouider/feature/product/cubit/product_state.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 10; // Set this according to the data you get

  @override
  void initState() {
    super.initState();
    _fetchProducts(currentPage);
  }

  // Fetch products for a specific page
  void _fetchProducts(int page) {
    context.read<ProductCubit>().fetchProducts(
      minPrice: 0,
      maxPrice: 10000,
      sortCriteria: 'price',
      sortArrangement: 'DESC',
      category: 'assorted-bakeries',
      page: page,
      productsPerPage: 5,
    );
  }

  // Load next page
  void _loadNextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
      _fetchProducts(currentPage);
    }
  }

  // Load previous page
  void _loadPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      _fetchProducts(currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is ProductLoaded) {
          final products = state.products;

          if (products.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,

                controller: _scrollController,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.orange.shade100,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.grey,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${product.price.toStringAsFixed(0)} جم',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.group,
                                    size: 16.0,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '7-8 أفراد',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: const Text(
                                      '45: 50 دقيقة',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '${product.price.toStringAsFixed(0)} EGP',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous Button
                  ElevatedButton(
                    onPressed: _loadPreviousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color for the button
                    ),
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 20),
                  // Next Button
                  ElevatedButton(
                    onPressed: _loadNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color for the button
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(child: Text('No data available.'));
      },
    );
  }
}
