import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/place_order_params.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartResponse? cartResponse;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var governorateController = TextEditingController();
  int selectedGovernorateId = -1;

  initData() {
    var userData = LocalHelper.getUserData()?.user;
    nameController.text = userData?.name ?? '';
    emailController.text = userData?.email ?? '';
    addressController.text = userData?.address ?? '';
    phoneController.text = userData?.phone ?? '';
    governorateController.text = '';
  }

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
    CartRepo.updateCart(cartItemId: cartItemId, quantity: quantity).then((
      value,
    ) {
      if (value == null) {
        emit(CartErrorState(message: "Something went wrong"));
      } else {
        cartResponse = value;
        emit(CartSuccessState());
      }
    });
  }

  checkout() {
    emit(CheckoutLoadingState());
    CartRepo.checkout().then((value) {
      if (value) {
        emit(CheckoutSuccessState());
      } else {
        emit(CartErrorState(message: "Something went wrong"));
      }
    });
  }

  placeOrder() {
    emit(CheckoutLoadingState());
    var params = PlaceOrderParams(
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      phone: phoneController.text,
      governorateId: selectedGovernorateId,
    );
    CartRepo.placeOrder(params: params).then((value) {
      if (value) {
        emit(CheckoutSuccessState());
      } else {
        emit(CartErrorState(message: "Something went wrong"));
      }
    });
  }
}
