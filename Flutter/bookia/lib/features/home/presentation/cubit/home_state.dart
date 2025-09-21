class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class WishlistCartSuccessState extends HomeState {
  final String message;
  WishlistCartSuccessState({required this.message});
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}
