import 'dart:developer';

import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/home/data/models/books_list_response/books_list_response.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];
  List<Product> bestSellers = [];
  List<Product> newArrivals = [];
  List<Product> allBooks = [];

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    try {
      var res = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSellers(),
        HomeRepo.getNewArrivals(),
        HomeRepo.getAllBooks(),
      ]);

      sliders = (res[0] as SliderResponse).data?.sliders ?? [];
      bestSellers = (res[1] as BooksListResponse).data?.products ?? [];
      newArrivals = (res[2] as BooksListResponse).data?.products ?? [];
      allBooks = (res[3] as BooksListResponse).data?.products ?? [];
      emit(HomeLoadedState());
    } on Exception catch (e) {
      log(e.toString());
      emit(HomeErrorState(message: "Something went wrong"));
    }
  }

  addRemoveToWishlist(int productId) async {
    emit(HomeLoadingState());

    if (isWishlist(productId)) {
      var data = await WishlistRepo.removeFromWishlist(productId: productId);
      if (data != null) {
        emit(WishlistCartSuccessState(message: 'Removed from wishlist'));
      } else {
        emit(HomeErrorState(message: "Something went wrong"));
      }
    } else {
      var data = await WishlistRepo.addToWishlist(productId: productId);
      if (data != null) {
        emit(WishlistCartSuccessState(message: 'Added to wishlist'));
      } else {
        emit(HomeErrorState(message: "Something went wrong"));
      }
    }
  }

  addToCart(int productId) async {
    emit(HomeLoadingState());

    var data = await CartRepo.addToCart(productId: productId);
    if (data != null) {
      emit(WishlistCartSuccessState(message: 'Added to Cart'));
    } else {
      emit(HomeErrorState(message: "Something went wrong"));
    }
  }

  bool isWishlist(int productId) {
    var wishlist = LocalHelper.getWishlist();

    return wishlist?.any((e) => e.id == productId) ?? false;
  }
}
