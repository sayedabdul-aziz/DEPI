import 'package:flutter/material.dart';
import 'package:nectar_ui/core/extentions/navigation.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';
import 'package:nectar_ui/core/utils/text_styles.dart';
import 'package:nectar_ui/features/details/product_details_screen.dart';
import 'package:nectar_ui/features/home/model/order_model.dart';

class RecentOrdersBuilder extends StatelessWidget {
  const RecentOrdersBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Orders', style: TextStyles.getTitle()),
            TextButton(
              onPressed: () {},
              child: Text('See All', style: TextStyles.getSmall()),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var product = products[index];
              return RecentCardUi(model: product);
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemCount: 1,
          ),
        ),
      ],
    );
  }
}

class RecentCardUi extends StatelessWidget {
  const RecentCardUi({super.key, required this.model});

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, ProductDetailsScreen(model: model));
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xff53B175).withValues(alpha: .1),
          border: Border.all(color: Color(0XFF53B175).withValues(alpha: .7)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: model.name,
                child: Image.asset(
                  model.image,
                  width: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              model.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              'Size: ${model.quantity}',
              style: TextStyle(color: AppColors.greyColor),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '\$${model.price}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                FloatingActionButton(
                  heroTag: UniqueKey(),
                  onPressed: () {},
                  mini: true,
                  elevation: 0,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
