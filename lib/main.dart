import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kouider/feature/product/cubit/product_cubit.dart';
import 'package:kouider/feature/product/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (context) => ProductCubit(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductScreen(),
        ),
        );
    }
}

