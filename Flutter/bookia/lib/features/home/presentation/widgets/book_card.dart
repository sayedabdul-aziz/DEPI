import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.cover,
                width: 150,
              ),
            ),
          ),
          Gap(5),
          SizedBox(
            height: 42,
            child: Text(
              product.name ?? '',
              style: TextStyles.getSize16(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price}', style: TextStyles.getSize18()),
              MainButton(
                width: 70,
                height: 30,
                borderRadius: 4,
                bgColor: AppColors.darkColor,
                text: 'Buy',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
