import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kouider/feature/product/cubit/product_cubit.dart';
import 'package:kouider/feature/product/widget/app_bar_widget.dart';
import 'package:kouider/feature/product/widget/product_list_widget.dart';
import 'package:kouider/feature/product/widget/title_screen.dart';
import 'package:kouider/feature/product/widget/title_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ProductCubit>(),
      child: Scaffold(
        floatingActionButton: CircleAvatar(
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Sort by Price'),
                        onTap: () {
                          context.read<ProductCubit>().setSortCriteria('price');
                          Navigator.pop(context);  // Close bottom sheet
                        },
                      ),
                      ListTile(
                        title: const Text('Sort by Date'),
                        onTap: () {
                          context.read<ProductCubit>().setSortCriteria('date');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('Sort Alphabetically'),
                        onTap: () {
                          context.read<ProductCubit>().setSortCriteria('alphabetical');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.sort),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: "المفضلة"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "عربة التسوق"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "المزيد"),
          ],
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppBarWidget(),
                  TitleWidget(),
                  FilterButtonWidget(),
                  ProductListWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
