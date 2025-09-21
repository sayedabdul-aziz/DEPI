class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessState extends WishlistState {}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState({required this.message});
}
