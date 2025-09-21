import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
  });

  final CartItem product;
  final Function() onDelete;
  final Function(int) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: product.itemProductImage ?? '',
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.itemProductName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.getSize18(),
                          ),
                          Gap(5),
                          Text(
                            '\$${product.itemProductPriceAfterDiscount}',
                            style: TextStyles.getSize16(),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((product.itemQuantity ?? 1) > 1) {
                              onUpdate((product.itemQuantity ?? 1) - 1);
                            } else {
                              showMyDialog(
                                context,
                                'Minimum quantity is 1',
                                type: DialogType.warning,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Gap(10),
                        SizedBox(
                          width: 20,
                          child: Text(
                            product.itemQuantity.toString(),
                            style: TextStyles.getSize16(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            if ((product.itemQuantity ?? 1) <
                                (product.itemProductStock ?? 1)) {
                              onUpdate((product.itemQuantity ?? 1) + 1);
                            } else {
                              showMyDialog(
                                context,
                                'Maximum quantity is ${product.itemProductStock}',
                                type: DialogType.warning,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Total: \$${((product.itemProductPriceAfterDiscount ?? 0) * (product.itemQuantity ?? 1)).toStringAsFixed(1)}',
                      style: TextStyles.getSize16(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
