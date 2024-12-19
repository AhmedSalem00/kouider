import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kouider/core/data/model/product_model.dart';
import 'package:kouider/core/netwoking/api_service.dart';
import 'package:kouider/feature/product/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  String sortArrangement = 'DESC';
  bool isLoading = false;
  int currentPage = 1;

  Future<void> fetchProducts({
    required double minPrice,
    required double maxPrice,
    required String sortCriteria,
    required String sortArrangement,
    required String category,
    required int page,
    required int productsPerPage,
  }) async {
    if (isLoading) return;

    try {
      isLoading = true;
      emit(ProductLoading());

      final List<ProductModel> products = await ApiService.fetchProducts(
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortCriteria: sortCriteria,
        sortArrangement: sortArrangement,
        category: category,
        page: page,
        productsPerPage: productsPerPage,
      );

      if (products.isEmpty) {
        emit(ProductError(message: "No products found"));
      } else {
        emit(ProductLoaded(products: products));

      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    } finally {
      isLoading = false;
    }
  }



  void setSortCriteria(String criteria) {
    sortArrangement = 'DESC';
    fetchProducts(
      minPrice: 0,
      maxPrice: 10000,
      sortCriteria: criteria,
      sortArrangement: sortArrangement,
      category: 'assorted-bakeries',
      page: currentPage,
      productsPerPage: 5,
    );
  }

}







