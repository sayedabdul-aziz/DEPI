import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/home/data/models/books_list_response/books_list_response.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';

class HomeRepo {
  static Future<SliderResponse?> getSliders() async {
    try {
      var res = await DioProvider.get(endpoint: ApiEndpoints.sliders);
      if (res.statusCode == 200) {
        return SliderResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<BooksListResponse?> getBestSellers() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.productsBestSeller,
      );
      if (res.statusCode == 200) {
        return BooksListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<BooksListResponse?> getNewArrivals() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.productsNewArrival,
      );
      if (res.statusCode == 200) {
        return BooksListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<BooksListResponse?> getAllBooks([int pageIndex = 1]) async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.allProducts,
        queryParameters: {'page': pageIndex},
      );
      if (res.statusCode == 200) {
        return BooksListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
