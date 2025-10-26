import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/auth/presentation/page/doctor_registeration_screen.dart';
import 'package:se7ety/features/auth/presentation/page/login_screen.dart';
import 'package:se7ety/features/auth/presentation/page/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/patient/booking/presentation/booking_view.dart';
import 'package:se7ety/features/patient/home/presentation/page/home_search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/page/specialization_search_screen.dart';
import 'package:se7ety/features/patient/main/nav_bar.dart';
import 'package:se7ety/features/patient/profile/page/settings_view.dart';
import 'package:se7ety/features/patient/search/page/doctor_profile_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String doctorRegistration = '/doctorRegistration';
  static const String mainPatient = '/mainPatient';
  static const String specializationSearch = '/specializationSearch';
  static const String homeSearch = '/homeSearch';
  static const String doctorProfile = '/doctorProfile';
  static const String bookingScreen = '/bookingScreen';
  static const String settings = '/settings';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: doctorRegistration,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: DoctorRegistrationScreen(),
        ),
      ),
      GoRoute(
        path: mainPatient,
        builder: (context, state) => PatientMainAppScreen(),
      ),
      GoRoute(
        path: specializationSearch,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
      GoRoute(
        path: homeSearch,
        builder: (context, state) =>
            HomeSearchScreen(searchKey: state.extra as String),
      ),
      GoRoute(
        path: doctorProfile,
        builder: (context, state) =>
            DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
      ),
      GoRoute(
        path: bookingScreen,
        builder: (context, state) =>
            BookingScreen(doctor: state.extra as DoctorModel),
      ),
      GoRoute(path: settings, builder: (context, state) => SettingsScreen()),
    ],
  );
}
