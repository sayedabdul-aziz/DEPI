import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.product,
    required this.source,
  });

  final Product product;
  final String source;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is WishlistCartSuccessState) {
          pop(context);
          showMyDialog(context, state.message, type: DialogType.success);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialog(context, state.message);
        } else if (state is HomeLoadingState) {
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBarWithBack(
            actionWidget: IconButton(
              onPressed: () {
                cubit.addRemoveToWishlist(product.id ?? 0);
              },
              icon: SvgPicture.asset(
                AppImages.wishlistSvg,
                colorFilter: ColorFilter.mode(
                  cubit.isWishlist(product.id ?? 0)
                      ? AppColors.primaryColor
                      : AppColors.darkColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${product.price}', style: TextStyles.getSize24()),
                  Gap(40),
                  Expanded(
                    child: MainButton(
                      height: 55,
                      borderRadius: 8,
                      bgColor: AppColors.darkColor,
                      text: 'Add to Cart',
                      onPressed: () {
                        cubit.addToCart(product.id ?? 0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Hero(
                      tag: product.key ?? '',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: product.image ?? '',
                          height: 280,
                        ),
                      ),
                    ),
                    Gap(20),
                    Text(product.name ?? '', style: TextStyles.getSize24()),
                    Gap(10),
                    Text(
                      product.category ?? '',
                      style: TextStyles.getSize16(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap(20),
                    Text(
                      product.description ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyles.getSize16(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
