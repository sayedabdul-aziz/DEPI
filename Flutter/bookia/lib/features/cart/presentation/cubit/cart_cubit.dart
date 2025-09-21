import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartResponse? cartResponse;

  getCart() {
    emit(CartLoadingState());
    CartRepo.getCartBooks().then((value) {
      if (value == null) {
        emit(CartErrorState(message: "Something went wrong"));
      } else {
        cartResponse = value;
        emit(CartSuccessState());
      }
    });
  }

  removeFromCart(int productId) {
    emit(CartLoadingState());
    CartRepo.removeFromCart(cartItemId: productId).then((value) {
      if (value == null) {
        emit(CartErrorState(message: "Something went wrong"));
      } else {
        cartResponse = value;
        emit(CartSuccessState());
      }
    });
  }

  updateCart(int cartItemId, int quantity) {
    emit(CartLoadingState());
    CartRepo.updateCart(cartItemId: cartItemId, quantity: quantity).then((value) {
      if (value == null) {
        emit(CartErrorState(message: "Something went wrong"));
      } else {
        cartResponse = value;
        emit(CartSuccessState());
      }
    });
  }
}
