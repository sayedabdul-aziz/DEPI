class ApiEndpoints {
  static const String baseUrl = 'https://codingarabic.online/api';

  // auth
  static const String login = '/login';
  static const String register = '/register';

  // home
  static const String productsBestSeller = '/products-bestseller';
  static const String productsNewArrival = '/products-new-arrivals';
  static const String allProducts = '/products';
  static const String sliders = '/sliders';

  // wishlist
  static const String wishlist = '/wishlist';
  static const String addToWishlist = '/add-to-wishlist';
  static const String removeFromWishlist = '/remove-from-wishlist';

  // cart
  static const String cart = '/cart';
  static const String addToCart = '/add-to-cart';
  static const String removeFromCart = '/remove-from-cart';
  static const String updateCart = '/update-cart';

  static const String checkout = '/checkout';
  static const String placeOrder = '/place-order';
}
