import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/presentation/home/widgets/book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewArrivalsBuilder extends StatelessWidget {
  const NewArrivalsBuilder({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('new_arrivals'.tr(), style: TextStyles.getSize24()),
            TextButton(
              onPressed: () {},
              child: Text(
                'see_all'.tr(),
                style: TextStyles.getSize16(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        Gap(15),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10);
            },
            itemBuilder: (BuildContext context, int index) {
              return BookCard(product: products[index], source: 'new');
            },
          ),
        ),
      ],
    );
  }
}
