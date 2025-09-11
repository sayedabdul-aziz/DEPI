import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/all_books_builder.dart';
import 'package:bookia/features/home/presentation/widgets/best_sellers_builder.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:bookia/features/home/presentation/widgets/new_arrivals_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: SvgPicture.asset(AppImages.logoSvg, height: 30),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImages.searchSvg),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            if (state is HomeLoadingState || state is HomeErrorState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    HomeSlider(sliders: cubit.sliders),
                    Gap(20),
                    BestSellersBuilder(products: cubit.bestSellers),
                    Gap(20),
                    NewArrivalsBuilder(products: cubit.newArrivals),
                    Gap(20),
                    AllBooksBuilder(products: cubit.allBooks),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
