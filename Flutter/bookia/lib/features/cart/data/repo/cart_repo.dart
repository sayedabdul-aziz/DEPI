import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/place_order_params.dart';

class CartRepo {
  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToCart,
        data: {"product_id": productId},
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
      var res = await DioProvider.get(endpoint: ApiEndpoints.cart);

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

  static Future<bool> checkout() async {
    try {
      var res = await DioProvider.get(endpoint: ApiEndpoints.checkout);

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> placeOrder({required PlaceOrderParams params}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.placeOrder,
        data: params.toJson(),
      );

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
