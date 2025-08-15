class ProductModel {
  final String name;
  final String image;
  final String price;
  final String quantity;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

List<ProductModel> products = [
  ProductModel(
    name: 'Burger',
    image: 'assets/images/categories/pngfuel 6.png',
    price: '9.99',
    quantity: '1',
  ),
  // ProductModel(
  //   name: 'Pizza',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '12.99',
  //   quantity: '1',
  // ),
  // ProductModel(
  //   name: 'Taco',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '7.99',
  //   quantity: '1',
  // ),
  // ProductModel(
  //   name: 'Burger1',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '9.99',
  //   quantity: '1',
  // ),
  // ProductModel(
  //   name: 'Pizza1',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '12.99',
  //   quantity: '1',
  // ),
  // ProductModel(
  //   name: 'Taco1',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '7.99',
  //   quantity: '1',
  // ),
  // ProductModel(
  //   name: 'Burger2',
  //   image: 'assets/images/categories/pngfuel 6.png',
  //   price: '9.99',
  //   quantity: '1',
  // ),
];
