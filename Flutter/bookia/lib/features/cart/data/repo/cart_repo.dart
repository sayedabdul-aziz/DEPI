import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';

class CartRepo {
  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToCart,
        data: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${LocalHelper.getUserData()?.token}",
        },
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        // LocalHelper.setCart(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {
          "Authorization": "Bearer ${LocalHelper.getUserData()?.token}",
        },
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);
        // LocalHelper.setCart(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {
          "Authorization": "Bearer ${LocalHelper.getUserData()?.token}",
        },
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        // LocalHelper.setCart(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> getCartBooks() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.cart,
        headers: {
          "Authorization": "Bearer ${LocalHelper.getUserData()?.token}",
        },
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);
        // LocalHelper.setWishlist(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
