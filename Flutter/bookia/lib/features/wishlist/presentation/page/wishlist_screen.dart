import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Wishlist')),
        body: wishlistListBuilder(),
      ),
    );
  }

  wishlistListBuilder() {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        var cubit = context.read<WishlistCubit>();
        if (state is! WishlistSuccessState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.books.isEmpty) {
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
            return WishlistCard(
              product: cubit.books[index],
              onDelete: () {
                cubit.removeFromWishlist(cubit.books[index].id ?? 0);
              },
              onRefresh: () {
                cubit.getWishlist();
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: cubit.books.length,
        );
      },
    );
  }
}
