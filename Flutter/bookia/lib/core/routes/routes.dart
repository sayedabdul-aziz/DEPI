import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register/register_screen.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/place_order_screen.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/details/page/book_details_screen.dart';
import 'package:bookia/features/home/presentation/home/page/location_screen.dart';
import 'package:bookia/features/home/presentation/home/page/web_view.dart';
import 'package:bookia/features/main/presentation/page/main_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String bookDetails = '/bookDetails';
  static const String placeOrder = '/placeOrder';
  static const String editProfile = '/editProfile';
  static const String webPage = '/webPage';
  static const String location = '/location';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: main,
        builder: (context, state) =>
            MainAppScreen(initialIndex: state.extra as int?),
      ),
      GoRoute(
        path: bookDetails,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: BookDetailsScreen(
              product: args["product"] as Product,
              source: args["source"] as String,
            ),
          );
        },
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => CartCubit()..initData(),
            child: PlaceOrderScreen(totalAmount: state.extra as String),
          );
        },
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit()..initData(),
            child: EditProfileScreen(),
          );
        },
      ),
      GoRoute(path: webPage, builder: (context, state) => WebViewScreen()),
      GoRoute(path: location, builder: (context, state) => LocationScreen()),
    ],
  );
}
