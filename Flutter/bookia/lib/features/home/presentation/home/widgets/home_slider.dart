import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.sliders});

  final List<SliderModel> sliders;

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildSlider(), Gap(14), _buildIndicator()]);
  }

  CarouselSlider _buildSlider() {
    return CarouselSlider.builder(
      itemCount: widget.sliders.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          GestureDetector(
            onTap: () {
              // launchUrl(Uri.parse('https://pub.dev/packages/url_launcher'));
              // launchUrl(Uri.parse('https://wa.me/+20101010101010'));
              // launchUrl(Uri.parse('tel:+20101010101010'));
              // launchUrl(Uri.parse('sms:+20101010101010'));
              // launchUrl(Uri.parse('geo:31.33,30.44'));
              // launchUrl(
              //   Uri.parse('https://maps.app.goo.gl/Bn1MnAxhahu4ooZUA?g_st=ac'),
              // );
              // launchUrl(
              //   Uri.parse(
              //     'mailto:zV6eF@example.com?subject="Flutter Developer"&body="Hello, I am Flutter Developer"',
              //   ),
              // );

              pushTo(context, Routes.location);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.sliders[itemIndex].image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
      options: CarouselOptions(
        height: 150,
        viewportFraction: 1,
        initialPage: 0,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  SmoothPageIndicator _buildIndicator() {
    return SmoothPageIndicator(
      controller: PageController(initialPage: _currentIndex),
      count: widget.sliders.length,
      effect: ExpandingDotsEffect(
        dotColor: AppColors.borderColor,
        dotHeight: 7,
        dotWidth: 7,
        activeDotColor: AppColors.primaryColor,
        expansionFactor: 5,
      ),
      onDotClicked: (index) {},
    );
  }
}
