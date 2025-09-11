import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AllBooksBuilder extends StatelessWidget {
  const AllBooksBuilder({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Books', style: TextStyles.getSize24()),
        Gap(15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 280,
          ),
          itemBuilder: (context, index) {
            return BookCard(product: products[index]);
          },
          itemCount: 10,
        ),
      ],
    );
  }
}
