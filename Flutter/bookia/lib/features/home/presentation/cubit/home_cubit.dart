import 'dart:developer';

import 'package:bookia/features/home/data/models/books_list_response/books_list_response.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
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
      emit(HomeErrorState());
    }
  }
}
