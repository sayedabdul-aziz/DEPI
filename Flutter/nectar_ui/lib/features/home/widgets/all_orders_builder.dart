import 'package:flutter/material.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';
import 'package:nectar_ui/features/home/model/order_model.dart';
import 'package:nectar_ui/features/home/widgets/recent_orders.dart';

class AllOrdersBuilder extends StatelessWidget {
  const AllOrdersBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
          itemBuilder: (context, index) {
            var product = products[index];
            return RecentCardUi(model: product);
          },
          itemCount: products.length,
        ),
      ],
    );
  }
}
