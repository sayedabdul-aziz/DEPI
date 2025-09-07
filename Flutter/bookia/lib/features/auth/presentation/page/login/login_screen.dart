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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: Image.asset(AppImages.back, width: 41, height: 41),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _blocListener,
        child: _loginBody(),
      ),
      bottomNavigationBar: _goToSignUp(context),
    );
  }

  void _blocListener(BuildContext context, AuthState state) {
    if (state is AuthSuccessState) {
      pushAndRemoveUntil(context, Routes.main);
    } else if (state is AuthErrorState) {
      pop(context);
      showErrorDialog(context, state.error);
    } else {
      showLoadingDialog(context);
    }
  }

  Padding _loginBody() {
    var cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text(
                'Welcome back! Glad to see you, Again!',
                style: TextStyles.getSize30(),
              ),
              Gap(30),
              CustomTextField(
                controller: cubit.emailController,
                hintText: 'Enter your email',
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
                hintText: 'Enter your password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password?',
                      style: TextStyles.getSize16(),
                    ),
                  ),
                ],
              ),
              Gap(30),
              MainButton(
                text: 'Login',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
              ),
              Gap(38),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    '  Or Login with  ',
                    style: TextStyles.getSize16(fontSize: 14),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              Gap(30),
              socialButtons(),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _goToSignUp(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? ", style: TextStyles.getSize16()),
          TextButton(
            onPressed: () {
              pushWithReplacement(context, Routes.register);
            },
            child: Text(
              'Sign Up',
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
