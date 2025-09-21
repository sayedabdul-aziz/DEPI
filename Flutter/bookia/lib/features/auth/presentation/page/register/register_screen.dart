import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _blocListener,
        child: _signupBody(),
      ),
      bottomNavigationBar: _goToSignIn(context),
    );
  }

  void _blocListener(BuildContext context, AuthState state) {
    if (state is AuthSuccessState) {
      pushAndRemoveUntil(context, Routes.main);
    } else if (state is AuthErrorState) {
      pop(context);
      showMyDialog(context, state.error);
    } else {
      showLoadingDialog(context);
    }
  }

  Padding _signupBody() {
    var cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text(
                'Hello! Register to get started',
                style: TextStyles.getSize30(),
              ),
              Gap(30),
              CustomTextField(
                controller: cubit.usernameController,
                hintText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              Gap(20),
              CustomTextField(
                controller: cubit.emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              Gap(20),
              CustomTextField(
                isPassword: true,
                controller: cubit.passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Gap(20),
              CustomTextField(
                isPassword: true,
                controller: cubit.passwordConfirmationController,
                hintText: 'Confirmation password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),

              Gap(30),
              MainButton(
                text: 'Register',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _goToSignIn(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account? ", style: TextStyles.getSize16()),
          TextButton(
            onPressed: () {
              pushWithReplacement(context, Routes.login);
            },
            child: Text(
              'Sign In',
              style: TextStyles.getSize16(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Row socialButtons() {
    return Row(
      spacing: 8,
      children: [
        SocialButton(iconPath: AppImages.googleSvg, onTap: () {}),
        SocialButton(iconPath: AppImages.facebookSvg, onTap: () {}),
        SocialButton(iconPath: AppImages.appleSvg, onTap: () {}),
      ],
    );
  }
}
