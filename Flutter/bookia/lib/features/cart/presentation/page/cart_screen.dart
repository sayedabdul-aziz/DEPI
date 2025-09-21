import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: cartListBuilder(),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text('Total:', style: TextStyles.getSize18()),
                      const Spacer(),
                      Text(
                        cubit.cartResponse?.data?.total ?? '',
                        style: TextStyles.getSize18(),
                      ),
                    ],
                  ),
                  const Gap(10),
                  MainButton(text: 'Checkout', onPressed: () {}),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  cartListBuilder() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        var books = cubit.cartResponse?.data?.cartItems ?? [];
        if (state is! CartSuccessState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (books.isEmpty == true) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.wishlistSvg,
                  height: 100,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                const Gap(20),
                Text('No books in wishlist'),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return CartItemCard(
              product: books[index],
              onUpdate: (newQuantity) {
                cubit.updateCart(books[index].itemId ?? 0, newQuantity);
              },
              onDelete: () {
                cubit.removeFromCart(books[index].itemId ?? 0);
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: books.length,
        );
      },
    );
  }
}
