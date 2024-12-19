import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kouider/core/data/model/product_model.dart';


class ApiService {
  static const String apiUrl = 'https://stg.koueider.com/wp-json/apis/v2/products/filter';

  static Future<List<ProductModel>> fetchProducts({
    required double minPrice,
    required double maxPrice,
    required String sortCriteria,
    required String sortArrangement,
    required String category,
    required int page,
    required int productsPerPage,
  }) async {
    try {
      final uri = Uri.parse(
        '$apiUrl?price_range[]=$minPrice&price_range[]=$maxPrice&sort[criteria]=$sortCriteria&sort[arrangement]=$sortArrangement&page=$page&category=$category&products_per_page=$productsPerPage',
      );

      debugPrint('Request URL: $uri');

      final response = await http.get(uri);

      debugPrint('API Response Status Code: ${response.statusCode}');

      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('products') && responseBody['products'] != null) {
          final List<dynamic> products = responseBody['products'];
          if (products.isNotEmpty) {
            return products.map((json) => ProductModel.fromJson(json)).toList();
          } else {
            debugPrint('No products found in the response data.');
            throw Exception('No products data found in the response.');
          }
        } else {
          debugPrint('No "products" key found in the response.');
          throw Exception('No products data found in the response.');
        }
      } else {
        debugPrint('API Error Response: ${response.body}');
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      throw Exception('Failed to load products: $e');
    }
  }
}
